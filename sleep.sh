#!/bin/bash

# 1. Prints once at boot
/root/monitoring.sh

# 2. Calculate system's uptime in seconds
UPTIME=$(awk '{print int($1)}' /proc/uptime)

# 3. How far the system is into a 10-minute cycle (600 sec)
REMAINDER=$(( UPTIME % 600 ))

# 4. Time to sleep until the next 10-minute mark
SLEEP_TIME=$(( 600 - REMAINDER ))

# 5. Sleep until next exact 10-minute point
sleep $SLEEP_TIME

# 6. After the first delay, print every 10 minutes forever
while true; do
	/root/monitoring.sh
	sleep 600
done
