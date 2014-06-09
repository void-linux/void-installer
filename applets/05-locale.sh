#! /bin/sh
#
# 05-locale.sh
# Copyright © 2014 tox <tox@rootkit>
#
# Distributed under terms of the MIT license.
#


menu_add MAIN locale "Set system locale"
MAIN_locale() {
    result=`grep -E '\.UTF-8' /etc/default/libc-locales | \
		awk '{print $1}' | sed -e 's/^#//;s/$/ ./' | \
		xargs $DIALOG --title "Select your locale" --menu "$MENU_LABEL" 14 70 14 `
	if [ $? = 0 ]; then
		set_option LOCALE "$result"
	fi
}
