# RPi3_Switchable_HOTSPOT

##Introduction
This is the configuration script to set up HOTSPOT for Raspberry Pi 3.

It make easy to switch between client mode and AP mode. Scanning essids and auto-configure wifi mode at boot up.

Configurations are based on : http://elinux.org/RPI-Wireless-Hotspot
##Installation
* Download scripts.

git clone https://github.com/SignalFlagZ/RPi3_Switchable_HOTSPOT.git

cd RPi3_Switchable_HOTSPOT

1. Excute installer.

`./install.sh`

1. Register your AP's essid to /etc/network/interfaces .

Open `/etc/network/interfaces` in editor.

Search line `map YOUR_ESSID1` .  
Replace `YOUR_ESSID1` to your essid.  
Also replace `YOUR_ESSID2`,`YOUR_ESSID3`... if you want.

1. Configure HOTSPOT

Default HOTSPOT essid : `My_AP`  
Default HOTSPOT password : `My_Passphrase`

If you want to change this ID, edit `/etc/hostapd/hostapd.conf` and replace them.

1. Reboot RPi.

## Usage
### To change HOTSPOT mode
`sudo ifdown wlan0`  
`sudo ifup wlan0=hotspot0`
### To change Client mode
`sudo ifdown wlan0`  
`sudo ifup wlan0=home`
### Scan and auto set
`sudo ifdown wlan0`  
`sudo ifup wlan0`
