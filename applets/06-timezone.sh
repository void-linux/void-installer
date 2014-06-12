#! /bin/sh
#
# 06-timezone.sh
# Copyright © 2014 tox <tox@rootkit>
#
# Distributed under terms of the MIT license.
#


menu_add MAIN timezone "Set system time zone"
MAIN_timezone() {
	tz=`timedatectl --no-pager list-timezones | sed -e 's/$/ ./'`
	while : ; do
		region=`echo "$tz" | sed 's#/[^ ]*##' | sort -u | \
			xargs $DIALOG --title "Select your time zone region" --menu "$MENU_LABEL" 14 70 14 `
		[ $? = 0 ] || return 1;

		city=`echo "$tz" | grep "^${region}/" | sed 's#[^/]*/##' | \
			xargs $DIALOG --title "Select your time zone" --menu "$MENU_LABEL" 14 70 14 `
		[ $? = 0 ] && break;
	done

	get_option TIMEZONE "$result"
}
