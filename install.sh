#!/bin/bash

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
echo -e $BOLD$UNDERLINE'National Institute of Technology, Silchar'$RESET
echo -e "\tScript By "$BOLD"Saurav Pal, Cloud Moderator, GDSC NIT Silchar"$RESET

echo ""
echo -e "Hello" $BOLD$USERNAME$RESET
echo "🚀 Setup proxy for campus"
echo ""

# read -e -p "Enter College Initials: " -i "NITS" COLLEGE

# College Name
COLLEGE=NITS
# echo -n "Enter College Initials [NITS]> "
# read
# [ "$REPLY" != "" ] && COLLEGE=$REPLY


FILES=(
  /etc/apt/apt.conf
  /etc/bash.bashrc
  /etc/environment
  $HOME_DIR/.bashrc
)

echo "The script will ask for sudo access if not granted."

echo ""


GNOME=YES
echo -n "Are you using GNOME Desktop Environment? Y/n [Y]> "
read
if [[ "$REPLY" == "y" || "$REPLY" == "Y" || "$REPLY" == "" ]]; then
  GNOME=YES
else
  GNOME=NO
fi

if [[ "$GNOME" == "YES" ]]; then
  gsettings set org.gnome.system.proxy ignore-hosts "['localhost', '127.0.0.0/8', '::1', '*.local']"
fi

echo -n "Setting Up..."

for FILE in ${FILES[@]}; do

  sudo echo "" >> $FILE
  sudo echo "" >> $FILE
  sudo echo "# ${COLLEGE}" >> $FILE
  sudo echo "#HTTP ${COLLEGE}" >> $FILE
  sudo echo "#HTTPS ${COLLEGE}" >> $FILE

  echo -n ".."

done

sudo cp nitsproxy.sh /bin
echo "" >> $HOME_DIR/.bashrc
echo "# ${COLLEGE}" >> $HOME_DIR/.bashrc
echo "alias nits='source nitsproxy.sh' #NITS" >> $HOME_DIR/.bashrc
echo "######################### NITS" >> $HOME_DIR/.bashrc

echo "Done"
echo "Setup successful"
