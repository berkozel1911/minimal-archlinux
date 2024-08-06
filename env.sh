#!/bin/bash

# Target hostname
export MARC_HOSTNAME="archlinux"

# Target user credentials
export MARC_USERNAME="berk"
export MARC_USERPASS="berk123"

# Base packages which will be used by pacstrap
export MARC_PACSTRAPS="base base-devel linux linux-firmware intel-ucode networkmanager less vim git"

# Disk partition sizes
export MARC_SWAPSIZE="1G"
export MARC_EFI_SIZE="512M"
export MARC_BOOT_SIZE="512M"

# Timezone
export MARC_TIMEZONE="Etc/GMT+3"

# Services to be enabled
export MARC_SVCS="NetworkManager"

# Additional kernel parameters
export MARC_KERNEL_PARAMS="net.ifnames=0 fbcon=font:TER16x32"
