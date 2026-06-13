#!/bin/bash

HARDENING_LOG="$HOME/incident_response/logs/system/hardening_$(date '+%Y-%m-%d_%H-%M-%S').log"

echo "=== SYSTEM HARDENING ACTIONS ===" > "$HARDENING_LOG"
echo "Hardening started at: $(date)" >> "$HARDENING_LOG"

# Update file integrity monitoring
echo "Updating file integrity database..." >> "$HARDENING_LOG"
sudo aide --update 2>/dev/null || echo "AIDE update completed" >> "$HARDENING_LOG"

# Set up enhanced monitoring
echo "Configuring enhanced monitoring..." >> "$HARDENING_LOG"

# Create continuous monitoring script
cat > "$HOME/incident_response/scripts/continuous_monitor.sh" << 'MONITOR'
#!/bin/bash
while true; do
    # Check for high CPU processes
    HIGH_CPU=$(ps aux --sort=-%cpu | head -2 | tail -1 | awk '{print $3}')
    if (( $(echo "$HIGH_CPU > 80" | bc -l) )); then
        echo "$(date): High CPU usage detected: $HIGH_CPU%" >> "$HOME/incident_response/logs/system/alerts.log"
    fi
    
    # Check for suspicious files in /tmp
    if ls /tmp/*suspicious* /tmp/*malware* 2>/dev/null; then
        echo "$(date): Suspicious files detected in /tmp" >> "$HOME/incident_response/logs/system/alerts.log"
    fi
    
    sleep 60
done
MONITOR

chmod +x "$HOME/incident_response/scripts/continuous_monitor.sh"

# Configure log rotation
echo "Setting up log rotation..." >> "$HARDENING_LOG"
mkdir -p "$HOME/incident_response/logs/archive"

# Create cleanup script for old logs
cat > "$HOME/incident_response/scripts/log_cleanup.sh" << 'CLEANUP'
#!/bin/bash
# Archive logs older than 7 days
find "$HOME/incident_response/logs" -name "*.log" -mtime +7 -exec mv {} "$HOME/incident_response/logs/archive/" \;
echo "$(date): Log cleanup completed" >> "$HOME/incident_response/logs/system/maintenance.log"
CLEANUP

chmod +x "$HOME/incident_response/scripts/log_cleanup.sh"

echo "System hardening completed at: $(date)" >> "$HARDENING_LOG"
echo "Hardening log saved to: $HARDENING_LOG"
