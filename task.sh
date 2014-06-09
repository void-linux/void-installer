#! /bin/sh
#
# task.sh
# Copyright © 2014 tox <tox@rootkit>
#
# Distributed under terms of the MIT license.
#

TASKS=
task_add() {
	label=$1
	cmd=$2
	TASKS="$TASKS\n$label:$cmd"
}

task_run() {
	task=$1
	dir=$2
	cd "$2"
	echo "$TASKS" | grep "^$task:" | cut -d: -f2- | xargs -l 1 /bin/sh -c
	cd -
}
