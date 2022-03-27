#!/bin/bash

# Get user
HOME_DIR=$(eval echo ~${SUDO_USER})

# Ask for Sudo Permission
# [ "$UID" -eq 0 ] || exec sudo bash "$0" "$@"

echo "Script by resyfer (Saurav Pal)"

# read -e -p "Enter College Initials: " -i "NITS" COLLEGE

# College Name
COLLEGE=NITS
echo -n "Enter College Initials [NITS]> "
read
[ "$REPLY" != "" ] && COLLEGE=$REPLY


FILES=(
  /etc/apt/apt.conf
  /etc/bash.bashrc
  /etc/environment
)

echo -n "Setting Up"

for FILE in ${FILES[@]}; do

  sudo echo "" >> $FILE
  sudo echo "" >> $FILE
  sudo echo "# ${COLLEGE} CONFIG" >> $FILE
  sudo echo "#HTTP ${COLLEGE}" >> $FILE
  sudo echo "#HTTPS ${COLLEGE}" >> $FILE

  echo -n ".."

done

gsettings set org.gnome.system.proxy ignore-hosts "['localhost', '127.0.0.0/8', '::1', '*.local']"
echo -n ".."

sudo cp nitsproxy.sh /bin
echo "" >> $HOME_DIR/.bashrc
echo "# ${COLLEGE} Proxy Alias" >> $HOME_DIR/.bashrc
echo "alias nits='source nitsproxy.sh'" >> $HOME_DIR/.bashrc
echo "#########################" >> $HOME_DIR/.bashrc

echo "Done"
echo "Setup successful"