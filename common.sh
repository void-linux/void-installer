#! /bin/sh
#
# common.sh
# Copyright © 2014 tox <tox@rootkit>
#
# Distributed under terms of the MIT license.
#

LSBLK_OPTS='-P -o NAME,FSTYPE,MOUNTPOINT,SIZE,TYPE'

disk_menu() {
	while read line; do
		eval "$line"
		[ "x$TYPE" = "x$1" ] || continue

		if [ "x$1" = "xpart" ]; then
			TYPE="$FSTYPE"
		fi

		if [ "x$TYPE" = "x" ]; then
			TYPE="unkown"
		fi

		echo "$NAME"
		echo "${BLUE}type:${RESET} $TYPE  ${BLUE}size:${RESET} $SIZE"
	done | xargs -d '\n' $DIALOG --menu "$MENU_LABEL" $MENUSIZE
}

select_disk() {
	lsblk $LSBLK_OPTS | disk_menu disk
}

select_partition() {
	lsblk $LSBLK_OPTS | disk_menu part
}
