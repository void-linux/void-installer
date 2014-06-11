#! /bin/sh
#
# 07-root-password.sh
# Copyright © 2014 tox <tox@rootkit>
#
# Distributed under terms of the MIT license.
#

prompt_rootpassword() {
	local pw= res=0

	while [ -z "$pw" -a "$res" -eq 0 ]; do
		pw=`$DIALOG --passwordbox "Enter the root password $1(password won't be displayed)" ${MSGBOXSIZE}`
		res=$?
	done
	return $res
}

menu_add MAIN rootpassword "Set system root password"
MAIN_rootpassword() {
	local _firstpass= _secondpass= _desc=

	while true; do
		_firstpass=`prompt_rootpassword`
		[ $? -ne 0 ] && return 1;
		_secondpass=`prompt_rootpassword "again "`
		[ $? -ne 0 ] && return 1;

		if [ "${_firstpass}" != "${_secondpass}" ]; then
			$DIALOG --msgbox "Passwords do not match! please reenter it again" \
				${MSGBOXSIZE}
			unset _firstpass _secondpass
			continue
		fi
		break;
	done
	reached rootpassword
}
