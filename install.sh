
#!/bin/bash
# Install RPi3_Switchable_HOTSPOT
# Nov. 1 2016
# Signal Flag "Z"
# https://signal-flag-z.blogspot.com/
# Copyright (c) 2016, Signal Flag "Z"  All rights reserved.
#

echo Select LAN interface.
iFaces=(`ls /sys/class/net/ | grep -e ^e`)
if [ ${#iFaces[*]} = 1 ]; then
  lanNAME=${iFaces[@]};
else
  select VAL in ${iFaces[@]}
  do
    if [ $REPLY -le ${#iFaces[*]} ]; then
      lanNAME=$VAL;
      break;
    fi
    echo 'Select correct number.'
  done
fi
echo You select "$lanNAME" .;

echo Select WiFi interface.
iFaces=(`ls /sys/class/net/ | grep -e ^w`)
if [ ${#iFaces[*]} = 1 ]; then
  wifiNAME=${iFaces[@]};
else
  select VAL in ${iFaces[@]}
  do
    if [ $REPLY -le ${#iFaces[*]} ]; then
      wifiNAME=$VAL;
      break;
    fi
    echo 'Select correct number.'
  done
fi
echo You select "$wifiNAME" .;


cd `dirname $0`
echo 'Update.'
sudo apt update -y
sudo apt upgrade -y
echo 'Done.'
#
echo 'Install hostapd, udhcpd and iptables.'
sudo apt install -y hostapd udhcpd
sudo apt install -y iptables
echo 'Done.'
#
echo 'Setting udhcpd.conf...'
sudo mv /etc/udhcpd.conf /etc/udhcpd.conf.bk
sed -i s/wlan0/$wifiNAME/ udhcpd.conf
sudo cp udhcpd.conf /etc/
echo 'Done.'
#
echo 'Enable DHCPD.'
sudo sed -i.bak -e "s/^\(DHCPD_ENABLED\).*/#\1/g" /etc/default/udhcpd
echo 'Done.'
#
echo 'Setting hostapd.'
sed -i s/wlan0/$wifiNAME/ hostapd.conf
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
sed -i s/wlan0/$wifiNAME/ interfaces
sed -i s/eth0/$lanNAME/ interfaces
sudo cp interfaces /etc/network/
echo 'Done.'
#
echo 'Copy a script for interfaces.'
sudo cp apscan.sh /usr/local/bin/
echo 'Done.'
#
echo -e '\n\n### Installation is completed. ###\n'
echo "Please register your AP\'s essid to the file."
echo 'Edit /etc/network/interfaces .'
echo 'Replace "ESSID1" to your essid.'
