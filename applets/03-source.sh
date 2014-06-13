#! /bin/sh
#
# 02-source.sh
# Copyright © 2014 tox <tox@rootkit>
#
# Distributed under terms of the MIT license.
#


menu_add MAIN "source" "Set source installation"

MAIN_source() {
	local src=

	result=`$DIALOG --title " Select installation source " \
		--menu "$MENU_LABEL" 8 70 0 \
		"local" "Packages from ISO image" \
		"network" "Packages from official remote reposity"`

	case "$result" in
		"local") src="local" ;;
		"network") src="net" ;;
		*) return 1;;
	esac
	set_option SOURCE $src
	reached source
}
