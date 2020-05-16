#!/bin/sh


# Dependencies: NetworkManager

dwm_networkmanager () {

WIFI_STRENGTH_PCM=$(cat /proc/net/wireless | sed -n -e 's/.*wlp4s0[^0-9]*[0-9]* *\([0-9]*\).*/\1/p')
WIFI_STRENGTH_USB=$(cat /proc/net/wireless | sed -n -e 's/.*wlx503eaad43bf9[^0-9]*[0-9]* *\([0-9]*\).*/\1/p')
if [ "$WIFI_STRENGTH_PCM" = /dev/NULL ]; then
        WIFI_STRENGTH=$("PCM OFF")
else
   WIFI_STRENGTH=$WIFI_STRENGTH_PCM
fi

if [ "$WIFI_STRENGTH_PCM" = /dev/NULL ]; then
        WIFI_STRENGTH=$("USB OFF")
else
   WIFI_STRENGTH=$WIFI_STRENGTH_USB
fi

Fruits=('▁' '▂' '▃' '▄' '▅' '▆' '▇' '█')
number=$(expr $WIFI_STRENGTH / 7 )
WIFI_BARS=$(echo ${Fruits[@]:0:$number} )

CONNAME=$(nmcli -a | grep 'Wired connection' | awk 'NR==1{print $1}')
    if [ "$CONNAME" = "wifi" ]; then
        CONNAME="WIFI $(nmcli -t -f active,ssid dev wifi | grep '^yes' | cut -c 5-)"
    else
      CONNAME="LAN"
    fi

    PRIVATE=$(nmcli -a | grep 'inet4 192' | awk '{print $2}')

    printf "%s " "$SEP1"
    printf "%s %s %s " "$CONNAME" "$PRIVATE" "$WIFI_BARS"
    printf "%s " "$SEP2"
}

dwm_networkmanager
