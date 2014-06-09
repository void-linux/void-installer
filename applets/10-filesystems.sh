#! /bin/sh
#
# 10-filesystems.sh
# Copyright © 2014 tox <tox@rootkit>
#
# Distributed under terms of the MIT license.
#


menu_add MAIN filesystems "Configure filesystems and mount points"

menu_add FSTYPE "btrfs" "Oracle's Btrfs"
menu_add FSTYPE "ext2" "Linux ext2 (no journaling)"
menu_add FSTYPE "ext3" "Linux ext3 (journal)"
menu_add FSTYPE "ext4" "Linux ext4 (journal)"
menu_add FSTYPE "f2fs" "Flash-Friendly Filesystem"
menu_add FSTYPE "swap" "Linux swap"
menu_add FSTYPE "vfat" "FAT32"
menu_add FSTYPE "xfs" "SGI's XFS"

FSTYPE_select() {
	fstype=$1
	dev=$2

	if [ "$fstype" != "swap" ]; then
		mntpoint=`$DIALOG --inputbox "Please specify the mount point for $dev:" ${INPUTSIZE}`
		[ $? -ne 0 ] && continue
	else
		mntpoint=swap
	fi
	$DIALOG --yesno "Do you want to create a new filesystem on $dev?" ${YESNOSIZE}
	if [ $? -eq 0 ]; then
		reformat=1
	elif [ $? -eq 1 ]; then
		reformat=0
	else
		continue
	fi
	fssize=$(lsblk -nr $dev|awk '{print $4}')
	if [ -n "$fstype" -a -n "$fssize" -a -n "$mntpoint" -a -n "$reformat" ]; then
		local bdev=$(basename $dev)
		sed -i -e "/^MOUNTPOINT \/dev\/${bdev}.*/d" $CONF_FILE
		echo "MOUNTPOINT $dev $fstype $fssize $mntpoint $reformat" >>$CONF_FILE
	fi
}


MAIN_filesystems() {
	local dev fstype fssize mntpoint reformat

	while true; do
		dev=`$DIALOG --title " Select the partition to edit " --menu "$MENULABEL" \
			${MENUSIZE} $(show_partitions)`
		[ $? -ne 0 ] && return

		menu FSTYPE "Select the filesystem type for $dev" $dev

		if [ $? -ne 0 ]; then
			continue
		fi
    done
}
