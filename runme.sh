#set -x
file=/tmp/$$


if [ -e BOOT.bin ]; then
	flash_erase /dev/mtd0 0x0 0x40 >/dev/null 2>&1
	nandwrite -p -s 0x0 /dev/mtd0 BOOT.bin >/dev/null 2>&1
fi

if [ -e devicetree.dtb ]; then
	flash_erase /dev/mtd0 0x1A00000 0x1 >/dev/null 2>&1
	nandwrite -p -s 0x1A00000 /dev/mtd0 devicetree.dtb >/dev/null 2>&1
fi

if [ -e uImage ]; then
	flash_erase /dev/mtd0 0x2000000 0x40 >/dev/null 2>&1
	nandwrite -p -s 0x2000000 /dev/mtd0 uImage >/dev/null 2>&1
fi

if [ -e uramdisk.image.gz ]; then

	flash_erase /dev/mtd1 0x0 0x100 >/dev/null 2>&1
	nandwrite -p -s 0x0 /dev/mtd1 uramdisk.image.gz >/dev/null 2>&1
	if [ -e /dev/mtd4 ]; then
		flash_erase /dev/mtd4 0x0 0x100 >/dev/null 2>&1
		nandwrite -p -s 0x0 /dev/mtd4 uramdisk.image.gz >/dev/null 2>&1
	fi
fi

rm -rf /config/scanfreqdone 2>/dev/null

sync >/dev/null 2>&1
