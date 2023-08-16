#!/bin/bash

curIdle=$(cat /proc/stat | grep -E "cpu " | awk '{print $5}')
oldIdle=$curIdle
curFull=$(cat /proc/stat | grep -E "cpu " | awk '{printf "%d", $2 + $3 + $4 + $5 + $6 + $7 + $8 + $9 + $10 + $11}')
oldFull=$curFull
while sleep 5; do

	curIdle=$(cat /proc/stat | grep -E "cpu " | awk '{print $5}')
	curFull=$(cat /proc/stat | grep -E "cpu " | awk '{printf "%d", $2 + $3 + $4 + $5 + $6 + $7 + $8 + $9 + $10 + $11}')
	cpuBusy=$(echo | awk '{printf "%.2f", (100 - ('$curIdle' - '$oldIdle') * 100 / ('$curFull' - '$oldFull'))}')
	oldIdle=$curIdle
	oldFull=$curFull
{
	echo "# HELP cpu_busy
# TYPE cpu_busy gauge
cpu_busy $cpuBusy
# HELP mem_available_bytes
# TYPE mem_available_bytes gauge
mem_available_bytes $(free -b | awk 'NR==2 {print $7}' | tr -d '\n')
# HELP mem_total_bytes
# TYPE mem_total_bytes gauge
mem_total_bytes $(free -b | awk 'NR==2 {print $2}' | tr -d '\n')
# HELP disk_available_kilobytes
# TYPE disk_available_kilobytes gauge
disk_available_kilobytes $(df / | awk 'NR==2 {print $4}')
# HELP disk_total_kilobytes
# TYPE disk_total_kilobytes gauge
disk_total_kilobytes $(df / | awk 'NR==2 {print $2}')"
} > index.html
sudo mv index.html /var/www/html
done
