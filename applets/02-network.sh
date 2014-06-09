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
	if [ `list_nic $@ | wc -l` -le 1 ]; then
		list_nic $@
		return $?
	fi
	list_nic $@ | sed "s/$/ ./" | \
		xargs $DIALOG --title "Select your keymap" --menu "$MENU_LABEL" 0 70 0
}

menu_add MAIN "network" "Set up the network"
MAIN_network() {
	menu NETWORK "Choose network type"
}

menu_add NETWORK "dhcp" "Set up dhcp network"
NETWORK_dhcp() {
	device=`select_nic`
	
}

menu_add NETWORK "manual" "Manually set up network"
NETWORK_manual() {
	:
}

menu_add NETWORK "wifi" "Set up wireless network"
NETWORK_wifi() {
	device=`select_nic wireless`
}
