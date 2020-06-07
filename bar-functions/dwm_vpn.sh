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
# || nmcli -a | grep 'wlp5s0:' | awk '{print $4}'
dwm_vpn () {

CONNECTEDTO=$(nmcli -a | grep 'wlx503eaad43bf9:' | awk '{print $4}')
if [ "$CONNECTEDTO" != /dev/null ]; then #againt the endless curling
VPN=$(curl -s http://api.geoiplookup.net/ | grep -oP -m1 '(?<=city>).*(?=</city)')
ISP=$(curl -s http://api.geoiplookup.net/ | grep -oP -m1 '(?<=isp>).*(?=</isp)')
COORLAT=$(curl -s http://api.geoiplookup.net/ | grep -oP -m1 '(?<=latitude>).*(?=</latitude)')
COORLONG=$(curl -s http://api.geoiplookup.net/ | grep -oP -m1 '(?<=longitude>).*(?=</longitude)')
sleep 3
fi

if [ "$VPN" != "" ]; then
	printf "%s %s %s %s %s" "$SEP1" "$VPN" "$COORLAT" "$COORLONG" "$SEP2"
else
	printf "%s %s %s %s %s" "$SEP1" "$ISP" "$COORLAT" "$COORLONG" "$SEP2"
fi

sleep 3
}


dwm_vpn
