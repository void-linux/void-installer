#! /bin/sh
#
# task.sh
# Copyright © 2014 tox <tox@rootkit>
#
# Distributed under terms of the MIT license.
#

TASKS=
task_add() {
	task=$1
	id=$2
	cmd=$3
	task_remove "$task:$id"
	TASKS="$TASKS\n$task:$id:$cmd"
}

task_run() {
	task=$1
	dir=$2
	cd "$2"
	echo "$TASKS" | grep "^$task:" | cut -d: -f3- | xargs -l 1 /bin/sh -c
	cd -
}

task_remove() {
	for task; do
		TASKS=`echo "$TASKS" | grep -v "^$task:"`
	done
}
