#!/bin/bash

RECOVERY_LOG="$HOME/incident_response/logs/system/recovery_$(date '+%Y-%m-%d_%H-%M-%S').log"

echo "=== SYSTEM RECOVERY VERIFICATION ===" > "$RECOVERY_LOG"
echo "Recovery verification started at: $(date)" >> "$RECOVERY_LOG"

# Verify suspicious processes are terminated
echo "--- Process Verification ---" >> "$RECOVERY_LOG"
if pgrep -f yes > /dev/null; then
    echo "WARNING: Suspicious processes still running" >> "$RECOVERY_LOG"
    pgrep -f yes >> "$RECOVERY_LOG"
else
    echo "CLEAN: No suspicious processes detected" >> "$RECOVERY_LOG"
fi

# Verify suspicious files are quarantined
echo "--- File System Verification ---" >> "$RECOVERY_LOG"
if [ -f /tmp/suspicious_file.txt ] || [ -f /tmp/fake_malware.sh ]; then
    echo "WARNING: Suspicious files still present in /tmp" >> "$RECOVERY_LOG"
    ls -la /tmp/*suspicious* /tmp/*malware* 2>/dev/null >> "$RECOVERY_LOG"
else
    echo "CLEAN: Suspicious files successfully quarantined" >> "$RECOVERY_LOG"
fi

# Check system resources
echo "--- System Resource Check ---" >> "$RECOVERY_LOG"
CPU_USAGE=$(top -bn1 | grep "Cpu(s)" | awk '{print $2}' | cut -d'%' -f1)
echo "Current CPU usage: ${CPU_USAGE}%" >> "$RECOVERY_LOG"

MEMORY_USAGE=$(free | grep Mem | awk '{printf "%.1f", $3/$2 * 100.0}')
echo "Current memory usage: ${MEMORY_USAGE}%" >> "$RECOVERY_LOG"

# Verify network connections
echo "--- Network Connection Verification ---" >> "$RECOVERY_LOG"
ACTIVE_CONNECTIONS=$(netstat -tuln | grep LISTEN | wc -l)
echo "Active listening ports: $ACTIVE_CONNECTIONS" >> "$RECOVERY_LOG"

echo "Recovery verification completed at: $(date)" >> "$RECOVERY_LOG"
echo "Recovery verification log saved to: $RECOVERY_LOG"
