MENU_ENTRIES=

menu() {
	menu=$1
	title=$2
	result=`echo "$MENU_ENTRIES" | grep "^$menu:" | cut -d: -f2- | \
		xargs -d '\n' \
		$DIALOG --default-item "$CURRENT_ITEM" \
			--title "$title" \
			--menu "$MENU_LABEL" 10 70 0`

	case $? in
		0) ${menu}_${result} ;;
		123) type ${menu}_cancel 2> /dev/null && ${menu}_cancel ;;
	esac
}

menu_add() {
	menu=$1
	name=$2
	desc=$3

	if [ "$MENU_ENTRIES" ]; then
		MENU_ENTRIES="$MENU_ENTRIES\n$menu:$name\n$menu:$desc"
	else
		MENU_ENTRIES="$menu:$name\n$menu:$desc"
	fi
}
