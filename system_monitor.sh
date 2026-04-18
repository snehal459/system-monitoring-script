	#!/bin/bash

# -------------------------------
# System Monitoring Script
# -------------------------------

LOG_FILE="system_monitor.log"
DISK_THRESHOLD=80
MEM_THRESHOLD=80

echo "=============================="
echo " SYSTEM MONITORING REPORT "
echo "=============================="

# -------------------------------
# Disk Usage
# -------------------------------
DISK_USAGE=$(df / | awk 'NR==2 {print $5}' | sed 's/%//')

echo "Disk Usage: $DISK_USAGE%"

if [ "$DISK_USAGE" -ge "$DISK_THRESHOLD" ]; then
    MESSAGE="ALERT: Disk usage exceeded $DISK_THRESHOLD%"
    echo "$MESSAGE"
    echo "$MESSAGE" >> $LOG_FILE
fi

# -------------------------------
# Memory Usage
# -------------------------------
MEM_USAGE=$(free | awk '/Mem:/ {printf("%.0f"), $3/$2 * 100}')

echo "Memory Usage: $MEM_USAGE%"

if [ "$MEM_USAGE" -ge "$MEM_THRESHOLD" ]; then
    MESSAGE="ALERT: Memory usage exceeded $MEM_THRESHOLD%"
    echo "$MESSAGE"
    echo "$MESSAGE" >> $LOG_FILE
fi

# -------------------------------
# CPU Top Processes
# -------------------------------
echo ""
echo "Top 5 CPU Consuming Processes:"
ps -eo pid,ppid,cmd,%cpu --sort=-%cpu | head -6

# -------------------------------
# Memory Top Processes
# -------------------------------
echo ""
echo "Top 5 Memory Consuming Processes:"
ps -eo pid,ppid,cmd,%mem --sort=-%mem | head -6

echo ""
echo "Monitoring Completed"
