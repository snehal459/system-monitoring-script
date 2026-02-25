#!/bin/bash
#DISK_THRESHOLD=80
MEM_THRESHOLD=75
LOG_FILE="monitor.log"

echo "------------------------------------"
echo "System Monitoring Report - $(date)"
echo "------------------------------------"

DISK_USAGE=$(df / | grep / | awk '{ print $5 }' | sed 's/%//g')

echo "Disk Usage: $DISK_USAGE%"

if [ "$DISK_USAGE" -gt "$DISK_THRESHOLD" ]; then
    echo "ALERT: Disk usage exceeded $DISK_THRESHOLD%" | tee -a $LOG_FILE
fi

MEM_USAGE=$(free | grep Mem | awk '{print $3/$2 * 100.0}')

MEM_USAGE_INT=${MEM_USAGE%.*}

echo "Memory Usage: $MEM_USAGE_INT%"

if [ "$MEM_USAGE_INT" -gt "$MEM_THRESHOLD" ]; then
    echo "ALERT: Memory usage exceeded $MEM_THRESHOLD%" | tee -a $LOG_FILE
fi
echo ""
echo "Top 5 CPU Consuming Processes:"
ps -eo pid,ppid,cmd,%mem,%cpu --sort=-%cpu | head -6

echo ""
echo "Top 5 Memory Consuming Processes:"
ps -eo pid,ppid,cmd,%mem,%cpu --sort=-%mem | head -6

echo ""
echo "Monitoring Completed."
