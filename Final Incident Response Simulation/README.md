# 🚨 Final Incident Response Simulation

<div align="center">

# 🛡️ Security Operations Center (SOC) Incident Response 

### Wazuh • Suricata • Zeek • SIEM • Threat Detection • Incident Response

![Platform](https://img.shields.io/badge/Platform-Ubuntu%2020.04-E95420?style=for-the-badge\&logo=ubuntu)
![SIEM](https://img.shields.io/badge/SIEM-Wazuh-0266C8?style=for-the-badge)
![IDS](https://img.shields.io/badge/IDS-Suricata-red?style=for-the-badge)
![NSM](https://img.shields.io/badge/NSM-Zeek-green?style=for-the-badge)
![Language](https://img.shields.io/badge/Scripting-Bash-black?style=for-the-badge\&logo=gnu-bash)
![Security](https://img.shields.io/badge/Cybersecurity-Incident%20Response-blue?style=for-the-badge)
![License](https://img.shields.io/badge/License-Educational-yellow?style=for-the-badge)

</div>

---

# 📖 Overview

This lab provides a complete end-to-end Incident Response Simulation designed to mirror real-world Security Operations Center (SOC) activities.

Students deploy a full monitoring stack using open-source enterprise security tools and perform detection, analysis, containment, eradication, recovery, and reporting activities following industry-standard incident response procedures.

---

# 🎯 Learning Objectives

By the end of this lab, students will be able to:

✅ Deploy and configure a complete SOC environment

✅ Utilize Wazuh as a Security Information and Event Management (SIEM) platform

✅ Configure and monitor Suricata IDS/IPS

✅ Deploy Zeek for Network Security Monitoring (NSM)

✅ Detect and investigate simulated cyber attacks

✅ Execute industry-standard incident response playbooks

✅ Perform containment, eradication, and recovery activities

✅ Generate professional incident response reports

✅ Preserve and collect digital evidence

✅ Conduct post-incident analysis and lessons learned reviews

---

# 📋 Prerequisites

Students should have:

* 🐧 Linux command-line experience
* 🌐 TCP/IP networking fundamentals
* 🔒 Basic cybersecurity knowledge
* 📊 Log analysis experience
* 🔍 Understanding of attack techniques
* 📝 Familiarity with security terminology

---

# 🖥️ Lab Environment

## ☁️ Al Nafi Cloud Environment

This lab runs entirely on a single Linux cloud machine provided by Al Nafi.

### Environment Specifications

| Component    | Details          |
| ------------ | ---------------- |
| OS           | Ubuntu 20.04 LTS |
| RAM          | 8 GB             |
| Storage      | 50 GB            |
| Access       | Root Access      |
| Environment  | Cloud-Based      |
| Architecture | Single Host SOC  |

---

# 🛠️ Technologies Used

| Technology | Purpose                     |
| ---------- | --------------------------- |
| Wazuh      | SIEM & Endpoint Monitoring  |
| Suricata   | IDS / IPS                   |
| Zeek       | Network Security Monitoring |
| Bash       | Automation Scripts          |
| Linux      | Operating System            |
| IPTables   | Network Containment         |
| ClamAV     | Malware Detection           |
| Apache2    | Web Attack Simulation       |
| Tcpdump    | Packet Analysis             |

---

# 📂 Project Structure

```text
incident-response-lab/
│
├── logs/
├── scripts/
│   ├── port_scan_simulation.sh
│   ├── web_attack_simulation.sh
│   ├── malware_simulation.sh
│   ├── incident_response_playbook.sh
│   ├── containment_procedures.sh
│   ├── eradication_recovery.sh
│   ├── post_incident_analysis.sh
│   ├── security_verification.sh
│   └── compile_documentation.sh
│
├── evidence/
├── reports/
└── final_documentation/
```

---

# 🚀 Task 1 — Environment Preparation

## 🎯 Objective

Prepare the system and install all required security tools.

### 🔹 Update System

```bash
sudo apt update && sudo apt upgrade -y
```

### 🔹 Install Dependencies

```bash
sudo apt install -y curl wget gnupg2 software-properties-common apt-transport-https ca-certificates
```

### 🔹 Create Lab Directories

```bash
mkdir -p ~/incident-response-lab/{logs,scripts,evidence,reports}

cd ~/incident-response-lab
```

---

# 🛡️ Task 2 — Install Wazuh SIEM

## 🎯 Objective

Deploy a centralized Security Information and Event Management platform.

### Features

* Event Collection
* Log Correlation
* Alert Generation
* Endpoint Monitoring
* Threat Detection

### Components Installed

✔ Wazuh Manager

✔ Wazuh API

✔ Wazuh Agent

### Verification

```bash
sudo systemctl status wazuh-manager
```

```bash
sudo systemctl status wazuh-agent
```

---

# 🚨 Task 3 — Deploy Suricata IDS/IPS

## 🎯 Objective

Monitor and detect malicious network activity.

### Capabilities

* Signature-Based Detection
* Protocol Analysis
* Threat Detection
* Network Visibility

### Verification

```bash
sudo systemctl status suricata
```

### Update Rules

```bash
sudo suricata-update
```

---

# 🌐 Task 4 — Deploy Zeek Network Monitor

## 🎯 Objective

Gain visibility into network communications and security events.

### Zeek Monitoring

* HTTP Traffic
* DNS Queries
* Connection Logs
* SSL/TLS Activity
* Network Metadata

### Verification

```bash
sudo /opt/zeek/bin/zeekctl status
```

---

# 🔗 Task 5 — Log Integration

## 🎯 Objective

Integrate Wazuh, Suricata, and Zeek into a unified SOC environment.

### Integrated Log Sources

| Tool     | Log Type         |
| -------- | ---------------- |
| Wazuh    | Endpoint Events  |
| Suricata | IDS Alerts       |
| Zeek     | Network Activity |
| Linux    | System Logs      |

### Benefits

✔ Centralized Monitoring

✔ Correlation of Events

✔ Faster Detection

✔ Improved Visibility

---

# 🎭 Task 6 — Attack Simulation

## 🎯 Objective

Generate realistic attack activity for analysis.

### Simulated Attack Scenarios

### 🔹 Network Reconnaissance

```bash
./port_scan_simulation.sh
```

Activities:

* TCP Port Scanning
* UDP Enumeration
* Service Discovery

---

### 🔹 Web Application Attacks

```bash
./web_attack_simulation.sh
```

Activities:

* SQL Injection
* Cross-Site Scripting (XSS)
* Directory Traversal
* Brute Force Attempts

---

### 🔹 Malware Behavior Simulation

```bash
./malware_simulation.sh
```

Activities:

* Suspicious File Creation
* Malicious DNS Queries
* Process Manipulation
* Malware Indicators

---

# 🔍 Task 7 — Detection & Analysis

## 🎯 Objective

Investigate security alerts generated by monitoring systems.

### Review Wazuh Alerts

```bash
sudo tail -50 /var/ossec/logs/alerts/alerts.log
```

### Review Suricata Alerts

```bash
sudo tail -50 /var/log/suricata/fast.log
```

### Review Zeek Logs

```bash
sudo tail -20 /opt/zeek/logs/current/conn.log
```

### Detection Summary

| Event               | Tool            |
| ------------------- | --------------- |
| Port Scan           | Suricata, Zeek  |
| SQL Injection       | Wazuh, Suricata |
| XSS                 | Wazuh           |
| Directory Traversal | Wazuh           |
| Malware Activity    | Wazuh, Zeek     |

---

# 🚑 Task 8 — Incident Response Execution

## 🎯 Objective

Follow industry-standard incident response procedures.

### Incident Response Lifecycle

```text
Preparation
     ↓
Identification
     ↓
Containment
     ↓
Eradication
     ↓
Recovery
     ↓
Lessons Learned
```

---

# 📂 Task 9 — Evidence Collection

## 🔎 Evidence Gathered

### System Information

```bash
uname -a
```

### Running Processes

```bash
ps aux
```

### Network Connections

```bash
netstat -tulpn
```

### Security Logs

* Wazuh Alerts
* Suricata Alerts
* Zeek Logs

---

# 🚧 Task 10 — Containment Procedures

## 🎯 Objective

Prevent further compromise.

### Network Containment

* Block Malicious IPs
* Restrict Suspicious Ports
* Monitor Blocked Connections

### Process Containment

* Terminate Malicious Processes
* Disable Unnecessary Services

### File Containment

* Quarantine Suspicious Files
* Protect Critical System Files

### User Containment

* Disable Compromised Accounts
* Force Password Resets

---

# 🧹 Task 11 — Eradication

## 🎯 Objective

Remove threats from the environment.

### Activities

✔ Remove Malware

✔ Delete Malicious Files

✔ Patch Vulnerabilities

✔ Update Systems

✔ Harden Configurations

### Malware Scanning

```bash
sudo clamscan -r /home --infected
```

---

# 🔄 Task 12 — Recovery

## 🎯 Objective

Restore services and resume operations.

### Recovery Activities

* Restart Security Services
* Verify System Integrity
* Restore Functionality
* Enable Enhanced Monitoring

### Service Validation

```bash
sudo systemctl restart wazuh-manager

sudo systemctl restart suricata
```

---

# 📊 Task 13 — Post-Incident Analysis

## 🎯 Objective

Evaluate response effectiveness.

### Reports Generated

📄 Detection Summary

📄 Incident Timeline

📄 Lessons Learned

📄 Executive Summary

📄 Security Status Report

📄 Master Incident Report

---

# 📑 Task 14 — Documentation Package

## Documentation Includes

```text
final_documentation/
│
├── executive_summary.txt
├── incident_timeline.txt
├── lessons_learned.txt
├── security_status.txt
├── master_incident_report.txt
├── evidence_archive.tar.gz
└── configurations/
```

---

# 🔍 Security Verification

## Verify Services

```bash
sudo systemctl is-active wazuh-manager
```

```bash
sudo systemctl is-active suricata
```

```bash
sudo /opt/zeek/bin/zeekctl status
```

### Security Checklist

✅ SIEM Operational

✅ IDS Operational

✅ Network Monitoring Active

✅ Firewall Rules Applied

✅ Evidence Preserved

✅ Enhanced Monitoring Enabled

---

# 🚨 Troubleshooting

## Service Not Starting

```bash
sudo systemctl status wazuh-manager
```

```bash
sudo journalctl -u wazuh-manager -f
```

---

## No Alerts Generated

```bash
sudo /var/ossec/bin/ossec-logtest
```

---

## Network Interface Issues

```bash
ip link show
```

---

# 🎓 Skills Developed

After completing this lab, students gain practical experience in:

### 🔵 Security Operations Center (SOC)

* Alert Monitoring
* Threat Detection
* Event Correlation

### 🔴 Incident Response

* Identification
* Containment
* Eradication
* Recovery

### 🟢 Threat Hunting

* IOC Analysis
* Log Investigation
* Network Monitoring

### 🟣 Digital Forensics

* Evidence Collection
* Timeline Creation
* Documentation

---

# 💼 Career Relevance

This lab prepares students for roles such as:

* 🛡️ SOC Analyst
* 🚨 Incident Response Specialist
* 🔍 Threat Hunter
* 🔐 Security Engineer
* 🧠 Cybersecurity Consultant
* 📊 Security Operations Analyst

---

# 🏆 Conclusion

Congratulations! You have successfully completed a full-scale Incident Response Simulation using enterprise-grade open-source security tools.

Throughout this lab, you:

✅ Built a complete SOC environment

✅ Deployed Wazuh, Suricata, and Zeek

✅ Detected multiple attack vectors

✅ Executed professional incident response procedures

✅ Collected and preserved evidence

✅ Generated executive and technical reports

✅ Improved overall security posture

This hands-on experience reflects real-world Security Operations Center workflows and provides valuable practical skills applicable across modern cybersecurity environments.

---

<div align="center">

## ⭐ Cyber Defense Through Detection, Response & Continuous Improvement

### SOC Operations • Incident Response • Threat Hunting • Digital Forensics

</div>
