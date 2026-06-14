# 🔍 Scanning & Enumeration with Nmap

![Linux](https://img.shields.io/badge/Linux-Ubuntu-E95420?style=for-the-badge\&logo=ubuntu)
![Nmap](https://img.shields.io/badge/Nmap-Network%20Scanner-blue?style=for-the-badge)
![Bash](https://img.shields.io/badge/Bash-Scripting-4EAA25?style=for-the-badge\&logo=gnubash)
![Cybersecurity](https://img.shields.io/badge/Cybersecurity-Enumeration-red?style=for-the-badge)
![Network Security](https://img.shields.io/badge/Network-Security-orange?style=for-the-badge)

---

# 🎯 Objectives

By the end of this lab, students will be able to:

✅ Understand the fundamentals of network scanning and enumeration using Nmap

✅ Perform host discovery, port scanning, and service detection

✅ Identify open ports, running services, and operating system information

✅ Create Bash scripts to automate scanning operations

✅ Analyze scan results to identify security weaknesses

✅ Apply scanning techniques in Incident Response and Adversary Emulation scenarios

---

# 📚 Prerequisites

Before starting this lab, ensure you have:

* Basic Networking Knowledge
* Linux Command Line Experience
* Bash Scripting Fundamentals
* TCP/IP Understanding
* Knowledge of Common Network Services

---

# 🖥️ Lab Environment

Al Nafi Cloud provides:

* Pre-configured Linux Environment
* Nmap Installed
* Root/Sudo Access
* Network Connectivity
* Text Editors

---

# 🚀 Task 1: Perform Network Scans Using Nmap

## 📌 Subtask 1.1: Verify Installation

### 🔹 Check Nmap Version

```bash
nmap --version
```

### 🔹 Install Nmap

```bash
sudo apt update
sudo apt install nmap -y
```

### 🔹 Verify Installation

```bash
which nmap
```

### 🔹 Check IP Address

```bash
ip addr show
hostname -I
```

---

## 📌 Subtask 1.2: Host Discovery

### 🔹 Ping Scan

```bash
nmap -sn 127.0.0.0/24
```

### 🔹 Scan Localhost

```bash
nmap -sn 127.0.0.1
```

### 🔹 ARP Scan

```bash
sudo nmap -PR 127.0.0.1
```

### 🔹 Create Target List

```bash
echo "127.0.0.1" > targets.txt
echo "localhost" >> targets.txt
```

---

## 📌 Subtask 1.3: Basic Port Scanning

### 🔹 Default Scan

```bash
nmap 127.0.0.1
```

### 🔹 Specific Ports

```bash
nmap -p 22,80,443,3306 127.0.0.1
```

### 🔹 Port Range

```bash
nmap -p 1-1000 127.0.0.1
```

### 🔹 Full Port Scan

```bash
nmap -p- 127.0.0.1
```

---

## 📌 Subtask 1.4: Advanced Scanning

### 🔹 SYN Scan

```bash
sudo nmap -sS 127.0.0.1
```

### 🔹 UDP Scan

```bash
sudo nmap -sU 127.0.0.1
```

### 🔹 Combined TCP/UDP

```bash
sudo nmap -sS -sU -p 1-100 127.0.0.1
```

### 🔹 Aggressive Scan

```bash
nmap -A 127.0.0.1
```

---

## 📌 Subtask 1.5: Service Detection

### 🔹 Version Detection

```bash
nmap -sV 127.0.0.1
```

### 🔹 High Intensity Detection

```bash
nmap -sV --version-intensity 9 127.0.0.1
```

### 🔹 OS Detection

```bash
sudo nmap -O 127.0.0.1
```

### 🔹 Combined Detection

```bash
sudo nmap -sV -O 127.0.0.1
```

---

## 📌 Subtask 1.6: Nmap Scripting Engine (NSE)

### 🔹 List Scripts

```bash
ls /usr/share/nmap/scripts/ | head -20
```

### 🔹 Default Scripts

```bash
nmap -sC 127.0.0.1
```

### 🔹 Vulnerability Scripts

```bash
nmap --script vuln 127.0.0.1
```

### 🔹 HTTP Enumeration

```bash
nmap --script http-enum 127.0.0.1
```

### 🔹 Script Help

```bash
nmap --script-help http-enum
```

---

# 🤖 Task 2: Automated Scanning with Bash

## 📌 Create Scanner Script

### 🔹 Create File

```bash
nano nmap_scanner.sh
```

### 🔹 Complete Script

```bash
#!/bin/bash

echo "========================================="
echo "    Automated Nmap Scanner v1.0"
echo "========================================="

if [ $# -eq 0 ]; then
    echo "Usage: $0 <target_ip>"
    exit 1
fi

TARGET=$1
TIMESTAMP=$(date +"%Y%m%d_%H%M%S")
OUTPUT_DIR="nmap_results_${TIMESTAMP}"

mkdir -p $OUTPUT_DIR

echo "Target: $TARGET"

host_discovery() {
    nmap -sn $TARGET > $OUTPUT_DIR/host_discovery.txt 2>&1
}

quick_scan() {
    nmap -T4 -F $TARGET > $OUTPUT_DIR/quick_scan.txt 2>&1
}

service_detection() {
    nmap -sV -T4 $TARGET > $OUTPUT_DIR/service_detection.txt 2>&1
}

host_discovery
quick_scan
service_detection

echo "[SUCCESS] Scan Complete"
```

### 🔹 Make Executable

```bash
chmod +x nmap_scanner.sh
```

### 🔹 Execute

```bash
./nmap_scanner.sh 127.0.0.1
```

---

# 🧠 Task 3: Multi-Target Scanner

### 🔹 Create Script

```bash
nano advanced_nmap_scanner.sh
```

### 🔹 Execute

```bash
chmod +x advanced_nmap_scanner.sh

./advanced_nmap_scanner.sh \
-t 127.0.0.1 \
-p 22,80,443,3306 \
-o test_scan
```

### 🔹 Scan Multiple Hosts

```bash
./advanced_nmap_scanner.sh \
-f targets.txt \
-a \
-o multi_target_scan
```

---

# 📊 Verification & Analysis

## 🔹 View Results

```bash
cat nmap_results_*/quick_scan.txt
```

```bash
cat nmap_results_*/service_detection.txt
```

```bash
cat nmap_results_*/scan_summary_report.txt
```

---

## 🔹 Extract Open Ports

```bash
grep "open" nmap_results_*/quick_scan.txt
```

---

## 🔹 Extract Service Versions

```bash
grep "open" nmap_results_*/service_detection.txt | grep -v "filtered"
```

---

# 🔬 Results Analysis Script

```bash
#!/bin/bash

if [ $# -eq 0 ]; then
    echo "Usage: $0 <results_directory>"
    exit 1
fi

RESULTS_DIR=$1

OPEN_PORTS=$(find "$RESULTS_DIR" -name "*.txt" \
-exec grep -h "open" {} \; | wc -l)

echo "Total open ports found: $OPEN_PORTS"

echo ""
echo "Services discovered:"
find "$RESULTS_DIR" -name "*.txt" \
-exec grep -h "open" {} \; | awk '{print $3}' \
| sort | uniq
```

### 🔹 Execute

```bash
chmod +x analyze_results.sh

./analyze_results.sh nmap_results_*
```

---

# 🛠️ Troubleshooting

## ❌ Permission Errors

```bash
sudo nmap -O 127.0.0.1
sudo nmap -sS 127.0.0.1
```

---

## ❌ Slow Scans

```bash
nmap -T5 127.0.0.1
```

```bash
nmap -T4 127.0.0.1
```

```bash
nmap -T2 127.0.0.1
```

---

## ❌ No Open Ports

```bash
sudo systemctl start ssh
sudo systemctl start apache2
sudo netstat -tlnp
```

---

## ❌ Script Errors

```bash
chmod +x script_name.sh
```

```bash
bash -n script_name.sh
```

```bash
bash -x script_name.sh
```

---

# 🔐 Best Practices

✅ Scan only systems you own or have authorization to assess

✅ Use host discovery before intensive scans

✅ Save reports for compliance and auditing

✅ Apply appropriate timing templates

✅ Limit scan scope whenever possible

---

# 🎓 Skills Gained

* Host Discovery
* Port Scanning
* Service Enumeration
* OS Fingerprinting
* Vulnerability Discovery
* Bash Automation
* Incident Response Support
* Adversary Emulation Techniques

---

# 💼 Real-World Applications

### 🛡️ Incident Response

Quickly identify exposed services and compromised hosts.

### 🎯 Adversary Emulation

Simulate attacker reconnaissance techniques.

### 🔍 Security Assessments

Discover unauthorized services and weak configurations.

### ⚙️ DevSecOps Automation

Integrate scanning scripts into security workflows.

---

# 🏁 Conclusion

In this lab, you successfully learned how to perform network scanning and enumeration using **Nmap**, automate reconnaissance tasks with **Bash scripting**, analyze scan results, and apply these techniques to **Incident Response**, **Threat Hunting**, and **Adversary Emulation** scenarios.

The combination of manual Nmap expertise and automated scanning workflows provides a strong foundation for advanced cybersecurity operations and prepares you for real-world SOC, Pentesting, Red Team, and Blue Team responsibilities.

---

⭐ If you found this lab useful, consider starring the repository and expanding it with NSE scripting, vulnerability assessment automation, and reporting dashboards.
