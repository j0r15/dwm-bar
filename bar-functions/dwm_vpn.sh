#!/bin/sh

# A dwm_bar function to show VPN connections (if any are active)
# Joe Standring <git@joestandring.com>
# GNU GPLv3

# Dependencies: NetworkManager-openvpn

# dwm_vpn () {
#     VPN=$(nmcli -a | grep 'VPN connection' | sed -e 's/\( VPN connection\)*$//g')
#
#     if [ "$VPN" != "" ]; then
#         printf "%s" "$SEP1"
#         if [ "$IDENTIFIER" = "unicode" ]; then
#             printf "🔒 %s" "$VPN"
#         else
#             printf "VPN %s" "$VPN"
#         fi
#         printf "%s\n" "$SEP2"
#     fi
# }

# To get coordinates
#curl -s http://api.geoiplookup.net/ | grep -oP -m1 '(?<=latitude>).*(?=</latitude)' && curl -s http://api.geoiplookup.net/ | grep -oP -m1 '(?<=longitude>).*(?=</longitude)'

dwm_vpn () {
VPN=$(curl -s http://api.geoiplookup.net/ | grep -oP -m1 '(?<=city>).*(?=</city)')
COOR=$(curl -s http://api.geoiplookup.net/ | grep -oP -m1 '(?<=latitude>).*(?=</latitude)' && curl -s http://api.geoiplookup.net/ | grep -oP -m1 '(?<=longitude>).*(?=</longitude)')

if [ "$VPN" != "" ]; then
         printf "%s" "$SEP1"
        if [ "$IDENTIFIER" = "unicode" ]; then
            printf "🔒 %s %s" "$VPN" "$COOR"
        else
            printf "VPN %s %s" "$VPN" "$COOR"
        fi
        printf " %s %s\n " "NET" "$SEP2"
    fi

  # ip kan deze zijn 185.220.70.148 of die uit amsterdam
}


dwm_vpn
