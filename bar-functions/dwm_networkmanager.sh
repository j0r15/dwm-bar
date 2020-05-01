#!/bin/sh

# A dwm_bar function to show the current network connection/SSID, private IP, and public IP using NetworkManager
# Joe Standring <git@joestandring.com>
# GNU GPLv3

# Dependencies: NetworkManager, curl

dwm_networkmanager () {

WIFI_STRENGTH=$(cat /proc/net/wireless | sed -n -e 's/.*wlp4s0[^0-9]*[0-9]* *\([0-9]*\).*/\1/p')
if [ "$WIFI_STRENGTH" = "" ]; then
        WIFI_STRENGTH=$("lan")
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
    #PUBLIC=$(curl -s https://ipinfo.io/ip)

    printf "%s" "$SEP1"
    if [ "$IDENTIFIER" = "unicode" ]; then
        printf "%s %s %s - " "$CONNAME" "$PRIVATE" "$WIFI_BARS"
    else
        printf "NET %s %s %s"  "$CONNAME" "$PRIVATE" "$WIFI_BARS"
    fi
    printf "%s\n" "$SEP2"
}

dwm_networkmanager
