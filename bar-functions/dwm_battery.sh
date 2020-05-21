#!/bin/sh

# A dwm_bar function to read the battery level and status
# Joe Standring <git@joestandring.com>
# GNU GPLv3

dwm_battery () {
    # # Change BAT1 to whatever your battery is identified as. Typically BAT0 or BAT1
    # CHARGE=$(cat /sys/class/power_supply/BAT1/capacity)
    # STATUS=$(cat /sys/class/power_supply/BAT1/status)
    #
    # printf "%s" "$SEP1"
    # if [ "$IDENTIFIER" = "unicode" ]; then
    #     if [ "$STATUS" = "Charging" ]; then
    #         printf "🔌 %s%% %s" "$CHARGE" "$STATUS"
    #     else
    #         printf "🔋 %s%% %s" "$CHARGE" "$STATUS"
    #     fi
    # else
    #     printf "BAT %s%% %s" "$CHARGE" "$STATUS"
    # fi
    # printf "%s\n" "$SEP2"


for battery in /sys/class/power_supply/BAT0
do
capacity=$(cat "$battery"/capacity) || exit
status=$(cat "$battery"/status)

if [ "$capacity" -ge 75 ]; then
	color="#00ff00"
elif [ "$capacity" -ge 50 ]; then
	color="#ffffff"
elif [ "$capacity" -ge 25 ]; then
	color="#ffff00"
else
	color="#ff0000"
	warn="LOW"
fi

if [ "$capacity" -ge 20 | $status = "Discharging"]; then
	notify-send -u critical "Low battery" ; sleep 10
fi

[ -z $warn ] && warn=" "

[ "$status" = "Charging" ] && color="#ffffff"

printf "%s%s%s\n" "$(echo "$status" | sed "s/,//;s/Discharging/🔋/;s/Not charging/🛑/;s/Charging/🔌/;s/Unknown/♻️/;s/Full/⚡/;s/ 0*/ /g;s/ :/ /g")" "$warn" "$(echo "$capacity" | sed -e 's/$/%/')"
done

}

dwm_battery
