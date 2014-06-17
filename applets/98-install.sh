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
		keymap \
		source \
		hostname \
		locale \
		timezone \
		rootpassword \
		bootloader \
		filesystems \

	#	|| return 1;

	ROOTPASSWORD=`get_option ROOTPASSWORD`

	dialog_title="Check $LOGTTY for details"

	# creating targetdir
	mkdir -p $TARGETDIR

	# mounting targets
    $DIALOG --title "$dialog_title" \
        --infobox "mounting filesystems, please wait ..." 4 60
	cd $TARGETDIR
	task_run MOUNT || return 1

    $DIALOG --title "$dialog_title" \
        --infobox "Copying live image to target rootfs, please wait ..." 4 60
    LANG=C cp -axvnu / $TARGETDIR >$LOGTTY 2>&1

	$DIALOG --yes-label "Install" --no-label "Abort"  --yesno "${BOLD}${RED}red${RESET}${BOLD} or ${BLUE}blue${RESET}${BOLD} pill?

This is the point of no return. If you press " $MSGBOXSIZE

}
