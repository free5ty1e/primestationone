sudo killall fbi >/dev/null 2>&1
dialog --infobox "\nFirst boot - Resizing the filesystem ..." 5 60
sudo raspi-config nonint do_expand_rootfs >/dev/null 2>&1
sleep 2
dialog --infobox "\nDone. Rebooting ..." 5 60
sudo rm -f /etc/profile.d/01-expand.sh
sleep 2
sudo reboot

