#!/bin/bash
source "/home/pi/primestationone/reference/lib/primestation_bash_functions.sh"

ask_for_user_input_and_store_result "LOGIN TO MEGA.CO.NZ" --backtitle "EMAIL: For existing users of mega.co.nz" --inputbox "Please enter your email address to login to Mega.co.nz (one that already has an account with them)" 8 60
email="$RESULT"

ask_for_user_input_and_store_result "LOGIN TO MEGA.CO.NZ" --backtitle "PASSWORD: For existing users of mega.co.nz" --inputbox "Please enter your password to login to Mega.co.nz for user with email $email" 8 60
password="$RESULT"

create_megarc_login_file "$email" "$password"

echo Testing out your new mega.co.nz connected cloud storage...
megals
megadf
echo If you just saw a listing of your cloud drive contents and information about the space used, then your login is now configured and ready to utilize cloud backup!
