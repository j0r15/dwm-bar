#!/bin/sh
FACE=wlp4s0
dwm_netusage () {
  RX_WRTIE=$(cat /sys/class/net/$FACE/statistics/rx_bytes > rx) # write buffer for comparison
  TX_WRITE=$(cat /sys/class/net/$FACE/statistics/tx_bytes > tx)
RX_READ=$(cat /sys/class/net/$FACE/statistics/rx_bytes) # get current bytes
TX_READ=$(cat /sys/class/net/$FACE/statistics/tx_bytes)
TX_FILE=$(cat tx) # access buffer
RX_FILE=$(cat rx)

NETDOWN_raw=$( expr $RX_READ - $RX_FILE)
NETUP_raw=$( expr $TX_READ - $TX_FILE)

if [[ "${#NETDOWN_raw}" > 3 ]]; then
  expr $NETDOWN_raw / 1000
  NETDOWN="${NETDOWN_raw} kB"
else
  NETDOWN="${NETDOWN_raw} B"
fi

if [[ "${#NETUP_raw}" > 3 ]]; then
  expr $NETUP_raw / 1000
  NETUP="${NETUP_raw} kB"
else
  NETUP="${NETUP_raw} B"
fi
# printf "▲ %s  ▼ %s " "$NETUP" "$NETDOWN"
# printf "\n"
         printf "%s" "$SEP1"
            printf "▲ %s ▼ %s" "$NETUP" "$NETDOWN"
        printf " %s\n " "$SEP2"
}


dwm_netusage
