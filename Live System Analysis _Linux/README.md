# 🔬 Live System Analysis (Linux)

> **A hands-on cybersecurity lab for configuring auditd, collecting forensic evidence, correlating logs, and hunting threats on a live Linux system**

![Bash](https://img.shields.io/badge/Bash-Scripting-4EAA25?style=for-the-badge&logo=gnubash&logoColor=white)
![Linux](https://img.shields.io/badge/Linux-Ubuntu-E95420?style=for-the-badge&logo=ubuntu&logoColor=white)
![Auditd](https://img.shields.io/badge/Auditd-System%20Monitoring-8e44ad?style=for-the-badge&logo=linux&logoColor=white)
![Ausearch](https://img.shields.io/badge/Ausearch-Log%20Query-2471a3?style=for-the-badge&logo=linux&logoColor=white)
![Forensics](https://img.shields.io/badge/Forensics-Live%20Analysis-c0392b?style=for-the-badge&logo=hackthebox&logoColor=white)
![Threat Hunting](https://img.shields.io/badge/Threat-Hunting-e67e22?style=for-the-badge&logo=hackthebox&logoColor=white)

---

## 🎯 Objectives

By the end of this lab, you will be able to:

- ⚙️ **Configure and utilize auditd** for system monitoring and log collection
- 🔭 **Implement live system monitoring** using open-source forensic tools
- 🐍 **Create custom scripts** to analyze system logs for indicators of compromise
- 🚨 **Identify suspicious activities** through log correlation and analysis
- 📊 **Generate forensic reports** based on collected evidence from a live Linux system

---

## 📋 Prerequisites

| Skill | Level |
|-------|-------|
| Linux Command Line & File Navigation | Basic |
| Text Editors (`nano` or `vim`) | Familiar |
| System Logs & Their Locations | Basic Understanding |
| Shell Scripting Concepts | Basic |

---

## 🖥️ Lab Environment

> 💡 **Al Nafi Cloud Machine Setup:** This lab runs on a single Linux-based cloud machine.
> Click **Start Lab** to access your pre-configured Ubuntu environment.
> All tools and configurations will be performed on this machine.

---

## 🗂️ Lab Structure

```
forensic_analysis/
├── 🔧 system_info_collector.sh       # System information collection script
├── 🔧 audit_analyzer.sh              # Audit log analysis script
├── 🔧 log_correlator.sh              # Log correlation script
├── 🔧 threat_hunter.sh               # Advanced threat hunting script
├── 📄 final_report.txt               # Consolidated forensic report
├── 📁 system_analysis_<timestamp>/
│   ├── 📝 system_info.txt
│   ├── 📝 user_info.txt
│   ├── 📝 process_info.txt
│   ├── 📝 network_info.txt
│   └── 📝 filesystem_info.txt
├── 📁 audit_analysis_<timestamp>/
│   ├── 📝 identity_changes.txt
│   ├── 📝 process_execution.txt
│   └── 📝 analysis_summary.txt
├── 📁 correlation_analysis_<timestamp>/
│   ├── 📝 auth_analysis.txt
│   ├── 📝 system_analysis.txt
│   ├── 📝 network_analysis.txt
│   ├── 📝 timeline_correlation.txt
│   ├── 📝 ioc_analysis.txt
│   └── 📝 forensic_report.txt
└── 📁 threat_hunting_<timestamp>/
    ├── 📝 persistence_analysis.txt
    ├── 📝 process_anomalies.txt
    ├── 📝 suspicious_files.txt
    ├── 📝 network_indicators.txt
    └── 📝 threat_report.txt
```

---

# 🧪 Task 1: Configure Auditd for System Monitoring

---

## ⚙️ Step 1 — Install and Configure Auditd

> 🏗️ *Install required packages and start the auditd service.*

```bash
# 📦 Install required packages
sudo apt update
sudo apt install -y auditd audispd-plugins

# 🔍 Check and start the auditd service
sudo systemctl status auditd
sudo systemctl start auditd
sudo systemctl enable auditd

# 💾 Create backup of original configuration
sudo cp /etc/audit/auditd.conf /etc/audit/auditd.conf.backup
sudo cp /etc/audit/rules.d/audit.rules /etc/audit/rules.d/audit.rules.backup
```

---

## 📋 Step 2 — Configure Audit Rules

> 🔐 *Create a comprehensive audit rules file to monitor critical system activities.*

```bash
# ✍️ Create a comprehensive audit rules file
sudo nano /etc/audit/rules.d/forensic.rules
```

Add the following audit rules:

```bash
# 🗑️ Delete existing rules and set buffer
-D
-b 8192
-f 1

# 👤 Monitor authentication files
-w /etc/passwd -p wa -k identity
-w /etc/group -p wa -k identity
-w /etc/shadow -p wa -k identity
-w /etc/sudoers -p wa -k identity

# 🖥️ Monitor system configuration
-w /etc/ssh/sshd_config -p wa -k sshd
-w /etc/hosts -p wa -k network

# 🔐 Monitor login events
-w /var/log/lastlog -p wa -k logins
-w /var/log/wtmp -p wa -k logins

# ⚙️ Monitor process execution
-a always,exit -F arch=b64 -S execve -k process_execution
-a always,exit -F arch=b32 -S execve -k process_execution

# 🔺 Monitor privilege escalation
-w /bin/su -p x -k privilege_escalation
-w /usr/bin/sudo -p x -k privilege_escalation

# ⏰ Monitor cron jobs
-w /etc/crontab -p wa -k cron
-w /var/spool/cron/crontabs/ -p wa -k cron

# 🔒 Make rules immutable
-e 2
```

```bash
# ▶️ Load the new audit rules
sudo augenrules --load
sudo systemctl restart auditd
sudo auditctl -l
```

**📖 Audit Rule Keys Reference:**

| Key | Monitored Activity |
|-----|--------------------|
| `identity` | Changes to user/group/shadow/sudoers files |
| `sshd` / `network` | SSH config and hosts file changes |
| `logins` | Login and logout events |
| `process_execution` | All process executions (64-bit & 32-bit) |
| `privilege_escalation` | `su` and `sudo` usage |
| `cron` | Scheduled task modifications |

---

## 📁 Step 3 — Set Up Forensic Analysis Directory

> 🗂️ *Create the working directory for all forensic outputs.*

```bash
# 📁 Create working directory
mkdir -p ~/forensic_analysis
cd ~/forensic_analysis
```

---

# 📊 Task 2: Create System Information Collection Script

---

## 🏗️ Step 1 — Create System Info Collector

> 🛠️ *Build a comprehensive system information collection script. Complete the `TODO` sections.*

```bash
# ✍️ Create the script file
nano ~/forensic_analysis/system_info_collector.sh
```

```bash
#!/bin/bash

# System Information Collection Script
# Students: Complete the TODO sections to collect comprehensive system data

TIMESTAMP=$(date +"%Y%m%d_%H%M%S")
OUTPUT_DIR="system_analysis_$TIMESTAMP"
mkdir -p "$OUTPUT_DIR"

echo "=== Starting System Information Collection ==="

# TODO: Collect basic system information
# Hint: Use hostname, uname, uptime, date commands
collect_system_info() {
    {
        echo "=== SYSTEM INFORMATION ==="
        # TODO: Add hostname
        # TODO: Add kernel version
        # TODO: Add OS release information
        # TODO: Add system uptime
    } > "$OUTPUT_DIR/system_info.txt"
}

# TODO: Collect user information
# Hint: Use who, last, lastb, /etc/passwd
collect_user_info() {
    {
        echo "=== USER INFORMATION ==="
        # TODO: List currently logged in users
        # TODO: Show last 20 login records
        # TODO: Show failed login attempts
        # TODO: List all system users
    } > "$OUTPUT_DIR/user_info.txt"
}

# TODO: Collect process information
# Hint: Use ps, pstree, top commands
collect_process_info() {
    {
        echo "=== PROCESS INFORMATION ==="
        # TODO: List all running processes sorted by CPU
        # TODO: Display process tree
        # TODO: Show top CPU consuming processes
    } > "$OUTPUT_DIR/process_info.txt"
}

# TODO: Collect network information
# Hint: Use ip, netstat, ss commands
collect_network_info() {
    {
        echo "=== NETWORK INFORMATION ==="
        # TODO: Show network interfaces
        # TODO: Display routing table
        # TODO: List active connections
        # TODO: Show listening services
    } > "$OUTPUT_DIR/network_info.txt"
}

# TODO: Collect filesystem information
# Hint: Use mount, df, find commands
collect_filesystem_info() {
    {
        echo "=== FILESYSTEM INFORMATION ==="
        # TODO: List mounted filesystems
        # TODO: Show disk usage
        # TODO: Find recently modified files in /var/log
    } > "$OUTPUT_DIR/filesystem_info.txt"
}

# ▶️ Execute collection functions
collect_system_info
collect_user_info
collect_process_info
collect_network_info
collect_filesystem_info

echo "System information collection completed!"
echo "Results saved in: $OUTPUT_DIR"
```

```bash
# 🔑 Make the script executable
chmod +x ~/forensic_analysis/system_info_collector.sh
```

---

## 🔍 Step 2 — Create Audit Log Analyzer

> 🛠️ *Build an audit log analysis script. Complete the `TODO` sections.*

```bash
# ✍️ Create the audit analyzer script
nano ~/forensic_analysis/audit_analyzer.sh
```

```bash
#!/bin/bash

# Audit Log Analysis Script
# Students: Complete the analysis functions

TIMESTAMP=$(date +"%Y%m%d_%H%M%S")
AUDIT_LOG="/var/log/audit/audit.log"
OUTPUT_DIR="audit_analysis_$TIMESTAMP"
mkdir -p "$OUTPUT_DIR"

echo "=== Starting Audit Log Analysis ==="

# TODO: Function to analyze specific audit events
# Hint: Use ausearch command with -k flag for key-based searches
analyze_events() {
    local event_type="$1"
    local description="$2"
    local output_file="$3"

    {
        echo "=== $description ==="
        echo "Analysis Date: $(date)"

        # TODO: Search for events using ausearch
        # TODO: Count total occurrences
        # TODO: Display summary statistics

    } > "$OUTPUT_DIR/$output_file"
}

# TODO: Analyze different event types
# Call analyze_events for: identity, logins, process_execution, privilege_escalation

# TODO: Analyze failed system calls
# Hint: Use ausearch with -sv no flag

# TODO: Generate summary report
# Include: event counts, top users, suspicious activity indicators

echo "Audit log analysis completed!"
echo "Results saved in: $OUTPUT_DIR"
```

```bash
# 🔑 Make executable
chmod +x ~/forensic_analysis/audit_analyzer.sh
```

---

## 🔗 Step 3 — Create Log Correlation Script

> 🛠️ *Build a multi-source log correlation script. Complete the `TODO` sections.*

```bash
# ✍️ Create the correlation script
nano ~/forensic_analysis/log_correlator.sh
```

```bash
#!/bin/bash

# Log Correlation Script
# Students: Implement correlation logic across multiple log sources

TIMESTAMP=$(date +"%Y%m%d_%H%M%S")
OUTPUT_DIR="correlation_analysis_$TIMESTAMP"
mkdir -p "$OUTPUT_DIR"

echo "=== Starting Log Correlation Analysis ==="

# TODO: Analyze authentication logs
analyze_auth_logs() {
    {
        echo "=== AUTHENTICATION LOG ANALYSIS ==="
        # TODO: Extract SSH connection attempts from /var/log/auth.log
        # TODO: Identify failed authentication attempts
        # TODO: List successful authentications
        # TODO: Track sudo usage patterns
    } > "$OUTPUT_DIR/auth_analysis.txt"
}

# TODO: Analyze system logs
analyze_system_logs() {
    {
        echo "=== SYSTEM LOG ANALYSIS ==="
        # TODO: Extract recent system messages from /var/log/syslog
        # TODO: Identify error messages
        # TODO: Track service start/stop events
    } > "$OUTPUT_DIR/system_analysis.txt"
}

# TODO: Analyze network activity
analyze_network_activity() {
    {
        echo "=== NETWORK ACTIVITY ANALYSIS ==="
        # TODO: List active network connections
        # TODO: Show listening services
        # TODO: Display ARP table
    } > "$OUTPUT_DIR/network_analysis.txt"
}

# TODO: Create event timeline
create_timeline() {
    {
        echo "=== EVENT TIMELINE CORRELATION ==="
        # TODO: Combine events from auth.log, syslog, and audit.log
        # TODO: Sort events chronologically
        # TODO: Generate event summary by type
    } > "$OUTPUT_DIR/timeline_correlation.txt"
}

# TODO: Identify indicators of compromise
identify_iocs() {
    {
        echo "=== INDICATORS OF COMPROMISE ==="
        # TODO: Check for multiple failed SSH attempts (threshold: 10)
        # TODO: Detect unusual sudo usage patterns
        # TODO: Identify suspicious processes
        # TODO: Check system load anomalies
        # TODO: Generate IOC summary and recommendations
    } > "$OUTPUT_DIR/ioc_analysis.txt"
}

# TODO: Generate comprehensive report
generate_report() {
    {
        echo "=== COMPREHENSIVE FORENSIC REPORT ==="
        # TODO: Create executive summary
        # TODO: Summarize key findings with metrics
        # TODO: List all generated analysis files
        # TODO: Provide actionable recommendations
    } > "$OUTPUT_DIR/forensic_report.txt"
}

# ▶️ Execute all analysis functions
analyze_auth_logs
analyze_system_logs
analyze_network_activity
create_timeline
identify_iocs
generate_report

echo "Log correlation analysis completed!"
echo "Results saved in: $OUTPUT_DIR"
```

```bash
# 🔑 Make executable
chmod +x ~/forensic_analysis/log_correlator.sh
```

---

# ▶️ Task 3: Execute Live System Analysis

---

## ⚡ Step 1 — Generate System Activity

> 🎭 *Create test activity for analysis so the audit logs have events to examine.*

```bash
# 🔐 Generate authentication events
sudo su - $(whoami)
exit

# 📄 Create file modifications
echo "Test forensic data" > ~/test_file.txt
chmod 755 ~/test_file.txt
rm ~/test_file.txt

# 🌐 Generate network activity
ping -c 3 8.8.8.8 > /dev/null 2>&1

# ⏳ Wait for events to be logged
sleep 10
```

---

## 📊 Step 2 — Run System Information Collection

> ▶️ *Execute the collection script and review the gathered data.*

```bash
# 📁 Navigate to forensic directory
cd ~/forensic_analysis

# ▶️ Execute the collection script
./system_info_collector.sh

# 📋 List generated files
ls -la system_analysis_*

# 👁️ View system information
cat system_analysis_*/system_info.txt

# 👤 Check user information
cat system_analysis_*/user_info.txt
```

---

## 🔍 Step 3 — Perform Audit Log Analysis

> ▶️ *Run the audit analyzer and inspect the results.*

```bash
# ▶️ Run the audit analyzer
./audit_analyzer.sh

# 📋 View analysis summary
cat audit_analysis_*/analysis_summary.txt

# 🔍 Check specific event types
cat audit_analysis_*/identity_changes.txt
cat audit_analysis_*/process_execution.txt
```

---

## 🔗 Step 4 — Execute Log Correlation

> ▶️ *Run the correlation script and review all correlated findings.*

```bash
# ▶️ Run the correlation script
./log_correlator.sh

# 📊 View main forensic report
cat correlation_analysis_*/forensic_report.txt

# 📅 Check event timeline
cat correlation_analysis_*/timeline_correlation.txt

# 🚨 Review IOC analysis
cat correlation_analysis_*/ioc_analysis.txt
```

---

# 🎯 Task 4: Advanced Threat Hunting

---

## 🏗️ Step 1 — Create Threat Hunting Script

> 🛠️ *Build an advanced threat hunting script. Complete the `TODO` sections.*

```bash
# ✍️ Create advanced analysis script
nano ~/forensic_analysis/threat_hunter.sh
```

```bash
#!/bin/bash

# Advanced Threat Hunting Script
# Students: Implement threat detection logic

TIMESTAMP=$(date +"%Y%m%d_%H%M%S")
OUTPUT_DIR="threat_hunting_$TIMESTAMP"
mkdir -p "$OUTPUT_DIR"

echo "=== Advanced Threat Hunting Analysis ==="

# TODO: Hunt for persistence mechanisms
hunt_persistence() {
    {
        echo "=== PERSISTENCE MECHANISM ANALYSIS ==="
        # TODO: Check user and system cron jobs
        # TODO: List enabled systemd services
        # TODO: Examine startup scripts in /etc/init.d/
        # TODO: Check user profile files (.bashrc, .profile)
    } > "$OUTPUT_DIR/persistence_analysis.txt"
}

# TODO: Analyze process anomalies
hunt_process_anomalies() {
    {
        echo "=== PROCESS ANOMALY ANALYSIS ==="
        # TODO: Find processes without parent (orphans)
        # TODO: Identify processes running from /tmp or /var/tmp
        # TODO: List high CPU/memory consuming processes
        # TODO: Check for network-related processes
    } > "$OUTPUT_DIR/process_anomalies.txt"
}

# TODO: Search for suspicious files
hunt_suspicious_files() {
    {
        echo "=== SUSPICIOUS FILE ANALYSIS ==="
        # TODO: Find SUID/SGID files
        # TODO: Locate world-writable files
        # TODO: Identify recently modified system files
        # TODO: Check for hidden files in unusual locations
    } > "$OUTPUT_DIR/suspicious_files.txt"
}

# TODO: Analyze network indicators
hunt_network_indicators() {
    {
        echo "=== NETWORK INDICATOR ANALYSIS ==="
        # TODO: Check for unusual listening ports
        # TODO: Identify external connections
        # TODO: Analyze DNS queries (if logs available)
        # TODO: Check firewall rules
    } > "$OUTPUT_DIR/network_indicators.txt"
}

# TODO: Generate threat hunting report
generate_threat_report() {
    {
        echo "=== THREAT HUNTING REPORT ==="
        # TODO: Summarize findings from all hunting functions
        # TODO: Assign risk levels to identified threats
        # TODO: Provide remediation recommendations
    } > "$OUTPUT_DIR/threat_report.txt"
}

# ▶️ Execute hunting functions
hunt_persistence
hunt_process_anomalies
hunt_suspicious_files
hunt_network_indicators
generate_threat_report

echo "Threat hunting completed!"
echo "Results saved in: $OUTPUT_DIR"
```

```bash
# 🔑 Make executable
chmod +x ~/forensic_analysis/threat_hunter.sh
```

**🔍 Threat Hunting Categories:**

| Category | What to Look For |
|----------|-----------------|
| 🔒 Persistence | Cron jobs, systemd services, startup scripts, profile files |
| ⚙️ Process Anomalies | Orphan processes, `/tmp` execution, high CPU/memory usage |
| 📁 Suspicious Files | SUID/SGID files, world-writable, hidden files, recent modifications |
| 🌐 Network Indicators | Unusual ports, external connections, DNS queries, firewall rules |

---

## ▶️ Step 2 — Execute Threat Hunting

> 🎯 *Run the threat hunter and review all findings.*

```bash
# ▶️ Run the threat hunting script
./threat_hunter.sh

# 📊 View threat report
cat threat_hunting_*/threat_report.txt

# 🔒 Check persistence mechanisms
cat threat_hunting_*/persistence_analysis.txt

# ⚙️ Review process anomalies
cat threat_hunting_*/process_anomalies.txt
```

---

## 📄 Step 3 — Consolidate Findings

> 📝 *Create a final consolidated forensic report documenting all findings.*

```bash
# ✍️ Create final consolidated report
nano ~/forensic_analysis/final_report.txt
```

Document your findings including:

| Section | Content |
|---------|---------|
| 📋 Summary | Overall system state at time of analysis |
| 🚨 Security Events | Identified security events and anomalies |
| 🔴 IOCs | Potential indicators of compromise |
| ✅ Recommendations | Recommended remediation actions |
| 📅 Timeline | Timeline of significant events |

---

# ✅ Expected Outcomes

Upon completing this lab, you should have:

| # | Outcome |
|---|---------|
| 🟢 1 | Configured `auditd` with comprehensive monitoring rules |
| 🟢 2 | Created functional forensic analysis scripts |
| 🟢 3 | Collected system information across multiple categories |
| 🟢 4 | Analyzed audit logs for security events |
| 🟢 5 | Correlated events across multiple log sources |
| 🟢 6 | Identified potential indicators of compromise |
| 🟢 7 | Generated professional forensic reports |

**📁 Your analysis directory should contain:**

| Output | Description |
|--------|-------------|
| 📸 System snapshots | Point-in-time system information |
| 🔍 Audit analysis | Parsed and categorized audit events |
| 🔗 Correlation reports | Multi-source event correlation |
| 🎯 Threat hunting results | Persistence, file, and network indicators |
| 📄 Forensic documentation | Consolidated final report |

---

# 🛠️ Troubleshooting Tips

| ❌ Issue | ✅ Solution |
|---------|------------|
| 📋 Auditd rules not loading | Check syntax with `sudo auditctl -l`; verify file is in `/etc/audit/rules.d/`; restart auditd after changes |
| 📭 Scripts produce empty output | Verify log files exist and are readable; check script permissions; ensure sufficient disk space; run with `sudo` if needed |
| 🔍 Ausearch returns no results | Verify auditd is running: `sudo systemctl status auditd`; check rules loaded: `sudo auditctl -l`; generate activity and wait 10–15 seconds; verify audit log: `ls -la /var/log/audit/audit.log` |

---

# 📚 Key Takeaways

| 💡 Insight | Description |
|-----------|-------------|
| 🔍 Auditd Power | Auditd provides detailed system activity monitoring at the kernel level |
| 🔗 Log Correlation | Correlating logs across multiple sources reveals patterns invisible in isolation |
| 🤖 Custom Scripts | Custom scripts enable automated, repeatable forensic analysis |
| 📅 Timeline Analysis | Chronological event analysis helps reconstruct security incidents |
| 📝 Documentation | Systematic documentation is critical for forensic investigations |

---

# 🎓 Conclusion

This lab provided hands-on experience with **live system forensic analysis on Linux**. You configured comprehensive system monitoring using `auditd`, developed custom analysis scripts, and performed log correlation to identify security events.

> 💡 These skills are essential for **incident response**, **security monitoring**, and **forensic investigations** in real-world Linux environments.

---

## 🚀 Next Steps

- 🔬 Expand your scripts to include additional data sources and analysis methods
- 🧠 Explore SIEM integration for centralized log management
- 🦠 Practice with simulated malware scenarios and live attack traffic
- 🏆 Study advanced digital forensics and memory analysis techniques
- 📜 Pursue certifications in Linux forensics and incident response

---

<div align="center">

![Live Forensics](https://img.shields.io/badge/Live-Forensics-red?style=for-the-badge&logo=hackthebox&logoColor=white)
![Linux Analysis](https://img.shields.io/badge/Linux-Analysis-blue?style=for-the-badge&logo=linux&logoColor=white)
![Lab](https://img.shields.io/badge/Al%20Nafi-Cybersecurity%20Lab-green?style=for-the-badge&logo=academia&logoColor=white)

**Made with ❤️ for Cybersecurity Learners**

</div>
