# 🌐 Analyzing DNS Traffic

<div align="center">

# 🔍 DNS Traffic Analysis & Threat Detection 

### Capture • Analyze • Detect • Investigate

![Linux](https://img.shields.io/badge/Linux-Ubuntu-E95420?style=for-the-badge\&logo=ubuntu)
![DNS](https://img.shields.io/badge/DNS-Traffic%20Analysis-blue?style=for-the-badge)
![TCPDump](https://img.shields.io/badge/TCPDump-Packet%20Capture-success?style=for-the-badge)
![Python](https://img.shields.io/badge/Python-Automation-yellow?style=for-the-badge\&logo=python)
![Scapy](https://img.shields.io/badge/Scapy-Packet%20Analysis-red?style=for-the-badge)
![Threat Hunting](https://img.shields.io/badge/Threat-Hunting-orange?style=for-the-badge)
![Network Security](https://img.shields.io/badge/Network-Security-darkgreen?style=for-the-badge)

</div>

---

# 📖 Overview

DNS is one of the most frequently used protocols in modern networks and is commonly abused by attackers for command-and-control communication, malware delivery, phishing campaigns, DNS tunneling, and data exfiltration.

In this hands-on cybersecurity lab, students will learn how to capture DNS traffic, analyze packet data, detect suspicious activity, and build automated DNS monitoring tools using Python.

---

# 🎯 Learning Objectives

By the end of this lab, students will be able to:

✅ Capture DNS traffic using tcpdump

✅ Filter DNS traffic efficiently

✅ Analyze DNS packet patterns

✅ Write Python-based DNS analyzers

✅ Detect suspicious DNS behavior

✅ Identify DGA-generated domains

✅ Detect DNS tunneling attempts

✅ Build real-time DNS monitoring tools

✅ Generate comprehensive DNS security reports

---

# 🛠️ Technologies Used

| Technology       | Purpose          |
| ---------------- | ---------------- |
| Ubuntu Linux     | Operating System |
| tcpdump          | Packet Capture   |
| DNS Protocol     | Traffic Analysis |
| Python 3         | Automation       |
| Scapy            | Packet Parsing   |
| Pandas           | Data Analysis    |
| JSON             | Reporting        |
| Network Security | Threat Detection |

---

# 📋 Prerequisites

Before beginning this lab, ensure you have:

* Linux command-line proficiency
* Understanding of DNS protocol
* Knowledge of Port 53
* Basic Python programming skills
* Familiarity with packet analysis concepts

---

# 🏗️ Lab Architecture

```text
                   INTERNET
                       │
                       │
             ┌─────────────────┐
             │   DNS Servers   │
             └─────────────────┘
                       │
         DNS Queries & Responses
                       │
                       ▼
        ┌─────────────────────────┐
        │      tcpdump Capture     │
        └─────────────────────────┘
                       │
                       ▼
            dns_capture.pcap
                       │
       ┌───────────────┼───────────────┐
       │               │               │
       ▼               ▼               ▼
 DNS Analyzer    DNS Monitor    DNS Tunnel Detector
       │               │               │
       └───────────────┼───────────────┘
                       ▼
                Security Reports
```

---

# 🚀 Task 1: Capture DNS Traffic with tcpdump

## 🔹 Step 1.1: Identify Network Interface

Check available interfaces:

```bash
ip addr show
```

📌 Note your active interface (typically `eth0` or `ens33`).

---

## 🔹 Step 1.2: Capture DNS Traffic

Start capturing DNS traffic:

```bash
sudo tcpdump -i eth0 -n port 53
```

### Flags Explained

| Flag    | Description                 |
| ------- | --------------------------- |
| -i eth0 | Network Interface           |
| -n      | Disable Hostname Resolution |
| port 53 | DNS Traffic Only            |

---

## 🔹 Step 1.3: Generate Test Traffic

Generate DNS requests:

```bash
nslookup google.com

nslookup github.com

nslookup amazon.com
```

---

## 🔹 Step 1.4: Save DNS Capture

Capture traffic into a PCAP file:

```bash
sudo tcpdump -i eth0 -n -w dns_capture.pcap port 53
```

Allow capture for several minutes.

Press:

```text
CTRL + C
```

to stop.

---

## 🔹 Step 1.5: Review Captured Packets

Read packets:

```bash
sudo tcpdump -r dns_capture.pcap -n
```

Verbose output:

```bash
sudo tcpdump -r dns_capture.pcap -n -v
```

---

# 🐍 Task 2: Analyze DNS Traffic with Python

## 🔹 Step 2.1: Install Required Libraries

```bash
sudo apt update

sudo apt install python3-pip -y

pip3 install scapy pandas
```

---

## 🔹 Step 2.2: Create DNS Analysis Script

Create:

```bash
nano dns_analyzer.py
```

Features:

* DNS Query Analysis
* Domain Frequency Tracking
* Query Type Statistics
* Response Code Analysis
* Suspicious Domain Detection

---

## 🔹 Step 2.3: Complete TODO Sections

Implement:

### 📌 Read PCAP File

```python
packets = rdpcap(pcap_file)
```

---

### 📌 Check DNS Layer

```python
if packet.haslayer(DNS):
```

---

### 📌 Extract Domain Name

```python
dns_layer.qd.qname.decode('utf-8').rstrip('.')
```

---

### 📌 Query Detection

```python
if dns_layer.qr == 0:
```

---

### 📌 Response Detection

```python
if dns_layer.qr == 1:
```

---

### 📌 Frequency Counting

```python
Counter()
```

---

## 🔹 Run Analyzer

```bash
chmod +x dns_analyzer.py

python3 dns_analyzer.py dns_capture.pcap
```

---

# 📡 Task 3: Real-Time DNS Monitoring

## 🔹 Step 3.1: Create DNS Monitor

```bash
nano dns_monitor.py
```

Features:

✅ Live DNS Monitoring

✅ Suspicious Domain Detection

✅ Beaconing Detection

✅ Query Frequency Analysis

✅ Real-Time Alerts

---

## 🔹 Step 3.2: Complete DNSMonitor Class

Implement:

### 🚨 Suspicious Keyword Detection

```python
malware
phishing
trojan
botnet
```

---

### 🚨 Suspicious TLD Detection

```python
.tk
.ml
.ga
```

---

### 🚨 DGA Detection Logic

Check:

* Long Domains
* Random Strings
* Excessive Consonants

---

### 🚨 Frequency Analysis

Track:

```python
query_history
```

Monitor:

```text
20+ Queries in 5 Minutes
```

---

### 🚨 Packet Processing

Extract:

* Domain Name
* Source IP
* Query Type
* Timestamp

Generate Alerts:

```text
[ALERT]
Suspicious DNS Activity Detected
```

---

## 🔹 Start Monitoring

```bash
python3 dns_monitor.py
```

---

# 🕵️ Task 4: DNS Tunneling Detection

## 🔹 Step 4.1: Create Detector

```bash
nano dns_tunneling_detector.py
```

---

## 🔹 Detection Indicators

### 📈 High Query Volume

```text
More than 50 Queries
```

---

### 📈 Excessive Unique Subdomains

```text
More than 20 Subdomains
```

---

### 📈 Long Query Names

```text
Average Length > 30 Characters
```

---

### 📈 TXT Record Abuse

```text
More than 10 TXT Queries
```

---

## 🔹 Risk Scoring Model

| Indicator       | Score |
| --------------- | ----- |
| High Volume     | +1    |
| Many Subdomains | +1    |
| Long Queries    | +1    |
| TXT Abuse       | +1    |

Risk Score:

```text
Score >= 3 → Potential DNS Tunneling
```

---

## 🔹 Execute Detector

```bash
chmod +x dns_tunneling_detector.py

python3 dns_tunneling_detector.py dns_capture.pcap
```

---

# 📊 Task 5: DNS Baseline Analysis

## 🔹 Create Baseline Tool

```bash
nano dns_baseline.py
```

---

## Features

### 📌 Create Baseline

Track:

* Normal Domains
* Typical Query Volume
* Common Query Types

---

### 📌 Detect Anomalies

Identify:

* New Domains
* Rare Query Types
* Volume Spikes
* Abnormal Behavior

---

### Create Baseline

```bash
python3 dns_baseline.py --create-baseline baseline.pcap
```

---

### Detect Anomalies

```bash
python3 dns_baseline.py --detect dns_capture.pcap baseline.json
```

---

# 🔥 Task 6: Advanced Analysis Techniques

---

## 🎯 DGA Detection

DGA domains typically exhibit:

✅ Long Names

✅ Random Strings

✅ Few Vowels

✅ High Entropy

Examples:

```text
jdksfweirudf.com
zxcmnbqwert123.net
```

---

### DGA Detection Logic

```python
consonants > vowels * 3

length > 12
```

If both are true:

```python
return True
```

---

## 🎯 DNS Beaconing Detection

Beaconing indicates malware communication.

Characteristics:

* Repeated Queries
* Fixed Intervals
* Same Domain
* Persistent Activity

---

### Detection Criteria

```python
Minimum Queries > 10
```

```python
Low Standard Deviation
```

```python
Regular Intervals
```

---

# 📑 Task 7: Generate Security Reports

## Create Report Generator

```bash
nano dns_report.py
```

---

## Report Sections

### 📊 DNS Statistics

* Total Queries
* Unique Domains
* Query Types

---

### 🚨 Suspicious Activity

* DGA Domains
* DNS Tunneling
* Beaconing
* High Frequency Queries

---

### 🛡️ Recommendations

Examples:

```text
Block suspicious domains

Investigate beaconing hosts

Review tunneling activity

Enhance DNS monitoring
```

---

## Generate Report

```bash
python3 dns_report.py dns_capture.pcap
```

Output:

```text
report.json
```

---

# 📈 Expected Outcomes

After completing this lab you will have:

✅ Captured DNS traffic with tcpdump

✅ Filtered DNS packets efficiently

✅ Parsed DNS traffic with Scapy

✅ Built custom DNS analysis tools

✅ Detected suspicious DNS behavior

✅ Identified DGA domains

✅ Detected DNS tunneling attempts

✅ Built real-time monitoring systems

✅ Generated security reports

---

# 🚨 Threats Detected

| Threat Type       | Detection Method    |
| ----------------- | ------------------- |
| DGA Domains       | Randomness Analysis |
| DNS Tunneling     | Query Metrics       |
| Beaconing         | Timing Analysis     |
| Malware Domains   | Keyword Matching    |
| Data Exfiltration | Subdomain Analysis  |
| Phishing Domains  | Pattern Matching    |

---

# 🔧 Troubleshooting

## ❌ Permission Denied

Solution:

```bash
sudo tcpdump
```

or

```bash
sudo usermod -aG pcap $USER
```

---

## ❌ Scapy Import Error

```bash
pip3 install --upgrade scapy
```

---

## ❌ No Packets Captured

Verify interface:

```bash
ip addr show
```

Check DNS traffic generation.

---

## ❌ DNS Layer Missing

Verify:

```bash
port 53
```

traffic exists in capture.

---

# 🎓 Skills Gained

After completing this lab, students will understand:

* DNS Security Monitoring
* Packet Capture Techniques
* Network Traffic Analysis
* Python Security Automation
* DNS Tunneling Detection
* Threat Hunting Fundamentals
* Malware Communication Patterns
* Beaconing Analysis
* Incident Investigation
* Security Reporting

---

# 💼 Career Relevance

This lab prepares learners for:

* SOC Analyst
* Cybersecurity Analyst
* Threat Hunter
* Incident Responder
* Network Security Engineer
* Blue Team Analyst
* Detection Engineer
* DFIR Specialist

---

# 🏁 Conclusion

This lab provided practical experience in DNS traffic analysis using tcpdump, Python, and Scapy. Students learned how to capture traffic, analyze packet data, identify suspicious patterns, and build automated DNS security monitoring solutions.

### Key Takeaways

✅ DNS analysis reveals hidden security threats

✅ Automated monitoring improves detection speed

✅ DNS tunneling can indicate data exfiltration

✅ DGA detection helps identify malware infrastructure

✅ Baseline analysis improves anomaly detection

✅ Real-time monitoring strengthens security operations

---

<div align="center">

## 🌐 Analyze • Detect • Investigate • Defend

### Built for DNS Security Monitoring & Threat Hunting

⭐ Star this repository if you found it useful!

</div>
