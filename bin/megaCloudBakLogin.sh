#!/bin/bash
source "/home/pi/primestationone/reference/lib/primestation_bash_functions.sh"

isPassword=0
ask_for_user_input_and_store_result "LOGIN TO MEGA.CO.NZ" "EMAIL: For existing users of mega.co.nz" "Please enter your email address to login to Mega.co.nz (one that already has an account with them)" $isPassword 8 60
email="$RESULT"

isPassword=1
ask_for_user_input_and_store_result "LOGIN TO MEGA.CO.NZ" "PASSWORD: For existing users of mega.co.nz" "Please enter your password to login to Mega.co.nz for user with email $email" $isPassword 8 60
password="$RESULT"

create_megarc_login_file "$email" "$password"

echo Testing out your new mega.co.nz connected cloud storage...
megals
megadf
echo If you just saw a listing of your cloud drive contents and information about the space used, then your login is now configured and ready to utilize cloud backup!
