
#!/bin/bash
# Install RPi3_Switchable_HOTSPOT
# Nov. 1 2016
# Signal Flag "Z"
# https://signal-flag-z.blogspot.com/
# Copyright (c) 2016-2017, Signal Flag "Z"  All rights reserved.
#

# Select Interface
# arg1: argument for grep
function selectInterface() {
  local iFaces=(`ls /sys/class/net/ | grep $1`)
  local VAL=""
  if [ ${#iFaces[*]} = 0 ]; then return 1; fi
  if [ ${#iFaces[*]} = 1 ]; then
    echo ${iFaces[@]};
  else
    select VAL in ${iFaces[@]}
    do
      if [ $REPLY -le "0" ]; then
          continue;
      fi
      if [ $REPLY -le ${#iFaces[*]} ]; then
        echo $VAL
        break
      fi
    done
  fi
  return 0
}

echo Select LAN interface.
lanNAME=`selectInterface "^e"` || { echo 'No LAN interface.'; exit 1; }
echo You select "$lanNAME" .

echo Select WiFi interface.
wifiNAME=`selectInterface "^wl"` || { echo 'No WiFi interface.'; exit 1; }
echo You select "$wifiNAME" .


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
sudo cp udhcpd.conf /etc/
sed -i s/wlan0/$wifiNAME/g /etc/udhcpd.conf
echo 'Done.'
#
echo 'Enable DHCPD.'
sudo sed -i.bak -e "s/^\(DHCPD_ENABLED\)/#\1/g" /etc/default/udhcpd
echo 'Done.'
#
echo 'Setting hostapd.'
sudo cp hostapd.conf /etc/hostapd/
sed -i s/wlan0/$wifiNAME/g /etc/hostapd/hostapd.conf
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
sudo cp interfaces /etc/network/interfaces.d/hotspot.cfg
sed -i s/wlan0/$wifiNAME/g /etc/network/interfaces.d/hotspot.cfg
sed -i s/eth0/$lanNAME/g /etc/network/interfaces.d/hotspot.cfg
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
