#!/bin/bash

# Get user
HOME_DIR=$(eval echo ~${SUDO_USER})

# Ask for Sudo Permission
[ "$UID" -eq 0 ] || exec sudo bash "$0" "$@"

echo "Script by resyfer (Saurav Pal)"

# Get Values
read -e -p "Enter College Initials > " -i "NITS" COLLEGE
read -e -p "Enter Proxy Domain > " -i "172.16.199.40" PROXY_DOMAIN
read -e -p "Enter Proxy Port > " -i "8080" PROXY_PORT

echo -n "Updating Proxies"

if [[ "$PROXY_DOMAIN" != "" ]]; then

  URL="http:\/\/${PROXY_DOMAIN}:${PROXY_PORT}"

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

  gsettings set org.gnome.system.proxy mode 'none'

  echo -n ".."

fi

echo "Done"
echo "Proxy Update successful"