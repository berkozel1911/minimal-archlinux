#!/usr/bin/env bash

. ./env.sh

echo '127.0.0.1 localhost' > /etc/hosts
echo '127.0.1.1' ${MARC_HOSTNAME} >> /etc/hosts

echo '::1 localhost ip6-localhost ip6-loopback' >> /etc/hosts
