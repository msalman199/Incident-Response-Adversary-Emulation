#!/bin/bash

# System Monitoring Script for Incident Response
LOG_DIR="$HOME/incident_response/logs/system"
DATE=$(date '+%Y-%m-%d_%H-%M-%S')

echo "=== System Monitoring Report - $DATE ===" > "$LOG_DIR/monitor_$DATE.log"

# CPU and Memory Usage
echo "--- CPU and Memory Usage ---" >> "$LOG_DIR/monitor_$DATE.log"
top -bn1 | head -20 >> "$LOG_DIR/monitor_$DATE.log"

# Active Network Connections
echo "--- Active Network Connections ---" >> "$LOG_DIR/monitor_$DATE.log"
netstat -tuln >> "$LOG_DIR/monitor_$DATE.log"

# Running Processes
echo "--- Running Processes ---" >> "$LOG_DIR/monitor_$DATE.log"
ps aux --sort=-%cpu | head -20 >> "$LOG_DIR/monitor_$DATE.log"

# Disk Usage
echo "--- Disk Usage ---" >> "$LOG_DIR/monitor_$DATE.log"
df -h >> "$LOG_DIR/monitor_$DATE.log"

# Recent Login Attempts
echo "--- Recent Login Attempts ---" >> "$LOG_DIR/monitor_$DATE.log"
last -10 >> "$LOG_DIR/monitor_$DATE.log"

echo "Monitoring report saved to: $LOG_DIR/monitor_$DATE.log"
