#! /bin/sh
#
# 08-bootloader.sh
# Copyright © 2014 tox <tox@rootkit>
#
# Distributed under terms of the MIT license.
#


menu_add MAIN bootloader "Set disk to install bootloader"
MAIN_bootloader() {
	result=`select_disk`
	if [ $? -eq 0 ]; then
		set_option BOOTLOADER "$result"
	fi
}
