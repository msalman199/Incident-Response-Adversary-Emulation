#!/bin/bash

echo "Simulating suspicious activity for detection practice..."

# Create a suspicious file in /tmp
echo "This is a suspicious file created for incident response training" > /tmp/suspicious_file.txt

# Start a process that consumes CPU (controlled)
yes > /dev/null &
SUSPICIOUS_PID=$!
echo $SUSPICIOUS_PID > /tmp/suspicious_process.pid

# Create fake network activity log entry
echo "$(date): Suspicious connection attempt from 192.168.1.100 to port 22" >> ~/incident_response/logs/network/suspicious_activity.log

# Create a fake malicious script
cat > /tmp/fake_malware.sh << 'MALWARE'
#!/bin/bash
# This is a fake malware script for training purposes
echo "Fake malware executed at $(date)" >> /tmp/malware_log.txt
MALWARE

chmod +x /tmp/fake_malware.sh

echo "Suspicious activity simulation complete."
echo "Suspicious PID: $SUSPICIOUS_PID (saved to /tmp/suspicious_process.pid)"
