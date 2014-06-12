menu_add NETWORK "manual" "Manually set up network"

NETWORK_manual() {
	while true; do
		device=`select_nic` || return 1

		config=`$DIALOG --form "Static IP configuration for $device:" 0 0 0 \
			"IP address:" 1 1 "192.168.0.2" 1 21 20 0 \
			"Gateway:" 2 1 "192.168.0.1" 2 21 20 0 \
			"DNS Primary" 3 1 "8.8.8.8" 3 21 20 0 \
			"DNS Secondary" 4 1 "8.8.4.4" 4 21 20 0` && break
	done

}
