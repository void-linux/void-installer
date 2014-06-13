#! /bin/sh
#
# 01-network.sh
# Copyright © 2014 tox <tox@rootkit>
#
# Distributed under terms of the MIT license.
#

list_nic() {
	case "$1" in
	wireless)
		for i in `list_nic`; do
			[ -f /sys/class/net/$i/wireless ] && echo $i;
		done
		;;
	cable)
		for i in `list_nic`; do
			[ -f /sys/class/net/$i/wireless ] || echo $i;
		done
		;;
	*)
		ls -1 /sys/class/net | grep -vFx "lo"
		;;
	esac
}

select_nic() {
	case `list_nic $@ | wc -l` in
	1) list_nic $@ ;;
	0) $DIALOG --msgbox "No matching NICs found." $MSGBOXSIZE; return 1 ;;
	*) list_nic $@ | sed "s/$/ ./" | \
		xargs $DIALOG --title "Select NIC" --menu "$MENU_LABEL" 0 70 0;;
	esac
}

menu_add MAIN "network" "Set up the network"
MAIN_network() {
	menu NETWORK "Choose network type"
}
