#! /bin/sh
#
# 03-hostname.sh
# Copyright © 2014 tox <tox@rootkit>
#
# Distributed under terms of the MIT license.
#


menu_add MAIN "hostname" "Set system hostname"
MAIN_hostname() {
	hostname=`config_get hostname`
	result=`$DIALOG --inputbox "Set the machine hostname:" ${INPUTSIZE} \
		"$hostname"`
	if [ $? -eq 0 ]; then
		set_option HOSTNAME "$result"
	fi
}
