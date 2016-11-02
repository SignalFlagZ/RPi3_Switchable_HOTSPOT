# RPi3_Switchable_HOTSPOT

##Introduction:
This is the configuration script to set up HOTSPOT for Raspberry Pi 3.

Configurations are based on : http://elinux.org/RPI-Wireless-Hotspot

It make easy to switch between client mode and AP mode. Scanning APs on boot up and auto-switch wifi mode.

##Install
###1.Download scripts.

git clone https://github.com/SignalFlagZ/RPi3_Switchable_HOTSPOT.git

cd RPi3_Switchable_HOTSPOT

###2.Excute installer.

./install.sh

###3.Register your AP's essid to /etc/network/interfaces .

Open /etc/network/interfaces in editor.

Search line "map ESSID1" .

Replace ESSID1 to your essid.

Also register ESSID2,ESSID3...

###4.Reboot RPi.

## Usage
### To change HOTSPOT mode
sudo ifdown wlan0

sudo ifup wlan0=hotspot0
### To change Client mode
sudo ifdown wlan0

sudo ifup wlan0=home
### Scan and auto set
sudo ifdown wlan0

sudo ifup wlan0
