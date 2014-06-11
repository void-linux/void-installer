#! /bin/sh
#
# 98-install.sh
# Copyright © 2014 tox <tox@rootkit>
#
# Distributed under terms of the MIT license.
#


menu_add "MAIN" install "Start installation"
MAIN_install() {
	is_reached "Please configure the following before you start the installation" \
		keyboard \
		partition
	return 1
}
