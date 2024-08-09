#!/bin/bash

set -e
if [ "$(whoami)" != "root" ]; then
	echo "Please run this script as the root user."
	exit 1
fi

. ./env.sh

./utils/consolefont.sh
./utils/verifyuefi.sh
./utils/checkconn.sh
./utils/timezone.sh
./utils/disks.sh
./utils/mirrors.sh
./utils/pacstrap.sh
./utils/fstab.sh

arch-chroot /mnt ./utils/timezone.sh
arch-chroot /mnt ./utils/locales.sh
arch-chroot /mnt ./utils/hostname.sh
arch-chroot /mnt ./utils/user.sh
arch-chroot /mnt ./utils/services.sh
arch-chroot /mnt ./utils/sudoers.sh
arch-chroot /mnt ./utils/swapfile.sh
arch-chroot /mnt ./utils/aurhelper.sh
arch-chroot /mnt ./utils/mkinitcpio.sh
arch-chroot /mnt ./utils/bootloader.sh