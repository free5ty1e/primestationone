#!/bin/bash

#TODO: Refactor out some reasonable functions into our library below to simplify this sort of dialog capture task
#source "/home/pi/primestationone/reference/lib/primestation_bash_functions.sh"



dialog --title "Inputbox - To take input from you" --backtitle "Linux Shell\
Script Tutorial" --inputbox "Enter your name please" 8 60 2>/tmp/input.$$

sel=$?

na=`cat /tmp/input.$$`
case $sel in
0) echo "Hello $na" ;;
1) echo "Cancel is Press" ;;
255) echo "[ESCAPE] key pressed" ;;
esac

rm -f /tmp/input.$$



OUTPUT="/home/pi/temp/megatemp.txt"


echo Creating empty temp file...
>$OUTPUT

dialog --title "LOGIN TO MEGA.CO.NZ" --backtitle "EMAIL: For existing users of mega.co.nz" --inputbox "Please enter your email address to login to Mega.co.nz (one that already has an account with them)" 0 0 >$OUTPUT
# get response
response=$?
# get data stored in $OUPUT using input redirection
email=$(<$OUTPUT)
echo "email address captured: $email, response was $response"

echo Creating empty temp file...
>$OUTPUT

dialog --title "LOGIN TO MEGA.CO.NZ" --backtitle "PASSWORD: For existing users of mega.co.nz" --inputbox "Please enter your password to login to Mega.co.nz for user with email $email" 0 0 >$OUTPUT
# get response
response=$?
# get data stored in $OUPUT using input redirection
password=$(<$OUTPUT)
echo "password captured: $password, response was $response"

cat > /home/pi/.megarc << _EOF_
[Login]
Username = $email
Password = $password
_EOF_

# remove $OUTPUT file
rm $OUTPUT

echo Testing out your new mega.co.nz connected cloud storage...
megals
megadf
echo If you just saw a listing of your cloud drive contents and information about the space used, then your login is now configured and ready to utilize cloud backup!
