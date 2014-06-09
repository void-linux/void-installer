menu_add NETWORK "wifi" "Set up wireless network"
NETWORK_wifi() {
	device=`select_nic wireless`
}
