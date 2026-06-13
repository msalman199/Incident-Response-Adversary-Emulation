#!/bin/bash

LOG_DEST="$HOME/incident_response/logs"
DATE=$(date '+%Y-%m-%d_%H-%M-%S')

echo "Collecting system logs for incident analysis..."

# Copy system logs
sudo cp /var/log/syslog "$LOG_DEST/system/syslog_$DATE.log" 2>/dev/null || echo "Syslog not accessible"
sudo cp /var/log/auth.log "$LOG_DEST/system/auth_$DATE.log" 2>/dev/null || echo "Auth log not accessible"
sudo cp /var/log/kern.log "$LOG_DEST/system/kern_$DATE.log" 2>/dev/null || echo "Kernel log not accessible"

# Collect network-related logs
sudo dmesg | grep -i network > "$LOG_DEST/network/dmesg_network_$DATE.log"

# Collect application logs
sudo find /var/log -name "*.log" -type f -exec basename {} \; > "$LOG_DEST/application/available_logs_$DATE.txt"

echo "Log collection completed. Files saved with timestamp: $DATE"
