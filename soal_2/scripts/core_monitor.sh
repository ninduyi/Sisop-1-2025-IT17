#!/bin/bash

CPU_USAGE=$(top -bn1 | grep "Cpu(s)" | sed "s/.*, *\([0-9.]*\)%* id.*/\1/" | awk '{print 100 - $1}')
CPU_MODEL=$(lscpu | grep "Model name" | sed 's/Model name: *//')

DATE=$(date '+%Y-%m-%d %H:%M:%S')

echo "[$DATE] - CPU Usage [$CPU_USAGE%] - CPU Model [$CPU_MODEL]" >> /home/ninduyi/percobaan/logs/core.log


