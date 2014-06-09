#! /bin/sh
#
# 00-keyboard.sh
# Copyright © 2014 tox <tox@rootkit>
#
# Distributed under terms of the MIT license.
#

menu_add MAIN "keyboard" "Set system keyboard"

MAIN_keyboard() {
    result=`localectl --no-pager list-keymaps | \
		sed "s/$/ -/" | \
		xargs $DIALOG --title "Select your keymap" --menu "$MENU_LABEL" 0 70 0`
	if [ $? -eq 0 ]; then
		loadkeys $result;
	fi
}
