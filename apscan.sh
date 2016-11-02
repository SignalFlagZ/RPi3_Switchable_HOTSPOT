#!/bin/bash
# Nov. 1 2016
# Signal Flag "Z"
# https://signal-flag-z.blogspot.com/
# Copyright (c) 2016, Signal Flag "Z"  All rights reserved.
set -e
export LANG=C

iface="$1"
APs=("")
ret=""
hotspot=""

# Scan APs
sudo ip link set dev "$iface" up
sleep 1
APs=$(sudo iw "$iface" scan ap-force | grep -ioP '(?<=ssid:\ ).+(?=$)')
sudo ip link set dev "$iface" down

# Search config_nmae
while read essid conf; do
  if [ ! -n "$conf" ] 
  then
    hotspot="$essid"
  else
    for APssid in ${APs[@]}; do
      if [ $essid = $APssid ] && [ ! "$ret" ]
      then
          ret="$conf"
      fi
    done
  fi
done

# Check hotspot_var.
filepath="/usr/local/bin/hotspot_var"
if [ -f "$filepath" ]
then
  read val < "$filepath"
  case "$val" in
    "1" ) ret="$hotspot"
    ;;
  esac
fi

if [ ! -n "$ret" ]
then
  ret="$hotspot"
fi

echo "$ret"
exit 0
