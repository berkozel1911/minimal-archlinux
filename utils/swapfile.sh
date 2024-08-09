#!/usr/bin/env bash

. ./00_VARS.sh
dd if=/dev/zero of=/var/swapfile bs=1024 count=$((1048576*${DEPLOYARCH_SWAPFILE_SIZE})) status=progress

chmod 600 /var/swapfile
mkswap /var/swapfile
swapon /var/swapfile

echo /opt/swapfile 'swap swap defaults 0 0' >> /etc/fstab
