#!/bin/bash
# Install RPi3_Switchable_HOTSPOT
#
sudo apt-get update
sudo apt-get -y upgrade

#
sudo mv /etc/udhcpd.conf /etc/udhcpd.conf.bk
sudo cp udhcpd.conf /etc/udhcpd.conf

#
sudo sed -i.bak -e "s/^\(DHCPD_ENABLED\).*/#\1/g" /etc/default/udhcpd

#


