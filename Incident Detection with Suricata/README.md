# 🛡️ Incident Detection with Suricata

<div align="center">

# 🚨 Network Intrusion Detection & Incident Response 

### Deploy • Detect • Analyze • Respond

![Linux](https://img.shields.io/badge/Linux-Ubuntu-E95420?style=for-the-badge\&logo=ubuntu)
![Suricata](https://img.shields.io/badge/Suricata-NIDS-red?style=for-the-badge)
![Bash](https://img.shields.io/badge/Bash-Scripting-121011?style=for-the-badge\&logo=gnu-bash)
![Python](https://img.shields.io/badge/Python-Log%20Analysis-blue?style=for-the-badge\&logo=python)
![JSON](https://img.shields.io/badge/JSON-Parsing-black?style=for-the-badge)
![SOC](https://img.shields.io/badge/SOC-Monitoring-success?style=for-the-badge)
![Incident Response](https://img.shields.io/badge/Incident-Response-orange?style=for-the-badge)

</div>

---

# 📖 Overview

This hands-on cybersecurity lab demonstrates how to deploy and configure **Suricata Network Intrusion Detection System (NIDS)** to detect, analyze, and respond to network security incidents.

Students will learn how to:

* 🛡️ Install and configure Suricata
* 🔍 Create custom IDS detection rules
* 🚨 Generate malicious and suspicious traffic
* 📊 Analyze security alerts
* ⚡ Build automated monitoring solutions
* 📝 Create incident response workflows
* 🎯 Perform threat detection and log analysis

---

# 🎯 Learning Objectives

By the end of this lab, you will be able to:

✅ Install and configure Suricata NIDS

✅ Create and customize detection rules

✅ Generate attack simulation traffic

✅ Analyze Suricata security alerts

✅ Interpret threat indicators

✅ Build incident response automation

✅ Monitor IDS performance

✅ Develop security dashboards

---

# 🧰 Technologies Used

| Technology   | Purpose                     |
| ------------ | --------------------------- |
| Suricata     | Network Intrusion Detection |
| Ubuntu Linux | Operating System            |
| Bash         | Automation Scripts          |
| Python       | Log Parsing & Reporting     |
| jq           | JSON Processing             |
| curl         | HTTP Traffic Generation     |
| dig          | DNS Traffic Testing         |
| nmap         | Network Scanning            |
| netcat       | Connection Simulation       |

---

# 📋 Prerequisites

Before starting:

* Linux Command Line Knowledge
* Networking Fundamentals
* TCP/IP Understanding
* Basic Log Analysis Skills
* Cybersecurity Fundamentals
* Nano or Vim Editor

---

# 🏗️ Lab Architecture

```text
                 INTERNET
                     |
                     |
            +----------------+
            |    Suricata    |
            |      NIDS      |
            +----------------+
                     |
                     |
       +-----------------------------+
       |      Ubuntu Linux Host      |
       +-----------------------------+
                     |
      --------------------------------
      |              |              |
      |              |              |
   HTTP          DNS Query       SSH
  Traffic         Traffic      Attempts
      |              |              |
      --------------------------------
                     |
             Alert Generation
                     |
             Log Collection
                     |
          Incident Response
```

---

# 🚀 Task 1: Install & Configure Suricata

## 🔹 Update System

```bash
sudo apt update && sudo apt upgrade -y
```

---

## 🔹 Install Suricata

```bash
sudo apt install suricata suricata-update jq -y

suricata --version
```

---

## 🔹 Configure Network Interface

Check interfaces:

```bash
ip addr show
```

Edit configuration:

```bash
sudo nano /etc/suricata/suricata.yaml
```

Update:

```yaml
af-packet:
  - interface: eth0
    cluster-id: 99
    cluster-type: cluster_flow
    defrag: yes
```

---

## 🔹 Configure HOME_NET

```yaml
vars:
  address-groups:
    HOME_NET: "[192.168.1.0/24,10.0.0.0/8,172.16.0.0/12]"
    EXTERNAL_NET: "!$HOME_NET"
```

---

## 🔹 Update Detection Rules

```bash
sudo suricata-update

sudo suricata-update add-source emerging-threats \
https://rules.emergingthreats.net/open/suricata/emerging.rules.tar.gz

sudo suricata-update
```

---

# 🎯 Task 2: Create Custom Detection Rules

Create directory:

```bash
sudo mkdir -p /etc/suricata/rules/custom
```

Create rule file:

```bash
sudo nano /etc/suricata/rules/custom/lab-rules.rules
```

---

## 🚨 ICMP Detection Rule

```suricata
alert icmp any any -> $HOME_NET any \
(msg:"ICMP Ping Detected"; sid:1000001; rev:1;)
```

---

## 🚨 Suspicious HTTP Rule

```suricata
alert http any any -> any any \
(msg:"Suspicious HTTP Request";
content:"malware";
http_uri;
sid:1000002;
rev:1;)
```

---

## 🚨 SSH Brute Force Detection

```suricata
alert tcp any any -> $HOME_NET 22 \
(msg:"Potential SSH Brute Force";
flags:S;
threshold:type both, track by_src, count 5, seconds 60;
sid:1000003;
rev:1;)
```

---

## 🚨 DNS Detection Rule

```suricata
alert dns any any -> any any \
(msg:"Suspicious DNS Query";
dns_query;
content:"malicious";
sid:1000004;
rev:1;)
```

---

## 🚨 Large Download Detection

```suricata
alert http any any -> any any \
(msg:"Large File Download";
filesize:>1000000;
sid:1000005;
rev:1;)
```

---

# ⚙️ Enable Custom Rules

```yaml
rule-files:
  - suricata.rules
  - custom/lab-rules.rules
```

---

## ✅ Test Configuration

```bash
sudo suricata -T -c /etc/suricata/suricata.yaml -v
```

Expected:

```text
Configuration provided was successfully loaded
```

---

# 🚦 Task 3: Start Detection Engine

```bash
sudo suricata -c /etc/suricata/suricata.yaml -i eth0 -D
```

Verify:

```bash
sudo systemctl status suricata

ps aux | grep suricata
```

---

# 🌐 Task 4: Generate Test Traffic

## 📡 ICMP Traffic

```bash
ping -c 10 8.8.8.8

ping -c 5 127.0.0.1
```

---

## 🌍 HTTP Traffic

```bash
sudo apt install curl -y
```

```bash
curl -s "http://httpbin.org/get?malware=test" > /dev/null

curl -s "http://httpbin.org/user-agent" \
-H "User-Agent: malicious-bot" > /dev/null
```

Loop traffic:

```bash
for i in {1..10}; do
    curl -s "http://httpbin.org/status/200" > /dev/null
    sleep 1
done
```

---

## 🔐 SSH Simulation

```bash
sudo apt install nmap -y
```

```bash
for i in {1..6}; do
    timeout 2 nc -z 127.0.0.1 22
    sleep 1
done
```

---

## 🌎 DNS Simulation

```bash
sudo apt install dnsutils -y
```

```bash
dig @8.8.8.8 malicious.example.com

dig @8.8.8.8 test-malware.com

dig @8.8.8.8 normal-website.com
```

---

# 📊 Task 5: Analyze Suricata Logs

## View Logs

```bash
ls -la /var/log/suricata/
```

---

## Fast Alerts

```bash
sudo tail -f /var/log/suricata/fast.log
```

---

## JSON Alert Logs

```bash
sudo tail -20 /var/log/suricata/eve.json | jq '.'
```

---

## Alert Only Events

```bash
sudo cat /var/log/suricata/eve.json \
| jq 'select(.event_type=="alert")'
```

---

## Count Alerts

```bash
sudo cat /var/log/suricata/eve.json \
| jq -r 'select(.event_type=="alert") |
.alert.signature' \
| sort | uniq -c
```

---

# 🤖 Task 6: Automated Log Analyzer

## 📄 suricata_analyzer.sh

```bash
chmod +x suricata_analyzer.sh

./suricata_analyzer.sh
```

Features:

* Alert Summary
* Source IP Analysis
* Severity Breakdown
* Recent Alerts
* Event Statistics

---

# 📡 Task 7: Real-Time Alert Monitoring

## monitor_alerts.sh

```bash
chmod +x monitor_alerts.sh

./monitor_alerts.sh
```

Displays:

```text
ALERT:
Timestamp
Signature
Source IP
Destination IP
Severity
```

---

# ⚔️ Task 8: Attack Simulation

## attack_simulator.sh

Simulates:

### 🔎 Port Scanning

```bash
nmap -sS -O 127.0.0.1
```

### 📂 Directory Traversal

```bash
curl "http://httpbin.org/get?file=../../../etc/passwd"
```

### 💉 SQL Injection

```bash
curl "http://httpbin.org/get?id=1' OR '1'='1"
```

### 🔐 SSH Brute Force

```bash
for i in {1..10}; do
    timeout 1 ssh fake_user@127.0.0.1
done
```

### 🌐 DNS Tunneling

```bash
dig malicious.suspicious-domain.com
```

---

# 🚑 Task 9: Incident Response Playbook

## incident_response.sh

Creates:

```text
alerts.json
high_severity_alerts.json
suspicious_ips.txt
timeline.txt
incident_summary.txt
```

Workflow:

1️⃣ Collect Alerts

2️⃣ Identify High Severity Events

3️⃣ Extract Malicious IPs

4️⃣ Generate Timeline

5️⃣ Produce Summary Report

---

# 📈 Task 10: Performance Monitoring

## performance_monitor.sh

Checks:

* Suricata Status
* Memory Usage
* CPU Usage
* Statistics
* Log Sizes

Run:

```bash
chmod +x performance_monitor.sh

./performance_monitor.sh
```

---

# 🐍 Task 11: Advanced Python Log Parser

## advanced_parser.py

Features:

✅ Alert Statistics

✅ Severity Analysis

✅ Signature Ranking

✅ Source IP Analysis

✅ Timeline Generation

Run:

```bash
chmod +x advanced_parser.py

sudo python3 advanced_parser.py
```

---

# 📊 Task 12: Alert Dashboard

## alert_dashboard.sh

Features:

```text
📊 Alert Counts

🚨 Recent Alerts

🎯 Top Threats

⚙️ System Status

💾 Disk Usage
```

Run:

```bash
chmod +x alert_dashboard.sh

./alert_dashboard.sh
```

---

# 🔥 Task 13: Advanced Detection Rules

## SSH Brute Force

```suricata
alert tcp any any -> $HOME_NET 22
(msg:"SSH Brute Force Attack Detected";
sid:2000001; rev:1;)
```

---

## Suspicious User Agent

```suricata
alert http any any -> any any
(msg:"Suspicious User Agent Detected";
content:"bot";
sid:2000002; rev:1;)
```

---

## Data Exfiltration

```suricata
alert tcp $HOME_NET any -> !$HOME_NET any
(msg:"Potential Data Exfiltration";
dsize:>10000;
sid:2000003; rev:1;)
```

---

## DNS over HTTPS Detection

```suricata
alert tls any any -> any 443
(msg:"DNS over HTTPS Detected";
content:"cloudflare-dns.com";
sid:2000004; rev:1;)
```

---

## Crypto Mining Detection

```suricata
alert tcp any any -> any any
(msg:"Cryptocurrency Mining Detected";
content:"stratum+tcp";
sid:2000005; rev:1;)
```

---

# 📉 Task 14: Rule Performance Analysis

## rule_performance.sh

Provides:

* Top Triggered Rules
* Custom Rule Metrics
* Coverage Statistics
* Alert Distribution

Run:

```bash
chmod +x rule_performance.sh

./rule_performance.sh
```

---

# 🛠️ Troubleshooting

## ❌ Suricata Won't Start

```bash
sudo systemctl status suricata

sudo suricata -T \
-c /etc/suricata/suricata.yaml -v
```

---

## ❌ No Alerts

```bash
ip addr show

sudo tcpdump -i eth0 -c 10
```

---

## ❌ High CPU Usage

```bash
top -p $(pgrep suricata)
```

---

## ❌ Log Files Too Large

Configure Logrotate:

```bash
sudo nano /etc/logrotate.d/suricata
```

```conf
/var/log/suricata/*.log {
    daily
    rotate 7
    compress
}
```

---

# 📚 Skills Gained

After completing this lab you will understand:

* Network Intrusion Detection
* SOC Monitoring Workflows
* Threat Detection Engineering
* Incident Response Procedures
* Threat Hunting Fundamentals
* Security Event Analysis
* Log Parsing & Reporting
* Detection Rule Development
* Security Automation
* IDS Performance Tuning

---

# 🎓 Career Relevance

This lab prepares learners for:

* SOC Analyst
* Cybersecurity Analyst
* Incident Responder
* Threat Hunter
* Blue Team Engineer
* Detection Engineer
* Security Operations Engineer

---

# 🏁 Conclusion

In this lab, we successfully deployed **Suricata Network Intrusion Detection System (NIDS)** and built a complete incident detection workflow from traffic generation to alert analysis and response.

Key accomplishments include:

✅ Suricata Installation & Configuration

✅ Custom Detection Rules

✅ Attack Simulation

✅ Security Alert Analysis

✅ Automated Monitoring Scripts

✅ Incident Response Playbooks

✅ Advanced Threat Detection

✅ Dashboard & Reporting

These skills provide a strong foundation for modern Security Operations Center (SOC) environments and real-world incident response activities.

---

<div align="center">

### 🛡️ Detect • Analyze • Respond • Defend

**Built for Blue Team Operations & Incident Response Training**

⭐ Star this repository if you found it useful!

</div>
