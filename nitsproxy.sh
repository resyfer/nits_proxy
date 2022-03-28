#!/bin/bash

# Get user
USERNAME=$SUDO_USER
HOME_DIR=$(eval echo ~${SUDO_USER})

# Ask for Sudo Permission
# [ "$UID" -eq 0 ] || exec sudo bash "$0" "$@"

echo "Script by resyfer (Saurav Pal)"

# Get Values
## read -e -p "Enter College Initials > " -i "NITS" COLLEGE
## read -e -p "Enter Proxy Domain > " -i "172.16.199.40" PROXY_DOMAIN
## read -e -p "Enter Proxy Port > " -i "8080" PROXY_PORT

# College Name
COLLEGE=NITS
echo -n "Enter College Initials [NITS]> "
read
[ "$REPLY" != "" ] && COLLEGE=$REPLY

echo ""

# Proxy Domain
PROXY_DOMAIN=172.16.199.40
echo "Choose Proxy Domain:"
echo "    1) 172.16.199.40 (Hostels)"
echo "    2) 172.16.199.20 (Lab & Library)"
echo "    3) None (Hotspot)"
echo -n "Enter Choice [1]> "
read

case $REPLY in

  1)
    PROXY_DOMAIN=172.16.199.40
    ;;

  2)
    PROXY_DOMAIN=172.16.199.20
    ;;

  3)
    PROXY_DOMAIN="none"
    ;;

esac

echo ""

# Proxy Port
PROXY_PORT=8080
echo -n "Enter Proxy Port [8080]> "
read
[ "$REPLY" != "" ] && PROXY_PORT=$REPLY

unset REPLY

echo "Updating Proxies"

unset http_proxy
unset https_proxy
unset ftp_proxy

if [[ "$PROXY_DOMAIN" != "none" ]]; then

  URL="http:\/\/${PROXY_DOMAIN}:${PROXY_PORT}"

  # ~/.bashrc
  sudo sed -i "s/.*#HTTP ${COLLEGE}/export http_proxy=${URL}\/ #HTTP ${COLLEGE}/" $HOME_DIR/.bashrc
  sudo sed -i "s/.*#HTTPS ${COLLEGE}/export https_proxy=${URL}\/ #HTTPS ${COLLEGE}/" $HOME_DIR/.bashrc
  sudo sed -i "s/.*#FTP ${COLLEGE}/export ftp_proxy=${URL}\/ #FTP ${COLLEGE}/" $HOME_DIR/.bashrc

  export http_proxy="http://${PROXY_DOMAIN}:${PROXY_PORT}"
  export https_proxy="http://${PROXY_DOMAIN}:${PROXY_PORT}"
  export ftp_proxy="http://${PROXY_DOMAIN}:${PROXY_PORT}"

  # /etc/apt/apt.conf
  sudo sed -i "s/.*#HTTP ${COLLEGE}/Acquire::http::Proxy \"${URL}\"; #HTTP ${COLLEGE}/" /etc/apt/apt.conf
  sudo sed -i "s/.*#HTTPS ${COLLEGE}/Acquire::https::Proxy \"${URL}\"; #HTTPS ${COLLEGE}/" /etc/apt/apt.conf

  echo -n ".."

  # /etc/bash.bashrc
  sudo sed -i "s/.*#HTTP ${COLLEGE}/export http_proxy=${URL}\/ #HTTP ${COLLEGE}/" /etc/bash.bashrc
  sudo sed -i "s/.*#HTTPS ${COLLEGE}/export https_proxy=${URL}\/ #HTTPS ${COLLEGE}/" /etc/bash.bashrc

  echo -n ".."

  # /etc/environment
  sudo sed -i "s/.*#HTTP ${COLLEGE}/export http_proxy=\"${URL}\/\" #HTTP ${COLLEGE}/" /etc/environment
  sudo sed -i "s/.*#HTTPS ${COLLEGE}/export https_proxy=\"${URL}\/\" #HTTPS ${COLLEGE}/" /etc/environment

  echo -n ".."

  # Gnome Proxy Settings
  gsettings set org.gnome.system.proxy mode 'manual'

  gsettings set org.gnome.system.proxy.http host "${PROXY_DOMAIN}"
  gsettings set org.gnome.system.proxy.http port "${PROXY_PORT}"

  gsettings set org.gnome.system.proxy.https host "${PROXY_DOMAIN}"
  gsettings set org.gnome.system.proxy.https port "${PROXY_PORT}"

  gsettings set org.gnome.system.proxy.ftp host "${PROXY_DOMAIN}"
  gsettings set org.gnome.system.proxy.ftp port "${PROXY_PORT}"

  echo -n ".."

else

  FILES=(
    /etc/apt/apt.conf
    /etc/bash.bashrc
    /etc/environment
  )

  for FILE in ${FILES[@]}; do

    sudo sed -i "s/.*#HTTP ${COLLEGE}/#HTTP ${COLLEGE}/" $FILE
    sudo sed -i "s/.*#HTTPS ${COLLEGE}/#HTTPS ${COLLEGE}/" $FILE
    echo -n ".."

  done

  sudo sed -i "s/.*#HTTP ${COLLEGE}/unset http_proxy #HTTP ${COLLEGE}/" $HOME_DIR/.bashrc
  sudo sed -i "s/.*#HTTPS ${COLLEGE}/unset https_proxy #HTTPS ${COLLEGE}/" $HOME_DIR/.bashrc
  sudo sed -i "s/.*#HTTPS ${COLLEGE}/unset ftp_proxy #FTP ${COLLEGE}/" $HOME_DIR/.bashrc

  gsettings set org.gnome.system.proxy mode 'none'

  echo -n ".."

fi

echo ".."
echo "Done"
echo "Proxy Update successful"