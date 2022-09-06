#!/bin/bash

echo ""

# set -e

# Text Outline
RESET='\033[0m'
BOLD='\033[1m'
ITALIC='\033[3m'
UNDERLINE='\033[4m'
BLINKING='\033[5m'

# Get user
USERNAME=$SUDO_USER
HOME_DIR=$(eval echo ~${SUDO_USER})
# Ask for Sudo Permission
# [ "$UID" -eq 0 ] || exec sudo bash "$0" "$@"

# echo "Script by resyfer (Saurav Pal)"
echo -e " "$BOLD$UNDERLINE'National Institute of Technology, Silchar'$RESET

echo -e "\tScript By "$BOLD"Saurav Pal, Cloud Moderator, GDSC NIT Silchar"$RESET

echo ""
echo -e "Hello" $BOLD$USERNAME$RESET
echo "Setup proxy for NIT Silchar"

echo ""

echo -e $BOLD"**The script will ask for sudo permission if not provided.**"$RESET

echo ""

# Get Values
## read -e -p "Enter College Initials > " -i "NITS" COLLEGE
## read -e -p "Enter Proxy Domain > " -i "172.16.199.40" PROXY_DOMAIN
## read -e -p "Enter Proxy Port > " -i "8080" PROXY_PORT

# College Name
COLLEGE=NITS
# echo -n "Enter College Initials [NITS]> "
# read
# [ "$REPLY" != "" ] && COLLEGE=$REPLY

# echo ""

GNOME=YES
echo -n -e "GNOME Desktop Environment? Y/n ["$ITALIC"Y"$RESET"]> "
read

if [[ "$REPLY" == "y" || "$REPLY" == "Y" || "$REPLY" == "" ]]; then
  GNOME=YES
else
  GNOME=NO
fi

echo ""

# Proxy Domain
PROXY_DOMAIN=172.16.199.41
echo "Choose Proxy Domain:"
echo -e "    1) "$BOLD"172.16.199.41"$RESET "(BH9)"
echo -e "    2) "$BOLD"172.16.199.20"$RESET "(Labs & Library)"
echo -e "    3) "$BOLD"172.16.199.40"$RESET "(Other Hostels)"
echo -e "    4) "$BOLD"None"$RESET "(Personal Internet)"
echo -n -e "Enter Choice ["$ITALIC"1"$RESET"]> "
read

case $REPLY in

  1)
    PROXY_DOMAIN=172.16.199.41
    ;;

  2)
    PROXY_DOMAIN=172.16.199.20
    ;;

  3)
    PROXY_DOMAIN=172.16.199.40
    ;;

  4)
    PROXY_DOMAIN="none"
    ;;

esac

echo ""

# Proxy Port
PROXY_PORT=8080
echo -n -e "Enter Proxy Port ["$ITALIC"8080"$RESET"]> "
read
[ "$REPLY" != "" ] && PROXY_PORT=$REPLY

unset REPLY

echo ""

echo "Updating Proxies"

unset http_proxy

if [[ $? -ne 0 ]] ; then
  return
fi

unset https_proxy

if [[ "$PROXY_DOMAIN" != "none" ]]; then

  URL="http:\/\/${PROXY_DOMAIN}:${PROXY_PORT}"

  # ~/.bashrc
  sudo sed -i "s/.*#HTTP ${COLLEGE}/export http_proxy=${URL}\/ #HTTP ${COLLEGE}/" $HOME_DIR/.bashrc

  if [[ $? -ne 0 ]] ; then
    return
  fi

  sudo sed -i "s/.*#HTTPS ${COLLEGE}/export https_proxy=${URL}\/ #HTTPS ${COLLEGE}/" $HOME_DIR/.bashrc

  export http_proxy="http://${PROXY_DOMAIN}:${PROXY_PORT}"

  if [[ $? -ne 0 ]] ; then
    return
  fi

  export https_proxy="http://${PROXY_DOMAIN}:${PROXY_PORT}"

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

  # Git Proxy Settings
  git config --global http.proxy http://${PROXY_DOMAIN}:${PROXY_PORT}
  git config --global https.proxy http://${PROXY_DOMAIN}:${PROXY_PORT}

  # NPM Proxy Settings
  npm config set proxy http://${PROXY_DOMAIN}:${PROXY_PORT}
  npm config set https-proxy http://${PROXY_DOMAIN}:${PROXY_PORT}

  # Gnome Proxy Settings
  if [[ "$GNOME" == "YES" ]]; then
    gsettings set org.gnome.system.proxy mode 'manual'

    if [[ $? -ne 0 ]] ; then
      return
    fi

    gsettings set org.gnome.system.proxy.http host "${PROXY_DOMAIN}"
    gsettings set org.gnome.system.proxy.http port "${PROXY_PORT}"

    gsettings set org.gnome.system.proxy.https host "${PROXY_DOMAIN}"
    gsettings set org.gnome.system.proxy.https port "${PROXY_PORT}"

  fi

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

  if [[ $? -ne 0 ]] ; then
    return
  fi

  sudo sed -i "s/.*#HTTPS ${COLLEGE}/unset https_proxy #HTTPS ${COLLEGE}/" $HOME_DIR/.bashrc

  # Git Proxy Settings
  git config --global --unset http.proxy
  git config --global --unset https.proxy

  # NPM Proxy Settings
  npm config rm proxy
  npm config rm https-proxy

  if [[ "$GNOME" == "YES" ]]; then
    gsettings set org.gnome.system.proxy mode 'none'
  fi

  if [[ $? -ne 0 ]] ; then
    return
  fi

  echo -n ".."

fi

echo -n ".."
echo "Done"
echo ""
echo -e $BOLD"Proxy Updated"$RESET
