# MENU
# ====
# Menu is a wrapper around `dialog` to ease the usage of complex menu systems
# it is written in in Posix compliant shell script.
# It consists of the following commands:
#
# menu_add MENU ITEM_NAME DESCRIPTION
#  this command adds a new definition to the menu named `MENU`
#  the item is called `ITEM_NAME` and its description is `DESCRIPTION`
#
# menu MENU TITLE ...
#  this command will call `dialog` with all items you've added to this menu
#  with the `menu_add` command.
#  When the user selects an item, `menu` will call a function named
#  `<MENU>_<ITEM_NAME>` and add the trailing arguments of menu to the function
#  call.
#  If the user cancels the dialog, <MENU>_cancel will be called


MENU_ENTRIES=
CURRENT_ITEMS=

menu() {
	menu=$1
	title=$2
	shift 2
	current_item=`echo "$CURRENT_ITEMS" | grep "^$menu:" | cut -d: -f2-`
	result=`echo "$MENU_ENTRIES" | grep "^$menu:" | cut -d: -f2- | \
		xargs -d '\n' \
		$DIALOG $DOPTS --default-item "$current_item" \
			--title "$title" \
			--menu "$MENU_LABEL" $MENUSIZE`
	res=$?
	CURRENT_ITEMS=`echo "$CURRENT_ITEMS" | grep -v "^$menu:"; echo $menu:$result`

	case $res in
		0)
			if type ${menu}_${result} > /dev/null 2>&1; then
				${menu}_${result} $@
			else
				type ${menu}_select > /dev/null 2>&1 && ${menu}_select $result $@
			fi
			;;
		123) type ${menu}_cancel > /dev/null 2>&1 && ${menu}_cancel $@ ;;
	esac
}

menu_add() {
	menu=$1
	name=$2
	desc=$3

	MENU_ENTRIES="$MENU_ENTRIES\n$menu:$name\n$menu:$desc"
}
