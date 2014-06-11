#! /bin/sh
#
# target.sh
# Copyright © 2014 tox <tox@rootkit>
#
# Distributed under terms of the MIT license.
#

REACHED=

reached() {
	dependency=$1

	REACHED="$REACHED\n$dependency"
}

is_reached() {
	errormsg=$1
	shift
	dependencies="$@"

	res=0
	unreached=
	for dep in $dependencies; do
		# dependency is reached by calling reached
		echo "$REACHED" | grep -Fx "$dep" 2> /dev/null && continue

		# if target_reached wasn't called, find a callback and call it
		if ! type REACHED_$dep > /dev/null 2>&1 || ! REACHED_$dep; then
			res=1
			unreached="$unreached $dep"
		fi
	done

	if [ $res -ne 0 ]; then
		$DIALOG --msgbox "${RED}$errormsg${RESET}

`echo $unreached | tr ' ' '\n'`" 0 0
	fi
	return $res
}
