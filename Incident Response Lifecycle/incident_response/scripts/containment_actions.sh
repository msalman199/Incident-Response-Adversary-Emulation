#!/bin/bash

CONTAINMENT_LOG="$HOME/incident_response/logs/system/containment_$(date '+%Y-%m-%d_%H-%M-%S').log"

echo "=== INCIDENT CONTAINMENT ACTIONS ===" > "$CONTAINMENT_LOG"
echo "Containment started at: $(date)" >> "$CONTAINMENT_LOG"

# Kill suspicious processes
if [ -f /tmp/suspicious_process.pid ]; then
    SUSPICIOUS_PID=$(cat /tmp/suspicious_process.pid)
    echo "Terminating suspicious process PID: $SUSPICIOUS_PID" >> "$CONTAINMENT_LOG"
    kill -9 $SUSPICIOUS_PID 2>/dev/null || echo "Process already terminated" >> "$CONTAINMENT_LOG"
fi

# Kill any remaining 'yes' processes
pkill -f yes
echo "Terminated all 'yes' processes" >> "$CONTAINMENT_LOG"

# Quarantine suspicious files
QUARANTINE_DIR="$HOME/incident_response/evidence/quarantine"
mkdir -p "$QUARANTINE_DIR"

if [ -f /tmp/suspicious_file.txt ]; then
    mv /tmp/suspicious_file.txt "$QUARANTINE_DIR/"
    echo "Quarantined: suspicious_file.txt" >> "$CONTAINMENT_LOG"
fi

if [ -f /tmp/fake_malware.sh ]; then
    mv /tmp/fake_malware.sh "$QUARANTINE_DIR/"
    echo "Quarantined: fake_malware.sh" >> "$CONTAINMENT_LOG"
fi

# Block suspicious IP (simulation)
echo "Blocking suspicious IP 192.168.1.100" >> "$CONTAINMENT_LOG"
# In a real scenario, you would use iptables:
# sudo iptables -A INPUT -s 192.168.1.100 -j DROP

echo "Containment actions completed at: $(date)" >> "$CONTAINMENT_LOG"
echo "Containment log saved to: $CONTAINMENT_LOG"
