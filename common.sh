#! /bin/sh
#
# common.sh
# Copyright © 2014 tox <tox@rootkit>
#
# Distributed under terms of the MIT license.
#

show_disks() {
	local dev size sectorsize gbytes

	# IDE
	for dev in $(ls /sys/block|grep -E '^hd'); do
		if [ "$(cat /sys/block/$dev/device/media)" = "disk" ]; then
			# Find out nr sectors and bytes per sector;
			echo "/dev/$dev"
			size=$(cat /sys/block/$dev/size)
			sectorsize=$(cat /sys/block/$dev/queue/hw_sector_size)
			gbytes="$(($size * $sectorsize / 1024 / 1024 / 1024))"
			echo "size:${gbytes}GB;sector_size:$sectorsize"
		fi
	done
	# SATA/SCSI and Virtual disks (virtio)
	for dev in $(ls /sys/block|grep -E '^([sv]|xv)d'); do
		echo "/dev/$dev"
		size=$(cat /sys/block/$dev/size)
		sectorsize=$(cat /sys/block/$dev/queue/hw_sector_size)
		gbytes="$(($size * $sectorsize / 1024 / 1024 / 1024))"
		echo "size:${gbytes}GB;sector_size:$sectorsize"
	done
}

show_partitions() {
	local dev fstype fssize p part

	for disk in `show_disks`; do
		disk=$(basename $disk)
		# ATA/SCSI/SATA
		for p in /sys/block/$disk/$disk*; do
			if [ -d $p ]; then
				part=$(basename $p)
				fstype=$(lsblk -nfr /dev/$part|awk '{print $2}')
				[ "$fstype" = "iso9660" ] && continue
				fssize=$(lsblk -nr /dev/$part|awk '{print $4}')
				echo "/dev/$part"
				echo "size:${fssize:-unknown};fstype:${fstype:-none}"
			fi
		done
		# LVM
		for p in $(ls /dev/mapper 2>/dev/null|grep -v control); do
			[ "$p" = "live-rw" ] && continue
			[ "$p" = "live-base" ] && continue
			fstype=$(lsblk -nfr /dev/$part|awk '{print $2}')
			fssize=$(lsblk -nr /dev/mapper/$p|awk '{print $4}')
			echo "/dev/mapper/$p"
			echo "size:${fssize:-unknown};fstype:${fstype:-none}"
		done
		# Software raid (md)
		for p in $(ls -d /dev/md* 2>/dev/null|grep '[0-9]'); do
			if cat /proc/mdstat|grep -qw $(echo $p|sed -e 's|/dev/||g'); then
				fstype=$(lsblk -nfr /dev/$part|awk '{print $2}')
				fssize=$(lsblk -nr /dev/$p|awk '{print $4}')
				echo "$p"
				echo "size:${fssize:-unknown};fstype:${fstype:-none}"
			fi
		done
	done
}
