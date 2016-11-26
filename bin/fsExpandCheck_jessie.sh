#!/bin/sh
#Jessie Expand
#http://www.pghpunkid.com/2016/06/raspberry-pi-auto-expand-file-system-shell-script/
#If a reboot loop occurs, can stop it by placing a blank file in /boot called NOCHECKUPDATE (on the fat32 partition)
get_init_sys() {
  if command -v systemctl > /dev/null && systemctl | grep -q '\-\.mount'; then
    SYSTEMD=1
  elif [ -f /etc/init.d/cron ] && [ ! -h /etc/init.d/cron ]; then
    SYSTEMD=0
  else
    echo "Unrecognised init system"
    return 1
  fi
}

do_expand_rootfs() {
  get_init_sys
  if [ $SYSTEMD -eq 1 ]; then
	ROOT_PART=$(mount | sed -n 's|^/dev/\(.*\) on / .*|\1|p')
  else
	if ! [ -h /dev/root ]; then
	  echo "/dev/root does not exist or is not a symlink. Don't know how to expand"
	  return 0
	fi
	ROOT_PART=$(readlink /dev/root)
  fi

  PART_NUM=${ROOT_PART#mmcblk0p}
  if [ "$PART_NUM" = "$ROOT_PART" ]; then
	echo "$ROOT_PART is not an SD card. Don't know how to expand"
	return 0
  fi

  # NOTE: the NOOBS partition layout confuses parted. For now, let's only
  # agree to work with a sufficiently simple partition layout
  if [ "$PART_NUM" -ne 2 ]; then
	echo "Your partition layout is not currently supported by this tool. You are probably using NOOBS, in which case your root filesystem is already expanded anyway."
	return 0
  fi

  LAST_PART_NUM=$(parted /dev/mmcblk0 -ms unit s p | tail -n 1 | cut -f 1 -d:)
  if [ $LAST_PART_NUM -ne $PART_NUM ]; then
	echo "$ROOT_PART is not the last partition. Don't know how to expand"
	return 0
  fi

  # Get the starting offset of the root partition
  PART_START=$(parted /dev/mmcblk0 -ms unit s p | grep "^${PART_NUM}" | cut -f 2 -d: | sed 's/[^0-9]//g')
  [ "$PART_START" ] || return 1
  # Return value will likely be error for fdisk as it fails to reload the
  # partition table because the root fs is mounted
  fdisk /dev/mmcblk0 <<EOF
p
d
$PART_NUM
n
p
$PART_NUM
$PART_START

p
w
EOF
  ASK_TO_REBOOT=1

  # now set up an init.d script
cat <<EOF > /etc/init.d/resize2fs_once &&
#!/bin/sh
### BEGIN INIT INFO
# Provides:          resize2fs_once
# Required-Start:
# Required-Stop:
# Default-Start: 3
# Default-Stop:
# Short-Description: Resize the root filesystem to fill partition
# Description:
### END INIT INFO

. /lib/lsb/init-functions

case "\$1" in
  start)
	log_daemon_msg "Starting resize2fs_once" &&
	resize2fs /dev/$ROOT_PART &&
	update-rc.d resize2fs_once remove &&
	rm /etc/init.d/resize2fs_once &&
	log_end_msg \$?
	;;
  *)
	echo "Usage: \$0 start" >&2
	exit 3
	;;
esac
EOF
  chmod +x /etc/init.d/resize2fs_once &&
  update-rc.d resize2fs_once defaults &&
  if [ "$INTERACTIVE" = True ]; then
	echo "Root partition has been resized.\nThe filesystem will be enlarged upon the next reboot"
  fi
}

UPDATECHECK="/boot/NOUPDATECHECK"
if [ -e "$UPDATECHECK" ]
		then
				$(sudo rm /boot/NOUPDATECHECK)
				return 0
fi

RESIZEFS="/etc/init.d/resize2fs_once"
if [ -e "$RESIZEFS" ]
		then
				return 0
fi

ACTUAL=$(sudo fdisk -l | grep /dev/mmcblk0: | awk '{print $5/1024}')
CURRENT=$(df | grep '/dev/root' | awk '{print $2}')
PERCENT=$(echo $CURRENT $ACTUAL | awk '{printf "%d", $1/$2*100}')
if [ $PERCENT -lt 90 ]
		then
				do_expand_rootfs
				sync
				reboot
fi