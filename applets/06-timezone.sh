#! /bin/sh
#
# 06-timezone.sh
# Copyright © 2014 tox <tox@rootkit>
#
# Distributed under terms of the MIT license.
#


menu_add MAIN timezone "Set system time zone"
MAIN_timezone() {
    result=`timedatectl --no-pager list-timezones | \
		sed -e 's/$/ ./' | \
		xargs $DIALOG --title "Select your locale" --menu "$MENU_LABEL" 14 70 14 `
	if [ $? = 0 ]; then
		config_set TIMEZONE "$result"
	fi
}
