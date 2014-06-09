#! /bin/sh
#
# 09-partitions.sh
# Copyright © 2014 tox <tox@rootkit>
#
# Distributed under terms of the MIT license.
#

menu_add MAIN partitions "Partition disk(s)"

MAIN_partitions() {
	local disks= device=
	disks="`show_disks`"
    device="`$DIALOG --title " Select the disk to partition " \
        --menu "$MENULABEL" ${MENUSIZE} $disks`"
    if [ $? -eq 0 ]; then

        $DIALOG --title "Modify Partition Table on $device" --msgbox "\n
${BOLD}GNU parted will be executed in disk $device.${RESET}\n\n
For BIOS systems, MBR or GPT partition tables are supported.\n
To use GPT on PC BIOS systems an empty partition of 1MB must be added\n
at the first 2GB of the disk with the TOGGLE \`bios_grub' enabled.\n
${BOLD}NOTE: you don't need this on EFI systems.${RESET}\n\n
For EFI systems GPT is mandatory and a FAT32 partition with at least\n
100MB must be created with the TOGGLE \`boot', this will be used as\n
EFI System Partition. This partition must have mountpoint as \`/boot/efi'.\n\n
At least 2 partitions are required: swap and rootfs (/).\n
For swap, RAM*2 must be really enough. For / 600MB are required.\n\n
${BOLD}WARNING: /usr is not supported as a separate partition.${RESET}\n
${BOLD}WARNING: changes made by parted are destructive, you've been warned.
${RESET}\n" 18 80
        if [ $? -eq 0 ]; then
            while true; do
                clear; parted $device; PARTITIONS_DONE=1; partprobe $device
                break
            done
        else
            return
        fi
    fi
}
