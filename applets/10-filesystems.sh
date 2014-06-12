#! /bin/sh
#
# 10-filesystems.sh
# Copyright © 2014 tox <tox@rootkit>
#
# Distributed under terms of the MIT license.
#

confirm_mkfs() {
	$DIALOG --yesno "Do you really want to create a new filesystem on $dev?\n${RED}Warning: All data will be lost${RESET}" ${YESNOSIZE}
	if [ $? = 0 ]; then
		$@ 2>&1 | $DIALOG --progressbox "$*" 20 40
	else
		return 1;
	fi
}

select_mountpoint() {
	$DIALOG --inputbox "Please specify the mount point for $1:" ${INPUTSIZE}
}

menu_add FSTYPE "reuse" "Reuse this filesystem"
FSTYPE_reuse() {
	local dev=$1
	# TODO
}
menu_add FSTYPE "swap" "Linux swap"
FSTYPE_swap() {
	dev=$1
	confirm_mkfs mkswap -- "$dev" || return
	blkid=`blkid "$dev" -o value | head -n1`

	task_add "FSTAB" "$dev" "echo 'UUID=$blkid swap swap defaults 0 0' >> etc/fstab"
}

menu_add FSTYPE "btrfs" "Oracle's Btrfs"
menu_add FSTYPE "ext2" "Linux ext2 (no journaling)"
menu_add FSTYPE "ext3" "Linux ext3 (journal)"
menu_add FSTYPE "ext4" "Linux ext4 (journal)"
menu_add FSTYPE "f2fs" "Flash-Friendly Filesystem"
menu_add FSTYPE "vfat" "FAT32"
menu_add FSTYPE "xfs" "SGI's XFS"
FSTYPE_select() {
	local type="$1" dev="$2"
	mntpoint=`select_mountpoint $dev`
	confirm_mkfs "mkfs" -t "$type" "$dev" || return
	blkid=`blkid "$dev" -o value | head -n1`

	task_add "FSTAB" "$dev" "echo 'UUID=$blkid $mntpoint $type defaults 0 0' >> etc/fstab"
}


menu_add MAIN filesystems "Configure filesystems and mount points"
MAIN_filesystems() {
	local

	while true; do
		dev=`select_partition`
		[ $? -ne 0 ] && return

		menu FSTYPE "Select the filesystem type for $dev" $dev

		if [ $? -ne 0 ]; then
			continue
		fi
    done
}
