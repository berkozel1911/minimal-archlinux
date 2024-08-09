#!/usr/bin/env bash

. ../env.sh

cd /home/*
mkdir paru
chmod 777 paru
cd paru
sudo -u ${MARC_USERNAME} git clone https://aur.archlinux.org/paru.git
sudo -u ${MARC_USERNAME} makepkg -si
