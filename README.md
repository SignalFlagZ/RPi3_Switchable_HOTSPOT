# RPi3_Switchable_HOTSPOT

## Introduction
This is the configuration script to set up HOTSPOT for RASPBIAN JESSIE WITH PIXEL on Raspberry Pi 3.  
It makes easy to switch between client mode and HOTSPOT mode. Scanning essids and auto-configure wifi mode at boot up.  
Configurations are based on : http://elinux.org/RPI-Wireless-Hotspot
## Installation
Download scripts.  
`git clone https://github.com/SignalFlagZ/RPi3_Switchable_HOTSPOT.git`  
`cd RPi3_Switchable_HOTSPOT`  
`./install.sh`

Register your essid(s).
Open `/etc/network/interfaces` in editor.  
Search line `map YOUR_ESSID1` .  
Replace `YOUR_ESSID1` to your essid.  
Also replace `YOUR_ESSID2`,`YOUR_ESSID3`... if you want.

Configure HOTSPOT.  
Default HOTSPOT essid : `My_AP`  
Default HOTSPOT password : `My_Passphrase`  
If you want to change this ID, edit `/etc/hostapd/hostapd.conf` and replace them.

You should reboot RPi.
`sudo reboot`
## Usage
If registered essid was found at boot up, WiFi was configured client mode. Otherwise WiFi was configured HOTSPOT mode.  
This script does not perform the authentication of the essid. Use wpa_supplicant or desktop applications for authentication.
### Change to HOTSPOT mode
`sudo ifdown wlan0`  
`sudo ifup wlan0=hotspot0`
### Change to Client mode
`sudo ifdown wlan0`  
`sudo ifup wlan0=home`
### Scan and auto set
`sudo ifdown wlan0`  
`sudo ifup wlan0`
### Force HOTSPOT
Make a text file `usr/local/bin/hotspot_var`.  
Edit it and write a letter `1` in first line.
