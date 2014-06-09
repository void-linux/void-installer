menu_add NETWORK "dhcp" "Set up dhcp network"
NETWORK_dhcp() {
	device=`select_nic`

	if [ $? = 0 ]; then
		dhcpcd -t 10 -w -4 -L $dev -e "wpa_supplicant_conf=/etc/wpa_supplicant/wpa_supplicant-${dev}.conf" 2>&1 | \
			$DIALOG --progressbox "Initializing $dev via DHCP..." ${WIDGET_SIZE}
		if [ $? -ne 0 ]; then
			$DIALOG --msgbox "${BOLD}${RED}ERROR:${RESET} failed to run dhcpcd. See $LOG for details." ${MSGBOXSIZE}
		fi
	fi
}
