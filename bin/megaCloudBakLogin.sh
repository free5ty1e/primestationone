#!/bin/bash
#source "/home/pi/primestationone/reference/lib/primestation_bash_functions.sh"



OUTPUT="~/temp/megatemp.txt"

echo Creating empty temp file...
rm $OUTPUT
touch $OUTPUT

dialog --title "LOGIN TO MEGA.CO.NZ" --backtitle "EMAIL: For existing users of mega.co.nz" --inputbox "Please enter your email address to login to Mega.co.nz (one that already has an account with them)" 0 0>$OUTPUT
# get response
response=$?
# get data stored in $OUPUT using input redirection
email=$(<$OUTPUT)
echo "email address captured: $email, response was $response"

echo Creating empty temp file...
rm $OUTPUT
touch $OUTPUT

dialog --title "LOGIN TO MEGA.CO.NZ" --backtitle "PASSWORD: For existing users of mega.co.nz" --inputbox "Please enter your password to login to Mega.co.nz for user with email $email" 0 0>$OUTPUT
# get response
response=$?
# get data stored in $OUPUT using input redirection
password=$(<$OUTPUT)
echo "password captured: $password, response was $response"

cat > /home/pi/.megarc << _EOF_
#!/bin/bash
[Login]
Username = $email
Password = $password
_EOF_

echo Testing out your new mega.co.nz connected cloud storage...
megals
megadf
echo If you just saw a listing of your cloud drive contents and information about the space used, then your login is now configured and ready to utilize cloud backup!
