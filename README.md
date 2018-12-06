void-installer
==============

void-installer is a installer which will be on
[void-linux](https://voidlinux.org) Live CDs. It is the successor of the old
void-installer of void-mklive.

Applets
-------

applets are scripts which handle a certian config action such as configure the
network or partition the harddisk. these scripts are located in the 'applets'
directory and called at start time.

Applets can hook into the menu system by calling the menu\_add function. see
menu.sh for further information. As of now, the following menus exist:

* ```MAIN``` - the main menu which comes up when the script starts
* ```PARTITIONS``` - this menu is called when the user
  selects "partitions" on the MAIN menu.
* ```NETWORK``` - this menu is called when the user
  selects "network" on the MAIN menu.
* ```FSTYPE``` - this menu is called to select the filesystem
  of a block device

an example applet looks like the following

```
# 20-example.sh

menu_add MAIN example "example menu entry"
MAIN_example() {
    echo "This is an example applet. Press enter to return"
    read;
}

menu_add MAIN example_submenu "second example entry"
MAIN_example_submenu() {
    menu EXAMPLE "Hello World"
}

menu_add EXAMPLE entry1 "First entry in example submenu"
EXAMPLE_entry1() {
    echo $@
    read
}

menu_add EXAMPLE entry2 "Second entry in example submenu"
EXAMPLE_entry2() {
    echo $@
    read
}
```
