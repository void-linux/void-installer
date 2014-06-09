#! /bin/sh
#
# installer.sh
# Copyright © 2014 Enno Boland <eb@s01.de>
#
# Distributed under terms of the MIT license.
#

DIALOG='/usr/bin/dialog --backtitle VoidLinux --stdout --colors'
CFDISK=/usr/sbin/cfdisk
CGDISK=/usr/sbin/cgdisk
DHCPCD=/usr/sbin/dhcpcd

# colors and attributes
BLACK="\Z0"
RED="\Z1"
GREEN="\Z2"
YELLOW="\Z3"
BLUE="\Z4"
MAGENTA="\Z5"
CYAN="\Z6"
WHITE="\Z7"
BOLD="\Zb"
REVERSE="\Zr"
UNDERLINE="\Zu"
RESET="\Zn"

INPUTSIZE="8 60"
MSGBOXSIZE="8 70"
MENU_LABEL="${BOLD}Use UP and DOWN keys to navigate \
menus. Use TAB to switch between buttons and ENTER to select.${RESET}"
MENUSIZE="14 60 0"
INPUTSIZE="8 60"
MSGBOXSIZE="8 70"
YESNOSIZE="$INPUTSIZE"
WIDGET_SIZE="10 70"

trap "DIE" INT TERM QUIT

DIE() {
    rval=$1
    [ -z "$rval" ] && rval=0
    clear
    # reenable printk
    if [ -w /proc/sys/kernel/printk ]; then
        echo 4 >/proc/sys/kernel/printk
    fi
    exit $rval
}

# disable printk
if [ -w /proc/sys/kernel/printk ]; then
    echo 0 >/proc/sys/kernel/printk
fi


. ./common.sh
. ./menu.sh
. ./config.sh

for i in ./applets/*.sh; do
	. $i
done
