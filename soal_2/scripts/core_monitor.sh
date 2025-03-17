#!/bin/bash

CPU_USAGE=$(top -bn1 | grep "Cpu(s)" | sed "s/.*, *\([0-9.]*\)%* id.*/\1/" | awk '{print 100 - $1}')
CPU_MODEL=$(lscpu | grep "Model name" | sed 's/Model name: *//')

CORE_LOG_PATH="$(dirname "$0")/../logs/core.log"
echo "[$(date '+%Y-%m-%d %H:%M:%S')] - CPU Usage [$CPU_USAGE%] - CPU Model [$CPU_MODEL]" >>"$CORE_LOG_PATH"


