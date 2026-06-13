#!/bin/bash

EVIDENCE_DIR="$HOME/incident_response/evidence/volatile"
DATE=$(date '+%Y-%m-%d_%H-%M-%S')

echo "Preserving volatile evidence..."

# Capture current system state
ps aux > "$EVIDENCE_DIR/processes_$DATE.txt"
netstat -tuln > "$EVIDENCE_DIR/network_connections_$DATE.txt"
lsof > "$EVIDENCE_DIR/open_files_$DATE.txt"
who > "$EVIDENCE_DIR/logged_users_$DATE.txt"
mount > "$EVIDENCE_DIR/mounted_filesystems_$DATE.txt"

# Capture memory information
cat /proc/meminfo > "$EVIDENCE_DIR/memory_info_$DATE.txt"
cat /proc/cpuinfo > "$EVIDENCE_DIR/cpu_info_$DATE.txt"

# Capture network configuration
ifconfig > "$EVIDENCE_DIR/network_config_$DATE.txt"
route -n > "$EVIDENCE_DIR/routing_table_$DATE.txt"

# Create system snapshot
uname -a > "$EVIDENCE_DIR/system_info_$DATE.txt"
uptime > "$EVIDENCE_DIR/uptime_$DATE.txt"
date > "$EVIDENCE_DIR/timestamp_$DATE.txt"

echo "Volatile evidence preserved with timestamp: $DATE"
