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
		xargs $DIALOG --title "Select your keymap" --menu "$MENU_LABEL" $MENUSIZE`
	[ $? -eq 0 ] || return 1;

	loadkeys $result;
	task_add "KEYBOARD" "" sed "s/^KEYMAP=.*/KEYMAP=$result/" etc/vconsole.conf
}

REACHED_keyboard() {
	task_exists "KEYBOARD"
}
