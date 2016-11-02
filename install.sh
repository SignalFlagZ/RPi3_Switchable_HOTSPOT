
#!/bin/bash
# Install RPi3_Switchable_HOTSPOT
# Nov. 1 2016
# Signal Flag "Z"
# https://signal-flag-z.blogspot.com/
# Copyright (c) 2016, Signal Flag "Z"  All rights reserved.
#
cd `dirname $0`
sudo apt-get update
sudo apt-get -y upgrade
#
sudo mv /etc/udhcpd.conf /etc/udhcpd.conf.bk
sudo cp udhcpd.conf /etc/
#
sudo sed -i.bak -e "s/^\(DHCPD_ENABLED\).*/#\1/g" /etc/default/udhcpd
#
sudo cp hostapd.conf /etc/hostapd/
sudo cp /etc/default/hostapd /etc/default/hostapd.bk
sudo echo 'DAEMON_CONF="/etc/hostapd/hostapd.conf"' >> /etc/default/hostapd
#
sudo systemctl disable hostapd
sudo systemctl disable udhcpd
#
sudo cp /etc/network/interfaces /etc/network/interfaces.bk
sudo cp interfaces /etc/network/
#
sudo cp apscan.sh /usr/local/bin/
