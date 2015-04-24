#!/bin/bash

#TODO: Refactor out some reasonable functions into our library below to simplify this sort of dialog capture task
#source "/home/pi/primestationone/reference/lib/primestation_bash_functions.sh"

dialog --title "LOGIN TO MEGA.CO.NZ" --backtitle "EMAIL: For existing users of mega.co.nz" --inputbox "Please enter your email address to login to Mega.co.nz (one that already has an account with them)" 8 60 2>/tmp/input.$$
sel=$?
email=`cat /tmp/input.$$`
case $sel in
    0) echo "Email obtained: $email" ;;
    1) echo "Cancel pressed" ;;
    255) echo "[ESCAPE] key pressed" ;;
esac
rm -f /tmp/input.$$

dialog --title "LOGIN TO MEGA.CO.NZ" --backtitle "PASSWORD: For existing users of mega.co.nz" --inputbox "Please enter your password to login to Mega.co.nz for user with email $email" 8 60 2>/tmp/input.$$
sel=$?
password=`cat /tmp/input.$$`
case $sel in
    0) echo "Password obtained: $password" ;;
    1) echo "Cancel pressed" ;;
    255) echo "[ESCAPE] key pressed" ;;
esac
rm -f /tmp/input.$$

echo Creating your .megarc file...
cat > /home/pi/.megarc << _EOF_
[Login]
Username = $email
Password = $password
_EOF_

echo Testing out your new mega.co.nz connected cloud storage...
megals
megadf
echo If you just saw a listing of your cloud drive contents and information about the space used, then your login is now configured and ready to utilize cloud backup!
