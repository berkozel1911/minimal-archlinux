#!/usr/bin/env bash

. ../env.sh

echo "WARNING: A \"WHOLE\" disk will be used for the installation."
echo "Please choose a BLOCK DEVICE (not a partition) from the list below:"
lsblk -fp
echo -n "Enter the selected block device: "
read BLKDEVICE
BLKDEVICE=$(echo ${BLKDEVICE} | cut -f 1 -d " ")
CHKDEV=$(lsblk -dp | grep ${BLKDEVICE})

while [ -z ${CHKDEV} ]; do
   echo "You just entered a wrong block device."
   echo -n "Enter the selected block device: "
   read BLKDEVICE
done

echo "Altering the disk tables and filesystem signatures..."
wipefs --all --force ${BLKDEVICE}[1-9]*
wipefs --all --force ${BLKDEVICE}

# Create a GPT on the disk:
sgdisk -o ${BLKDEVICE}

# Create the EFI partition:
sgdisk -n 1:0:+${MARC_EFI_SIZE} ${BLKDEVICE}

# Create the /boot partition:
sgdisk -n 2:0:+${MARC_BOOT_SIZE} ${BLKDEVICE}

# Create the / partition:
sgdisk -n 3:0:0 ${BLKDEVICE}

EFIPART=$(lsblk -lp ${BLKDEVICE} | grep part | awk '{ print $1 }' | awk NR==1)
BOOTPART=$(lsblk -lp ${BLKDEVICE} | grep part | awk '{ print $1 }' | awk NR==2)
ROOTPART=$(lsblk -lp ${BLKDEVICE} | grep part | awk '{ print $1 }' | awk NR==3)

echo "Creating filesystems"
mkfs.fat -F32 ${EFIPART}
mkfs.ext4 ${BOOTPART}
mkfs.ext4 ${ROOTPART}

echo "Mounting filesystems..."
mount -v ${ROOTPART} /mnt
mkdir /mnt/boot -v
mount -v ${BOOTPART} /mnt/boot
mkdir /mnt/boot/efi -v
mount -v ${EFIPART} /mnt/boot/efi

mkdir -pv /mnt/chroot-scripts
echo $EFIPART  > /mnt/chroot-scripts/PARTS
echo $BOOTPART>> /mnt/chroot-scripts/PARTS
echo $ROOTPART>> /mnt/chroot-scripts/PARTS
