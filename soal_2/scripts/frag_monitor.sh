#!/bin/bash

RAM_USAGE=$(free | grep Mem | awk '{print $3/$2 * 100.0}')
RAM_TOTAL=$(free -m | grep Mem | awk '{print $2}')
RAM_AVAILABLE=$(free -m | grep Mem | awk '{print $7}')
RAM_USED=$(free -m | grep Mem | awk '{print $3}')

DATE=$(date '+%Y-%m-%d %H:%M:%S')

echo "[$DATE] - RAM Usage [$RAM_USAGE%] - Used [$RAM_USED MB] - Details [Total: $RAM_TOTAL MB, Available: $RAM_AVAILABLE MB]" >> /home/ninduyi/percobaan/logs/fragment.log
