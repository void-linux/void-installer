#! /bin/sh
#
# 08-bootloader.sh
# Copyright © 2014 tox <tox@rootkit>
#
# Distributed under terms of the MIT license.
#


menu_add MAIN bootloader "Set disk to install bootloader"
MAIN_bootloader() {
	result=`$DIALOG --title "Select the disk to install the bootloader" \
		--menu "$MENU_LABEL" ${MENUSIZE} $(show_disks)`
	if [ $? -eq 0 ]; then
		set_option BOOTLOADER "$result"
	fi
	sleep 2
}
