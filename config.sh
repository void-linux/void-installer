#! /bin/sh
#
# config.sh
# Copyright © 2014 tox <tox@rootkit>
#
# Distributed under terms of the MIT license.
#
CONFIG_FILE=$HOME/.void_installer

set_option() {
	config_set $@
}

config_set() {
	name=$0
	value=$1
}

config_get() {
	:
}
