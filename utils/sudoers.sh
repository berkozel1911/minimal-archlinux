#!/usr/bin/env bash

. ./00_VARS.sh

# To write user's permissions under root's permissions in the file for readability reasons.
LINENUM=$(grep root -n /etc/sudoers | grep ALL | cut -d':' -f 1)
LINENUM=$(($LINENUM+1))
sed -i "${LINENUM}i${MARC_USERNAME} ALL=(ALL:ALL) ALL" /etc/sudoers
