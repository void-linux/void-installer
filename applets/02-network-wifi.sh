menu_add NETWORK "wifi" "Set up wireless network"

menu_add WIFI "wep"
menu_add WIFI "wpa"
WIFI_select() {
	encryption=$1
	device=$2

	result=`$DIALOG --form "$encryption: Wireless configuration for ${device}\n" 0 0 0 \
		"SSID:" 1 1 "" 1 16 30 0 \
		"Password:" 3 1 "" 3 16 30 0` || return 1
}

NETWORK_wifi() {
	while : ; do
		device=`select_nic wireless` || return 1
		menu WIFI "$device" && break;
		sleep 5;
	done
}
