#!/bin/sh
FACE=wlp4s0
while true; do
	RX_WRTIE=$(cat /sys/class/net/$FACE/statistics/rx_bytes > ../rx) # write buffer for comparison
	TX_WRITE=$(cat /sys/class/net/$FACE/statistics/tx_bytes > ../tx)
	sleep 0.1
done

exit 0
