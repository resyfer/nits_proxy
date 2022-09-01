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
echo " "$BOLD$UNDERLINE'National Institute of Technology, Silchar'$RESET
echo -e "\tScript By "$BOLD"Saurav Pal, Cloud Moderator, GDSC NIT Silchar"$RESET

echo ""
echo "Bye bye" $BOLD$USERNAME$RESET
echo "Uninstall proxy for script 🥺"

echo ""

echo $BOLD"**The script will ask for sudo permission if not provided.**"$RESET

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
echo -n "GNOME Desktop Environment? Y/n ["$ITALIC"Y"$RESET"]> "
read

if [[ "$REPLY" == "y" || "$REPLY" == "Y" || "$REPLY" == "" ]]; then
  GNOME=YES
else
  GNOME=NO
fi

echo ""

unset http_proxy

if [[ $? -ne 0 ]] ; then
  return
fi

unset https_proxy

FILES=(
  /etc/apt/apt.conf
  /etc/bash.bashrc
  /etc/environment
  $HOME/.bashrc
)

for FILE in ${FILES[@]}; do

  sudo sed -i "s/.*${COLLEGE}//" $FILE
  echo -n ".."

done

sudo sed -i "s/.*${COLLEGE}//" $HOME_DIR/.bashrc

if [[ $? -ne 0 ]] ; then
  return
fi

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

echo -n ".."
echo "Done"
echo ""
echo $BOLD"Proxy Updated"$RESET
