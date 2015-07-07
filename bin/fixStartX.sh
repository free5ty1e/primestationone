#!/bin/bash
echo Fixing common startx windowed mode issues...


pushd ~

echo Clearing your Xauthority and xsession-errors files...
mv .Xauthority .Xauthority.backup
rm .xsession-errors

echo Ensuring permissions...
sudo chmod 777 /home/pi

echo Generating known good xinitrc...
cat << EOF > ~/.xinitrc
xset s off # don't activate screensaver
xset -dpms # disable DPMS (Energy Star) features.
xset s noblank # don't blank the video device
exec /etc/alternatives/x-session-manager # start lxde
EOF

echo startx should now be fixed!

popd
