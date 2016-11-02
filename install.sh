
#!/bin/bash
# Install RPi3_Switchable_HOTSPOT
# Nov. 1 2016
# Signal Flag "Z"
# https://signal-flag-z.blogspot.com/
# Copyright (c) 2016, Signal Flag "Z"  All rights reserved.
#
cd `dirname $0`
echo 'Update.'
sudo apt-get update
sudo apt-get -y upgrade
echo 'Done.'
#
echo 'Install hostapd, udhcpd and iptables.'
sudo apt-get install -y hostapd udhcpd
sudo apt-get install -y iptables
echo 'Done.'
#
echo 'Setting udhcpd.conf...'
sudo mv /etc/udhcpd.conf /etc/udhcpd.conf.bk
sudo cp udhcpd.conf /etc/
echo 'Done.'
#
echo 'Enable DHCPD.'
sudo sed -i.bak -e "s/^\(DHCPD_ENABLED\).*/#\1/g" /etc/default/udhcpd
echo 'Done.'
#
echo 'Setting hostapd.'
sudo cp hostapd.conf /etc/hostapd/
sudo cp /etc/default/hostapd /etc/default/hostapd.bk
echo 'DAEMON_CONF="/etc/hostapd/hostapd.conf"' | sudo tee -a /etc/default/hostapd
echo 'Done.'
#
echo 'Disable services auto start .'
sudo systemctl disable hostapd
sudo systemctl disable udhcpd
echo 'Done.'
#
echo 'Setting interfaces.'
sudo cp /etc/network/interfaces /etc/network/interfaces.bk
sudo cp interfaces /etc/network/
echo 'Done.'
#
echo 'Copy a script for interfaces.'
sudo cp apscan.sh /usr/local/bin/
echo 'Done.'
#
echo -e '\n\n### installation process is completed. ###\n'
echo "Please register your AP\'s essid to the file."
echo 'Edit /etc/network/interfaces .'
echo 'Replace "ESSID1" to your essid.'
