#! /bin/sh
#
# 99-main-menu.sh
# Copyright © 2014 tox <tox@rootkit>
#
# Distributed under terms of the MIT license.
#

MAIN_cancel() {
	if $DIALOG --yesno "Do you really want to exit?" 0 0; then
		RUNNING=
	fi
}

$DIALOG --title "${BOLD}${RED} Enter the void ... ${RESET}" --msgbox "\n
Welcome to the Void Linux installation. A simple and minimal \
Linux distribution made from scratch and built from the source package tree \
available for XBPS, a new alternative binary package system.\n\n
The installation should be pretty straightforward, if you are in trouble \
please join us at ${BOLD}#xbps on irc.freenode.org${RESET}.\n\n
${BOLD}http://www.voidlinux.eu${RESET}\n\n" 16 80

RUNNING=1
while [ "$RUNNING" ]; do
	menu MAIN "Void Installer"
done
clear;
