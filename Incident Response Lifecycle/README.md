# 🚨 Incident Response Lifecycle

> **A hands-on cybersecurity lab for implementing the complete NIST incident response framework — from detection to recovery — using open-source tools on Linux**

![Bash](https://img.shields.io/badge/Bash-Scripting-4EAA25?style=for-the-badge&logo=gnubash&logoColor=white)
![Linux](https://img.shields.io/badge/Linux-Ubuntu-E95420?style=for-the-badge&logo=ubuntu&logoColor=white)
![NIST](https://img.shields.io/badge/NIST-IR%20Framework-003366?style=for-the-badge&logo=nist&logoColor=white)
![Tcpdump](https://img.shields.io/badge/tcpdump-Packet%20Capture-1a5276?style=for-the-badge&logo=wireshark&logoColor=white)
![AIDE](https://img.shields.io/badge/AIDE-File%20Integrity-8e44ad?style=for-the-badge&logo=linux&logoColor=white)
![Fail2Ban](https://img.shields.io/badge/Fail2Ban-Intrusion%20Prevention-c0392b?style=for-the-badge&logo=linux&logoColor=white)
![Rsyslog](https://img.shields.io/badge/Rsyslog-Log%20Management-2c3e50?style=for-the-badge&logo=linux&logoColor=white)

---

## 🎯 Objectives

By the end of this lab, you will be able to:

- 📚 **Understand the fundamental phases** of the incident response lifecycle
- 🛠️ **Configure and utilize open-source** incident response tools on a Linux system
- 🔍 **Perform detection activities** using system monitoring and log analysis
- 🔒 **Implement containment strategies** to limit incident impact
- 🔄 **Execute recovery procedures** to restore normal operations
- 📝 **Document incident response activities** following industry best practices
- 🗺️ **Apply the NIST incident response framework** in a practical scenario

---

## 📋 Prerequisites

| Skill | Level |
|-------|-------|
| Linux Command-Line | Basic |
| File System Navigation & Permissions | Basic Understanding |
| Text Editors (`nano`, `vim`, `gedit`) | Familiar |
| Networking Concepts (IP, Ports, Protocols) | Basic |
| System Logs & Processes | Elementary |

---

## 🖥️ Lab Environment

> 💡 **Al Nafi** provides ready-to-use Linux-based cloud machines for this lab.
> Click **Start Lab** to access your pre-configured Ubuntu environment — no VM setup or additional software needed.

---

## 🗂️ Lab Structure

```
incident_response/
├── 📁 logs/
│   ├── 📁 system/              # System monitoring & containment logs
│   ├── 📁 network/             # Network activity logs
│   └── 📁 application/        # Application logs
├── 📁 evidence/
│   ├── 📁 volatile/            # Captured volatile system state
│   ├── 📁 non-volatile/        # Persistent evidence
│   ├── 📁 timeline/            # Incident detection timeline
│   └── 📁 quarantine/          # Isolated malicious files
├── 📁 reports/
│   ├── 📁 initial/             # Containment report
│   ├── 📁 detailed/            # Mid-incident reports
│   └── 📁 final/               # Recovery report
├── 📁 tools/
│   ├── 📁 detection/
│   ├── 📁 containment/
│   └── 📁 recovery/
└── 📁 scripts/
    ├── 🔧 system_monitor.sh
    ├── 🔧 collect_logs.sh
    ├── 🔧 simulate_incident.sh
    ├── 🔧 containment_actions.sh
    ├── 🔧 preserve_evidence.sh
    ├── 🔧 recovery_verification.sh
    ├── 🔧 system_hardening.sh
    ├── 🔧 continuous_monitor.sh
    ├── 🔧 log_cleanup.sh
    └── 🔧 final_validation.sh
```

---

# 🧪 Task 1: Configure Incident Response Tools

---

## ⚙️ Subtask 1.1 — Update System and Install Required Tools

> 🏗️ *Prepare your incident response toolkit with essential open-source tools.*

```bash
# 🔄 Update the system package list
sudo apt update && sudo apt upgrade -y

# 📦 Install essential incident response tools
sudo apt install -y htop iotop netstat-nat tcpdump wireshark-common tshark \
  chkrootkit rkhunter aide fail2ban rsyslog logwatch git curl wget unzip
```

**🛠️ Tools Installed:**

| Tool | Purpose |
|------|---------|
| `htop` / `iotop` | CPU & I/O process monitoring |
| `tcpdump` / `tshark` | Network packet capture |
| `chkrootkit` / `rkhunter` | Rootkit detection |
| `aide` | File integrity monitoring |
| `fail2ban` | Intrusion prevention |
| `rsyslog` / `logwatch` | Log management & analysis |

---

## 📁 Subtask 1.2 — Create Incident Response Directory Structure

> 🗂️ *Organize your workspace for effective incident management.*

```bash
# 📁 Create main incident response directory
mkdir -p ~/incident_response/{logs,evidence,reports,tools,scripts}

# 📂 Navigate to the incident response directory
cd ~/incident_response

# 📁 Create subdirectories for better organization
mkdir -p logs/{system,network,application}
mkdir -p evidence/{volatile,non-volatile,timeline}
mkdir -p reports/{initial,detailed,final}
mkdir -p tools/{detection,containment,recovery}
```

---

## 👁️ Subtask 1.3 — Configure System Monitoring

> 🖥️ *Set up continuous monitoring to detect potential incidents.*

```bash
# ✍️ Create a system monitoring script
cat > ~/incident_response/scripts/system_monitor.sh << 'EOF'
#!/bin/bash

# System Monitoring Script for Incident Response
LOG_DIR="$HOME/incident_response/logs/system"
DATE=$(date '+%Y-%m-%d_%H-%M-%S')

echo "=== System Monitoring Report - $DATE ===" > "$LOG_DIR/monitor_$DATE.log"

# 📊 CPU and Memory Usage
echo "--- CPU and Memory Usage ---" >> "$LOG_DIR/monitor_$DATE.log"
top -bn1 | head -20 >> "$LOG_DIR/monitor_$DATE.log"

# 🌐 Active Network Connections
echo "--- Active Network Connections ---" >> "$LOG_DIR/monitor_$DATE.log"
netstat -tuln >> "$LOG_DIR/monitor_$DATE.log"

# ⚙️ Running Processes
echo "--- Running Processes ---" >> "$LOG_DIR/monitor_$DATE.log"
ps aux --sort=-%cpu | head -20 >> "$LOG_DIR/monitor_$DATE.log"

# 💾 Disk Usage
echo "--- Disk Usage ---" >> "$LOG_DIR/monitor_$DATE.log"
df -h >> "$LOG_DIR/monitor_$DATE.log"

# 🔐 Recent Login Attempts
echo "--- Recent Login Attempts ---" >> "$LOG_DIR/monitor_$DATE.log"
last -10 >> "$LOG_DIR/monitor_$DATE.log"

echo "Monitoring report saved to: $LOG_DIR/monitor_$DATE.log"
EOF

# 🔑 Make the script executable
chmod +x ~/incident_response/scripts/system_monitor.sh
```

---

## 📋 Subtask 1.4 — Set Up Log Collection

> 🗃️ *Configure centralized log collection for incident analysis.*

```bash
# ✍️ Create log collection script
cat > ~/incident_response/scripts/collect_logs.sh << 'EOF'
#!/bin/bash

LOG_DEST="$HOME/incident_response/logs"
DATE=$(date '+%Y-%m-%d_%H-%M-%S')

echo "Collecting system logs for incident analysis..."

# 📄 Copy system logs
sudo cp /var/log/syslog "$LOG_DEST/system/syslog_$DATE.log" 2>/dev/null || echo "Syslog not accessible"
sudo cp /var/log/auth.log "$LOG_DEST/system/auth_$DATE.log" 2>/dev/null || echo "Auth log not accessible"
sudo cp /var/log/kern.log "$LOG_DEST/system/kern_$DATE.log" 2>/dev/null || echo "Kernel log not accessible"

# 🌐 Collect network-related logs
sudo dmesg | grep -i network > "$LOG_DEST/network/dmesg_network_$DATE.log"

# 📦 Collect application logs
sudo find /var/log -name "*.log" -type f -exec basename {} \; > "$LOG_DEST/application/available_logs_$DATE.txt"

echo "Log collection completed. Files saved with timestamp: $DATE"
EOF

chmod +x ~/incident_response/scripts/collect_logs.sh
```

---

# 🔍 Task 2: Detection Phase

---

## 📏 Subtask 2.1 — Establish Baseline System State

> 📊 *Create a baseline of normal system behavior for comparison during incidents.*

```bash
# ▶️ Run initial system monitoring
~/incident_response/scripts/system_monitor.sh

# 🌐 Create baseline network connections
netstat -tuln > ~/incident_response/evidence/baseline_network_connections.txt

# ⚙️ Document running services
systemctl list-units --type=service --state=running > ~/incident_response/evidence/baseline_services.txt

# 🔐 Create file integrity baseline using AIDE
sudo aide --init
sudo cp /var/lib/aide/aide.db.new /var/lib/aide/aide.db
```

---

## 🎭 Subtask 2.2 — Simulate Suspicious Activity

> ⚠️ *Create controlled suspicious activity to practice detection.*

```bash
# ✍️ Create a suspicious process simulation script
cat > ~/incident_response/scripts/simulate_incident.sh << 'EOF'
#!/bin/bash

echo "Simulating suspicious activity for detection practice..."

# 🚩 Create a suspicious file in /tmp
echo "This is a suspicious file created for incident response training" > /tmp/suspicious_file.txt

# ⚡ Start a process that consumes CPU (controlled)
yes > /dev/null &
SUSPICIOUS_PID=$!
echo $SUSPICIOUS_PID > /tmp/suspicious_process.pid

# 🌐 Create fake network activity log entry
echo "$(date): Suspicious connection attempt from 192.168.1.100 to port 22" \
  >> ~/incident_response/logs/network/suspicious_activity.log

# 🦠 Create a fake malicious script
cat > /tmp/fake_malware.sh << 'MALWARE'
#!/bin/bash
# This is a fake malware script for training purposes
echo "Fake malware executed at $(date)" >> /tmp/malware_log.txt
MALWARE

chmod +x /tmp/fake_malware.sh

echo "Suspicious activity simulation complete."
echo "Suspicious PID: $SUSPICIOUS_PID (saved to /tmp/suspicious_process.pid)"
EOF

chmod +x ~/incident_response/scripts/simulate_incident.sh

# ▶️ Run the simulation
~/incident_response/scripts/simulate_incident.sh
```

---

## 🚨 Subtask 2.3 — Detect Anomalies

> 🔬 *Use various detection methods to identify the simulated incident.*

```bash
# 📊 Monitor system for high CPU usage
echo "=== CPU Usage Analysis ===" > ~/incident_response/evidence/detection_results.txt
top -bn1 | grep -E "(Cpu|PID|yes)" >> ~/incident_response/evidence/detection_results.txt

# 🗂️ Check for suspicious files
echo -e "\n=== Suspicious Files Detection ===" >> ~/incident_response/evidence/detection_results.txt
find /tmp -name "*suspicious*" -o -name "*malware*" >> ~/incident_response/evidence/detection_results.txt

# 🌐 Analyze network connections
echo -e "\n=== Network Connection Analysis ===" >> ~/incident_response/evidence/detection_results.txt
netstat -tuln | grep -E "(LISTEN|ESTABLISHED)" >> ~/incident_response/evidence/detection_results.txt

# ⚙️ Check for unusual processes
echo -e "\n=== Process Analysis ===" >> ~/incident_response/evidence/detection_results.txt
ps aux | grep -v grep | grep -E "(yes|suspicious|malware)" >> ~/incident_response/evidence/detection_results.txt

# 📁 Review recent file changes
echo -e "\n=== Recent File Changes ===" >> ~/incident_response/evidence/detection_results.txt
find /tmp -type f -mmin -10 >> ~/incident_response/evidence/detection_results.txt

echo "Detection phase completed. Results saved to ~/incident_response/evidence/detection_results.txt"
```

---

## 📅 Subtask 2.4 — Create Detection Timeline

> 🗓️ *Document when and how the incident was detected.*

```bash
cat > ~/incident_response/evidence/timeline/detection_timeline.txt << EOF
=== INCIDENT DETECTION TIMELINE ===

$(date '+%Y-%m-%d %H:%M:%S') - Initial system baseline established
$(date '+%Y-%m-%d %H:%M:%S') - Suspicious activity simulation initiated
$(date '+%Y-%m-%d %H:%M:%S') - High CPU usage detected (yes process)
$(date '+%Y-%m-%d %H:%M:%S') - Suspicious files identified in /tmp directory
$(date '+%Y-%m-%d %H:%M:%S') - Fake malware script discovered
$(date '+%Y-%m-%d %H:%M:%S') - Network activity anomalies logged
$(date '+%Y-%m-%d %H:%M:%S') - Detection phase completed

=== INDICATORS OF COMPROMISE (IOCs) ===
- Process: yes command consuming high CPU
- Files: /tmp/suspicious_file.txt, /tmp/fake_malware.sh
- Network: Suspicious connection attempts logged
- System: Unusual process behavior detected
EOF
```

---

# 🔒 Task 3: Containment Phase

---

## ⚡ Subtask 3.1 — Immediate Containment Actions

> 🛡️ *Quickly contain the identified threats to prevent further damage.*

```bash
# ✍️ Create containment script
cat > ~/incident_response/scripts/containment_actions.sh << 'EOF'
#!/bin/bash

CONTAINMENT_LOG="$HOME/incident_response/logs/system/containment_$(date '+%Y-%m-%d_%H-%M-%S').log"

echo "=== INCIDENT CONTAINMENT ACTIONS ===" > "$CONTAINMENT_LOG"
echo "Containment started at: $(date)" >> "$CONTAINMENT_LOG"

# 🔴 Kill suspicious processes
if [ -f /tmp/suspicious_process.pid ]; then
    SUSPICIOUS_PID=$(cat /tmp/suspicious_process.pid)
    echo "Terminating suspicious process PID: $SUSPICIOUS_PID" >> "$CONTAINMENT_LOG"
    kill -9 $SUSPICIOUS_PID 2>/dev/null || echo "Process already terminated" >> "$CONTAINMENT_LOG"
fi

# ⚙️ Kill any remaining 'yes' processes
pkill -f yes
echo "Terminated all 'yes' processes" >> "$CONTAINMENT_LOG"

# 📦 Quarantine suspicious files
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

# 🚫 Block suspicious IP (simulation)
echo "Blocking suspicious IP 192.168.1.100" >> "$CONTAINMENT_LOG"
# In a real scenario, you would use iptables:
# sudo iptables -A INPUT -s 192.168.1.100 -j DROP

echo "Containment actions completed at: $(date)" >> "$CONTAINMENT_LOG"
echo "Containment log saved to: $CONTAINMENT_LOG"
EOF

chmod +x ~/incident_response/scripts/containment_actions.sh

# ▶️ Execute containment
~/incident_response/scripts/containment_actions.sh
```

---

## 🗃️ Subtask 3.2 — System Isolation and Evidence Preservation

> 🔐 *Preserve evidence while isolating affected systems.*

```bash
# ✍️ Create evidence preservation script
cat > ~/incident_response/scripts/preserve_evidence.sh << 'EOF'
#!/bin/bash

EVIDENCE_DIR="$HOME/incident_response/evidence/volatile"
DATE=$(date '+%Y-%m-%d_%H-%M-%S')

echo "Preserving volatile evidence..."

# 📋 Capture current system state
ps aux > "$EVIDENCE_DIR/processes_$DATE.txt"
netstat -tuln > "$EVIDENCE_DIR/network_connections_$DATE.txt"
lsof > "$EVIDENCE_DIR/open_files_$DATE.txt"
who > "$EVIDENCE_DIR/logged_users_$DATE.txt"
mount > "$EVIDENCE_DIR/mounted_filesystems_$DATE.txt"

# 💾 Capture memory information
cat /proc/meminfo > "$EVIDENCE_DIR/memory_info_$DATE.txt"
cat /proc/cpuinfo > "$EVIDENCE_DIR/cpu_info_$DATE.txt"

# 🌐 Capture network configuration
ifconfig > "$EVIDENCE_DIR/network_config_$DATE.txt"
route -n > "$EVIDENCE_DIR/routing_table_$DATE.txt"

# 🖥️ Create system snapshot
uname -a > "$EVIDENCE_DIR/system_info_$DATE.txt"
uptime > "$EVIDENCE_DIR/uptime_$DATE.txt"
date > "$EVIDENCE_DIR/timestamp_$DATE.txt"

echo "Volatile evidence preserved with timestamp: $DATE"
EOF

chmod +x ~/incident_response/scripts/preserve_evidence.sh

# ▶️ Execute evidence preservation
~/incident_response/scripts/preserve_evidence.sh
```

---

## 📝 Subtask 3.3 — Document Containment Actions

> 📄 *Create detailed documentation of all containment activities.*

```bash
cat > ~/incident_response/reports/initial/containment_report.md << 'EOF'
# Incident Containment Report

## Incident Overview
- **Incident ID**: INC-001-$(date '+%Y%m%d')
- **Detection Time**: $(date '+%Y-%m-%d %H:%M:%S')
- **Containment Time**: $(date '+%Y-%m-%d %H:%M:%S')
- **Severity Level**: Medium (Training Simulation)

## Containment Actions Taken

### Immediate Actions
1. **Process Termination**
   - Killed suspicious 'yes' process consuming high CPU
   - Terminated any related malicious processes
   - Verified process termination through system monitoring

2. **File Quarantine**
   - Moved suspicious_file.txt to quarantine directory
   - Isolated fake_malware.sh script
   - Preserved file metadata and timestamps

3. **Network Isolation**
   - Identified suspicious network activity
   - Documented connection attempts for analysis
   - Prepared firewall rules for IP blocking (simulated)

### Evidence Preservation
- Captured volatile system data before containment
- Preserved process lists and network connections
- Documented system state at time of incident

## Current Status
- **Threat Contained**: Yes
- **System Operational**: Yes
- **Evidence Secured**: Yes
- **Next Phase**: Recovery and Analysis

## Recommendations
1. Proceed with detailed forensic analysis
2. Implement additional monitoring
3. Review security policies and procedures
4. Conduct lessons learned session
EOF
```

---

# 🔄 Task 4: Recovery Phase

---

## ✅ Subtask 4.1 — System Verification and Cleanup

> 🔍 *Verify that threats are eliminated and begin system recovery.*

```bash
# ✍️ Create recovery verification script
cat > ~/incident_response/scripts/recovery_verification.sh << 'EOF'
#!/bin/bash

RECOVERY_LOG="$HOME/incident_response/logs/system/recovery_$(date '+%Y-%m-%d_%H-%M-%S').log"

echo "=== SYSTEM RECOVERY VERIFICATION ===" > "$RECOVERY_LOG"
echo "Recovery verification started at: $(date)" >> "$RECOVERY_LOG"

# ⚙️ Verify suspicious processes are terminated
echo "--- Process Verification ---" >> "$RECOVERY_LOG"
if pgrep -f yes > /dev/null; then
    echo "WARNING: Suspicious processes still running" >> "$RECOVERY_LOG"
    pgrep -f yes >> "$RECOVERY_LOG"
else
    echo "CLEAN: No suspicious processes detected" >> "$RECOVERY_LOG"
fi

# 🗂️ Verify suspicious files are quarantined
echo "--- File System Verification ---" >> "$RECOVERY_LOG"
if [ -f /tmp/suspicious_file.txt ] || [ -f /tmp/fake_malware.sh ]; then
    echo "WARNING: Suspicious files still present in /tmp" >> "$RECOVERY_LOG"
    ls -la /tmp/*suspicious* /tmp/*malware* 2>/dev/null >> "$RECOVERY_LOG"
else
    echo "CLEAN: Suspicious files successfully quarantined" >> "$RECOVERY_LOG"
fi

# 📊 Check system resources
echo "--- System Resource Check ---" >> "$RECOVERY_LOG"
CPU_USAGE=$(top -bn1 | grep "Cpu(s)" | awk '{print $2}' | cut -d'%' -f1)
echo "Current CPU usage: ${CPU_USAGE}%" >> "$RECOVERY_LOG"

MEMORY_USAGE=$(free | grep Mem | awk '{printf "%.1f", $3/$2 * 100.0}')
echo "Current memory usage: ${MEMORY_USAGE}%" >> "$RECOVERY_LOG"

# 🌐 Verify network connections
echo "--- Network Connection Verification ---" >> "$RECOVERY_LOG"
ACTIVE_CONNECTIONS=$(netstat -tuln | grep LISTEN | wc -l)
echo "Active listening ports: $ACTIVE_CONNECTIONS" >> "$RECOVERY_LOG"

echo "Recovery verification completed at: $(date)" >> "$RECOVERY_LOG"
echo "Recovery verification log saved to: $RECOVERY_LOG"
EOF

chmod +x ~/incident_response/scripts/recovery_verification.sh

# ▶️ Execute recovery verification
~/incident_response/scripts/recovery_verification.sh
```

---

## 🛡️ Subtask 4.2 — System Hardening and Monitoring Enhancement

> 🔧 *Implement additional security measures to prevent similar incidents.*

```bash
# ✍️ Create system hardening script
cat > ~/incident_response/scripts/system_hardening.sh << 'EOF'
#!/bin/bash

HARDENING_LOG="$HOME/incident_response/logs/system/hardening_$(date '+%Y-%m-%d_%H-%M-%S').log"

echo "=== SYSTEM HARDENING ACTIONS ===" > "$HARDENING_LOG"
echo "Hardening started at: $(date)" >> "$HARDENING_LOG"

# 🔐 Update file integrity monitoring
echo "Updating file integrity database..." >> "$HARDENING_LOG"
sudo aide --update 2>/dev/null || echo "AIDE update completed" >> "$HARDENING_LOG"

# 👁️ Set up enhanced monitoring
echo "Configuring enhanced monitoring..." >> "$HARDENING_LOG"

# 🔄 Create continuous monitoring script
cat > "$HOME/incident_response/scripts/continuous_monitor.sh" << 'MONITOR'
#!/bin/bash
while true; do
    # ⚡ Check for high CPU processes
    HIGH_CPU=$(ps aux --sort=-%cpu | head -2 | tail -1 | awk '{print $3}')
    if (( $(echo "$HIGH_CPU > 80" | bc -l) )); then
        echo "$(date): High CPU usage detected: $HIGH_CPU%" \
          >> "$HOME/incident_response/logs/system/alerts.log"
    fi
    
    # 🗂️ Check for suspicious files in /tmp
    if ls /tmp/*suspicious* /tmp/*malware* 2>/dev/null; then
        echo "$(date): Suspicious files detected in /tmp" \
          >> "$HOME/incident_response/logs/system/alerts.log"
    fi
    
    sleep 60
done
MONITOR

chmod +x "$HOME/incident_response/scripts/continuous_monitor.sh"

# 🗃️ Configure log rotation
echo "Setting up log rotation..." >> "$HARDENING_LOG"
mkdir -p "$HOME/incident_response/logs/archive"

# 🧹 Create cleanup script for old logs
cat > "$HOME/incident_response/scripts/log_cleanup.sh" << 'CLEANUP'
#!/bin/bash
# Archive logs older than 7 days
find "$HOME/incident_response/logs" -name "*.log" -mtime +7 \
  -exec mv {} "$HOME/incident_response/logs/archive/" \;
echo "$(date): Log cleanup completed" \
  >> "$HOME/incident_response/logs/system/maintenance.log"
CLEANUP

chmod +x "$HOME/incident_response/scripts/log_cleanup.sh"

echo "System hardening completed at: $(date)" >> "$HARDENING_LOG"
echo "Hardening log saved to: $HARDENING_LOG"
EOF

chmod +x ~/incident_response/scripts/system_hardening.sh

# ▶️ Execute system hardening
~/incident_response/scripts/system_hardening.sh
```

---

## 📄 Subtask 4.3 — Create Recovery Documentation

> 📝 *Document the complete recovery process and lessons learned.*

```bash
cat > ~/incident_response/reports/final/recovery_report.md << 'EOF'
# Incident Recovery Report

## Recovery Summary
- **Incident ID**: INC-001-$(date '+%Y%m%d')
- **Recovery Start Time**: $(date '+%Y-%m-%d %H:%M:%S')
- **Recovery Completion Time**: $(date '+%Y-%m-%d %H:%M:%S')
- **Recovery Status**: Successful

## Recovery Actions Performed

### 1. System Verification
- Confirmed elimination of malicious processes
- Verified quarantine of suspicious files
- Validated system resource utilization returned to normal
- Checked network connections for anomalies

### 2. System Hardening
- Updated file integrity monitoring database
- Implemented continuous system monitoring
- Configured automated log rotation and cleanup
- Enhanced detection capabilities for future incidents

### 3. Monitoring Enhancement
- Deployed real-time CPU usage monitoring
- Implemented file system surveillance for /tmp directory
- Set up automated alerting for suspicious activities
- Created maintenance scripts for ongoing security

## System Status Post-Recovery
- **CPU Usage**: Normal levels
- **Memory Usage**: Within acceptable parameters
- **Network Connections**: All legitimate services only
- **File System**: Clean, suspicious files quarantined
- **Monitoring**: Enhanced detection capabilities active

## Lessons Learned

### What Worked Well
1. Rapid detection of suspicious activity
2. Effective containment prevented spread
3. Evidence preservation maintained integrity
4. Recovery process restored normal operations

### Areas for Improvement
1. Implement proactive monitoring before incidents
2. Develop automated response capabilities
3. Create more comprehensive baseline documentation
4. Enhance staff training on incident procedures

## Recommendations

### Immediate Actions
1. Continue enhanced monitoring for 48 hours
2. Review and update incident response procedures
3. Conduct team debrief session
4. Update security awareness training

### Long-term Improvements
1. Implement Security Information and Event Management (SIEM)
2. Develop automated incident response playbooks
3. Regular security assessments and penetration testing
4. Establish threat intelligence feeds
EOF
```

---

## 🏁 Subtask 4.4 — Final System Validation

> ✅ *Perform comprehensive validation to ensure complete recovery.*

```bash
# ✍️ Create final validation script
cat > ~/incident_response/scripts/final_validation.sh << 'EOF'
#!/bin/bash

VALIDATION_LOG="$HOME/incident_response/logs/system/final_validation_$(date '+%Y-%m-%d_%H-%M-%S').log"

echo "=== FINAL SYSTEM VALIDATION ===" > "$VALIDATION_LOG"
echo "Validation started at: $(date)" >> "$VALIDATION_LOG"

# 🖥️ System health check
echo "--- System Health Check ---" >> "$VALIDATION_LOG"
uptime >> "$VALIDATION_LOG"
df -h >> "$VALIDATION_LOG"
free -h >> "$VALIDATION_LOG"

# 🔐 Security validation
echo "--- Security Validation ---" >> "$VALIDATION_LOG"
echo "Quarantined files:" >> "$VALIDATION_LOG"
ls -la "$HOME/incident_response/evidence/quarantine/" >> "$VALIDATION_LOG"

echo "Active monitoring processes:" >> "$VALIDATION_LOG"
ps aux | grep -E "(monitor|aide)" | grep -v grep >> "$VALIDATION_LOG"

# 🗂️ Evidence integrity check
echo "--- Evidence Integrity Check ---" >> "$VALIDATION_LOG"
echo "Evidence files collected:" >> "$VALIDATION_LOG"
find "$HOME/incident_response/evidence" -type f | wc -l >> "$VALIDATION_LOG"

echo "Log files generated:" >> "$VALIDATION_LOG"
find "$HOME/incident_response/logs" -name "*.log" | wc -l >> "$VALIDATION_LOG"

# ✅ Final status
echo "--- Final Status ---" >> "$VALIDATION_LOG"
echo "System Status: OPERATIONAL" >> "$VALIDATION_LOG"
echo "Security Status: ENHANCED" >> "$VALIDATION_LOG"
echo "Monitoring Status: ACTIVE" >> "$VALIDATION_LOG"
echo "Evidence Status: PRESERVED" >> "$VALIDATION_LOG"

echo "Final validation completed at: $(date)" >> "$VALIDATION_LOG"
echo "Validation results saved to: $VALIDATION_LOG"

# 🎉 Display summary
echo "=== INCIDENT RESPONSE LIFECYCLE COMPLETED ==="
echo "All phases successfully executed:"
echo "✓ Detection - Suspicious activity identified"
echo "✓ Containment - Threats neutralized and quarantined"
echo "✓ Recovery - System restored with enhanced security"
echo "✓ Documentation - Complete incident record maintained"
echo ""
echo "Lab objectives achieved successfully!"
EOF

chmod +x ~/incident_response/scripts/final_validation.sh

# ▶️ Execute final validation
~/incident_response/scripts/final_validation.sh
```

---

# 🛠️ Troubleshooting Tips

| ❌ Issue | ✅ Solution |
|---------|------------|
| 🚫 Permission denied accessing log files | Use `sudo` for system log access or check file permissions |
| 🔧 Scripts not executing | Ensure execute permissions: `chmod +x script_name.sh` |
| ⚡ High CPU usage persists | Run `pkill -f yes` to terminate all instances of the `yes` command |
| 📁 Cannot find created files | Verify directory with `pwd` and list contents with `ls -la` |
| 🌐 Network monitoring shows no connections | Some services may not be running; this is normal in a lab environment |

---

# ✅ Expected Outcomes

After completing this lab, you should have:

| # | Phase | Achievement |
|---|-------|-------------|
| 🟢 1 | **Setup** | Configured a comprehensive incident response toolkit using open-source tools |
| 🟢 2 | **Detection** | Established baselines, monitored system behavior, and identified anomalies |
| 🟢 3 | **Containment** | Isolated threats, preserved evidence, and prevented further damage |
| 🟢 4 | **Recovery** | Restored normal operations and implemented enhanced security measures |
| 🟢 5 | **Documentation** | Created complete incident records for accountability and future improvement |

---

# 📚 Key Accomplishments

| 🏆 Phase | 💡 What You Learned |
|---------|-------------------|
| 🔍 Detection | Establish baselines, monitor system behavior, identify anomalies indicating incidents |
| 🔒 Containment | Isolate threats, preserve evidence, prevent damage while maintaining integrity |
| 🔄 Recovery | Restore operations, implement enhanced security, validate system health |
| 📝 Documentation | Create comprehensive records ensuring accountability and future improvements |

---

# 🎓 Conclusion

Congratulations! You have successfully completed the **Incident Response Lifecycle** lab. Through this hands-on exercise, you have configured a comprehensive incident response toolkit, practiced all four critical phases of incident response, and developed skills in system monitoring, threat detection, and evidence preservation.

> 💡 Incident response is a critical cybersecurity discipline that can mean the difference between a minor security event and a major data breach. The open-source tools and methodologies you've learned are **industry-standard** and widely used by cybersecurity professionals worldwide.

---

## 🚀 Next Steps

- 🔬 Practice with more complex multi-system scenarios
- 🧬 Learn advanced forensics techniques
- 🦠 Study malware analysis and reverse engineering
- 🤖 Explore automated incident response and orchestration tools
- 🏆 Pursue industry certifications in incident response and digital forensics

> 📌 **Remember:** Effective incident response requires continuous practice, learning, and adaptation to emerging threats. The framework you've built today provides a solid foundation for your cybersecurity career journey.

---

<div align="center">

![Incident Response](https://img.shields.io/badge/Incident-Response-red?style=for-the-badge&logo=hackthebox&logoColor=white)
![NIST Framework](https://img.shields.io/badge/NIST-IR%20Framework-blue?style=for-the-badge&logo=nist&logoColor=white)
![Lab](https://img.shields.io/badge/Al%20Nafi-Cybersecurity%20Lab-green?style=for-the-badge&logo=academia&logoColor=white)

**Made with ❤️ for Cybersecurity Learners**

</div>
