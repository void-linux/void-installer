#! /bin/sh
#
# 05-locale.sh
# Copyright © 2014 tox <tox@rootkit>
#
# Distributed under terms of the MIT license.
#


menu_add MAIN locale "Set system locale"
MAIN_locale() {
	locales=`grep '\.UTF-8 ' /etc/default/libc-locales | sed -e 's/^#//;s/ .*$/ ./'`
	while : ; do
		unset lang spec
		lang=`echo "$locales" | sed 's/_[^ ]*//' | sort -u | \
			xargs $DIALOG --title "Select your locale" --menu "$MENU_LABEL" 14 70 14 `
		[ $? = 0 ] || return 1;

		spec=`echo "$locales" | grep "^${lang}_" | sed "s/[^_]*_//" | \
			xargs $DIALOG --title "Select your locale" --menu "$MENU_LABEL" 14 70 14 `
		result=${lang}_${spec}
		[ $? = 0 ] && break;
	done

	set_option LOCALE "$result"
}
