# 🌐 Network Forensics with Zeek
### Complete Lab Guide — Network Traffic Analysis & Threat Detection

![Network Forensics](https://img.shields.io/badge/Domain-Network%20Forensics-darkblue?style=for-the-badge&logo=wireshark&logoColor=white)
![Zeek](https://img.shields.io/badge/Tool-Zeek%20(Bro)-FF6600?style=for-the-badge&logo=linux&logoColor=white)
![Platform](https://img.shields.io/badge/Platform-Ubuntu%2020.04-E95420?style=for-the-badge&logo=ubuntu&logoColor=white)
![Level](https://img.shields.io/badge/Level-Intermediate-yellow?style=for-the-badge&logo=bookstack&logoColor=white)
![License](https://img.shields.io/badge/License-Educational-green?style=for-the-badge&logo=open-source-initiative&logoColor=white)

---

## 📋 Table of Contents

- [🎯 Objectives](#-objectives)
- [✅ Prerequisites](#-prerequisites)
- [🖥️ Lab Environment](#️-lab-environment)
- [📦 Task 1 — Installing and Configuring Zeek](#-task-1--installing-and-configuring-zeek)
- [📡 Task 2 — Capturing and Analyzing Network Traffic](#-task-2--capturing-and-analyzing-network-traffic)
- [🧠 Task 3 — Writing Custom Zeek Scripts for Malicious Traffic Detection](#-task-3--writing-custom-zeek-scripts-for-malicious-traffic-detection)
- [🚨 Task 4 — Testing and Analyzing Malicious Traffic Detection](#-task-4--testing-and-analyzing-malicious-traffic-detection)
- [📊 Task 5 — Advanced Analysis and Reporting](#-task-5--advanced-analysis-and-reporting)
- [🔧 Troubleshooting](#-troubleshooting)
- [🏁 Conclusion](#-conclusion)

---

## 🎯 Objectives

By the end of this lab, students will be able to:

| # | Objective |
|---|-----------|
| 1 | Install and configure Zeek (formerly Bro) on a Linux system |
| 2 | Capture and analyze network traffic using Zeek |
| 3 | Understand Zeek's log structure and data formats |
| 4 | Write custom Zeek scripts to filter and detect malicious traffic patterns |
| 5 | Analyze network connections, DNS queries, and HTTP traffic |
| 6 | Create detection rules for common attack patterns |
| 7 | Generate forensic reports from Zeek logs |

---

## ✅ Prerequisites

![TCP/IP](https://img.shields.io/badge/Networking-TCP%2FIP%20%7C%20DNS%20%7C%20HTTP-0078D4?style=flat-square&logo=cisco&logoColor=white)
![Linux](https://img.shields.io/badge/Linux-CLI-FCC624?style=flat-square&logo=linux&logoColor=black)
![Security](https://img.shields.io/badge/Network-Security%20Fundamentals-red?style=flat-square&logo=hackthebox&logoColor=white)
![Logs](https://img.shields.io/badge/Log-Analysis-607D8B?style=flat-square&logo=elastic&logoColor=white)
![Scripting](https://img.shields.io/badge/Scripting-Helpful%20Not%20Required-4EAA25?style=flat-square&logo=gnubash&logoColor=white)

Before starting this lab, students should have:

- Basic understanding of **networking concepts** (TCP/IP, DNS, HTTP)
- Familiarity with **Linux command line** operations
- Knowledge of **network security fundamentals**
- Understanding of **log analysis** concepts
- Basic **scripting knowledge** (helpful but not required)

---

## 🖥️ Lab Environment

> 💡 **Al Nafi** provides Linux-based cloud machines for this lab.  
> Simply click **Start Lab** to access your pre-configured environment.  
> No need to build your own VM or install additional software — everything is ready to use.

---

## 📦 Task 1 — Installing and Configuring Zeek

### ✨ Subtask 1.1 — Install Zeek on the System

![apt](https://img.shields.io/badge/Package_Manager-APT-E95420?style=flat-square&logo=ubuntu&logoColor=white)
![Zeek](https://img.shields.io/badge/Tool-Zeek-FF6600?style=flat-square&logo=linux&logoColor=white)
![Repo](https://img.shields.io/badge/Source-OpenSUSE%20Repo-73BA25?style=flat-square&logo=opensuse&logoColor=white)

First, we'll install Zeek and verify the installation.

```bash
# Update the system packages
sudo apt update && sudo apt upgrade -y

# Install required dependencies
sudo apt install -y cmake make gcc g++ flex bison libpcap-dev libssl-dev python3-dev swig zlib1g-dev

# Add Zeek repository
echo 'deb http://download.opensuse.org/repositories/security:/zeek/xUbuntu_20.04/ /' | sudo tee /etc/apt/sources.list.d/security:zeek.list

# Add repository key
curl -fsSL https://download.opensuse.org/repositories/security:zeek/xUbuntu_20.04/Release.key | gpg --dearmor | sudo tee /etc/apt/trusted.gpg.d/security_zeek.gpg > /dev/null

# Update package list and install Zeek
sudo apt update
sudo apt install -y zeek

# Add Zeek to PATH
echo 'export PATH=/opt/zeek/bin:$PATH' >> ~/.bashrc
source ~/.bashrc
```

---

### ✨ Subtask 1.2 — Verify Zeek Installation

![Verify](https://img.shields.io/badge/Status-Verify_Install-brightgreen?style=flat-square&logo=checkmarx&logoColor=white)

Check if Zeek is properly installed and accessible.

```bash
# Check Zeek version
zeek --version

# Verify Zeek binary location
which zeek

# Check available network interfaces
ip link show
```

---

### ✨ Subtask 1.3 — Configure Zeek for Local Interface

![Config](https://img.shields.io/badge/Config-Local_Interface-1565C0?style=flat-square&logo=gnubash&logoColor=white)
![JSON](https://img.shields.io/badge/Output-JSON_Logs-F7DF1E?style=flat-square&logo=json&logoColor=black)

Set up Zeek to monitor the local network interface.

```bash
# Create a working directory for our lab
mkdir ~/zeek-lab
cd ~/zeek-lab

# Create a basic Zeek configuration file
cat > local.zeek << 'EOF'
# Load base scripts
@load base/frameworks/software
@load base/protocols/conn
@load base/protocols/dns
@load base/protocols/http
@load base/protocols/ssl

# Enable local logging
redef LogAscii::use_json = T;
EOF
```

---

## 📡 Task 2 — Capturing and Analyzing Network Traffic

### ✨ Subtask 2.1 — Generate Sample Network Traffic

![Traffic](https://img.shields.io/badge/Action-Generate_Traffic-blueviolet?style=flat-square&logo=wireshark&logoColor=white)
![curl](https://img.shields.io/badge/Tool-curl%20%7C%20nslookup-009688?style=flat-square&logo=curl&logoColor=white)

Create some network activity to analyze with Zeek.

```bash
# Generate HTTP traffic
curl -s http://httpbin.org/get > /dev/null &
curl -s http://httpbin.org/user-agent > /dev/null &
curl -s http://example.com > /dev/null &

# Generate DNS queries
nslookup google.com > /dev/null &
nslookup github.com > /dev/null &
nslookup malicious-domain-example.com > /dev/null &

# Wait for traffic generation
sleep 5
```

---

### ✨ Subtask 2.2 — Capture Traffic with Zeek

![Capture](https://img.shields.io/badge/Action-Packet_Capture-B71C1C?style=flat-square&logo=wireshark&logoColor=white)
![tcpdump](https://img.shields.io/badge/Tool-tcpdump-555555?style=flat-square&logo=linux&logoColor=white)
![PCAP](https://img.shields.io/badge/Format-PCAP-FF9800?style=flat-square&logo=wireshark&logoColor=white)

Start Zeek to capture and analyze the network traffic.

```bash
# Capture traffic for 30 seconds on the default interface
sudo timeout 30 zeek -i $(ip route | grep default | awk '{print $5}' | head -1) local.zeek

# Alternative: Capture from a pcap file (we'll create one first)
sudo tcpdump -i $(ip route | grep default | awk '{print $5}' | head -1) -w sample_traffic.pcap -c 100 &

# Wait for packet capture
sleep 10

# Analyze the pcap file with Zeek
zeek -r sample_traffic.pcap local.zeek
```

---

### ✨ Subtask 2.3 — Examine Zeek Log Files

![Logs](https://img.shields.io/badge/Analysis-Log_Files-2E7D32?style=flat-square&logo=elastic&logoColor=white)
![jq](https://img.shields.io/badge/Tool-jq-F7DF1E?style=flat-square&logo=json&logoColor=black)

Explore the generated log files to understand Zeek's output format.

```bash
# List all generated log files
ls -la *.log

# Examine connection logs
echo "=== Connection Logs ==="
head -5 conn.log

# Examine DNS logs
echo "=== DNS Logs ==="
head -5 dns.log

# Examine HTTP logs
echo "=== HTTP Logs ==="
head -5 http.log

# Use jq to format JSON logs (if available)
if command -v jq &> /dev/null; then
    echo "=== Formatted Connection Log ==="
    head -1 conn.log | jq .
fi
```

---

## 🧠 Task 3 — Writing Custom Zeek Scripts for Malicious Traffic Detection

### ✨ Subtask 3.1 — Create a Basic Malicious Domain Detection Script

![ZeekScript](https://img.shields.io/badge/Script-Zeek_DSL-FF6600?style=flat-square&logo=linux&logoColor=white)
![DNS](https://img.shields.io/badge/Protocol-DNS_Detection-0078D4?style=flat-square&logo=cisco&logoColor=white)
![HTTP](https://img.shields.io/badge/Protocol-HTTP_Detection-009688?style=flat-square&logo=http&logoColor=white)

Write a Zeek script to detect connections to known malicious domains.

```zeek
# Create a malicious domain detection script
cat > malicious_domains.zeek << 'EOF'
# Malicious Domain Detection Script
@load base/protocols/dns
@load base/protocols/http

module MaliciousDomains;

# Define suspicious domains
global suspicious_domains: set[string] = {
    "malware-example.com",
    "phishing-site.net",
    "suspicious-domain.org",
    "bad-actor.com"
};

# Event handler for DNS queries
event dns_request(c: connection, msg: dns_msg, query: string, qtype: count, qclass: count)
{
    if (query in suspicious_domains)
    {
        print fmt("ALERT: DNS query to suspicious domain: %s from %s", query, c$id$orig_h);
        
        # Log to a custom file
        local log_line = fmt("%s,%s,%s,%s", 
                           strftime("%Y-%m-%d %H:%M:%S", network_time()),
                           c$id$orig_h,
                           "DNS_SUSPICIOUS",
                           query);
        print log_line >> "malicious_activity.log";
    }
}

# Event handler for HTTP requests
event http_request(c: connection, method: string, original_URI: string, unescaped_URI: string, version: string)
{
    if (c$id$resp_h in suspicious_domains || 
        any_substring_in_string(original_URI, suspicious_domains))
    {
        print fmt("ALERT: HTTP request to suspicious domain: %s%s from %s", 
                 c$id$resp_h, original_URI, c$id$orig_h);
        
        local log_line = fmt("%s,%s,%s,%s%s", 
                           strftime("%Y-%m-%d %H:%M:%S", network_time()),
                           c$id$orig_h,
                           "HTTP_SUSPICIOUS",
                           c$id$resp_h,
                           original_URI);
        print log_line >> "malicious_activity.log";
    }
}

# Helper function to check if any substring exists in a string
function any_substring_in_string(str: string, domains: set[string]): bool
{
    for (domain in domains)
    {
        if (domain in str)
            return T;
    }
    return F;
}
EOF
```

---

### ✨ Subtask 3.2 — Create a Port Scan Detection Script

![PortScan](https://img.shields.io/badge/Detection-Port_Scan-D32F2F?style=flat-square&logo=nmap&logoColor=white)
![Threshold](https://img.shields.io/badge/Logic-Threshold_Based-FF9800?style=flat-square&logo=gnubash&logoColor=white)

Develop a script to detect potential port scanning activities.

```zeek
# Create a port scan detection script
cat > port_scan_detector.zeek << 'EOF'
# Port Scan Detection Script
@load base/protocols/conn

module PortScanDetector;

# Track connection attempts per source IP
global connection_counts: table[addr] of count &default=0;
global port_counts: table[addr] of set[port] &default=set();

# Threshold for port scan detection
const PORT_SCAN_THRESHOLD = 10;
const TIME_WINDOW = 60sec;

# Event handler for new connections
event connection_state_remove(c: connection)
{
    local src_ip = c$id$orig_h;
    local dst_port = c$id$resp_p;
    
    # Increment connection count
    ++connection_counts[src_ip];
    
    # Add destination port to the set
    add port_counts[src_ip][dst_port];
    
    # Check if threshold is exceeded
    if (|port_counts[src_ip]| >= PORT_SCAN_THRESHOLD)
    {
        print fmt("ALERT: Potential port scan detected from %s - %d unique ports accessed", 
                 src_ip, |port_counts[src_ip]|);
        
        local log_line = fmt("%s,%s,%s,%d", 
                           strftime("%Y-%m-%d %H:%M:%S", network_time()),
                           src_ip,
                           "PORT_SCAN",
                           |port_counts[src_ip]|);
        print log_line >> "malicious_activity.log";
        
        # Reset counters to avoid repeated alerts
        delete connection_counts[src_ip];
        delete port_counts[src_ip];
    }
}

# Periodic cleanup of old entries
event zeek_init()
{
    schedule TIME_WINDOW { cleanup_old_entries() };
}

event cleanup_old_entries()
{
    # Reset all counters periodically
    clear_table(connection_counts);
    clear_table(port_counts);
    
    # Schedule next cleanup
    schedule TIME_WINDOW { cleanup_old_entries() };
}
EOF
```

---

### ✨ Subtask 3.3 — Create a Suspicious User Agent Detection Script

![UserAgent](https://img.shields.io/badge/Detection-User_Agent-880E4F?style=flat-square&logo=http&logoColor=white)
![HTTP](https://img.shields.io/badge/Protocol-HTTP_Analysis-009688?style=flat-square&logo=http&logoColor=white)

Build a script to identify suspicious HTTP user agents.

```zeek
# Create a suspicious user agent detection script
cat > suspicious_user_agents.zeek << 'EOF'
# Suspicious User Agent Detection Script
@load base/protocols/http

module SuspiciousUserAgents;

# Define suspicious user agent patterns
global suspicious_patterns: set[string] = {
    "sqlmap",
    "nikto",
    "nmap",
    "masscan",
    "python-requests",
    "curl/7.0",  # Very old curl version
    "wget/1.0",  # Very old wget version
    "bot",
    "crawler",
    "scanner"
};

# Event handler for HTTP requests
event http_request(c: connection, method: string, original_URI: string, unescaped_URI: string, version: string)
{
    # Check if user agent header exists
    if (c$http?$user_agent)
    {
        local user_agent = to_lower(c$http$user_agent);
        
        for (pattern in suspicious_patterns)
        {
            if (pattern in user_agent)
            {
                print fmt("ALERT: Suspicious User Agent detected: %s from %s to %s%s", 
                         c$http$user_agent, c$id$orig_h, c$id$resp_h, original_URI);
                
                local log_line = fmt("%s,%s,%s,%s,%s%s", 
                               strftime("%Y-%m-%d %H:%M:%S", network_time()),
                               c$id$orig_h,
                               "SUSPICIOUS_USER_AGENT",
                               c$http$user_agent,
                               c$id$resp_h,
                               original_URI);
                print log_line >> "malicious_activity.log";
                break;
            }
        }
    }
}
EOF
```

---

## 🚨 Task 4 — Testing and Analyzing Malicious Traffic Detection

### ✨ Subtask 4.1 — Create a Comprehensive Detection Script

![Comprehensive](https://img.shields.io/badge/Script-Master_Detection-4527A0?style=flat-square&logo=gnubash&logoColor=white)
![Zeek](https://img.shields.io/badge/Engine-Zeek_DSL-FF6600?style=flat-square&logo=linux&logoColor=white)

Combine all detection scripts into one comprehensive script.

```zeek
# Create a master detection script
cat > comprehensive_detection.zeek << 'EOF'
# Comprehensive Network Security Detection Script
@load base/protocols/conn
@load base/protocols/dns
@load base/protocols/http
@load malicious_domains.zeek
@load port_scan_detector.zeek
@load suspicious_user_agents.zeek

# Initialize logging
event zeek_init()
{
    print "Starting comprehensive network security monitoring...";
    print "Monitoring for:";
    print "- Malicious domains";
    print "- Port scanning activities";
    print "- Suspicious user agents";
    print "- Unusual connection patterns";
}

# Additional connection analysis
event connection_state_remove(c: connection)
{
    # Detect unusually long connections
    if (c$duration > 3600.0)  # 1 hour
    {
        print fmt("ALERT: Long-duration connection detected: %s -> %s:%d (Duration: %.2f seconds)", 
                 c$id$orig_h, c$id$resp_h, c$id$resp_p, c$duration);
        
        local log_line = fmt("%s,%s,%s,%s:%d,%.2f", 
                           strftime("%Y-%m-%d %H:%M:%S", network_time()),
                           c$id$orig_h,
                           "LONG_CONNECTION",
                           c$id$resp_h,
                           c$id$resp_p,
                           c$duration);
        print log_line >> "malicious_activity.log";
    }
    
    # Detect high data transfer
    if (c$orig_bytes > 100000000)  # 100MB
    {
        print fmt("ALERT: High data transfer detected: %s -> %s:%d (%d bytes)", 
                 c$id$orig_h, c$id$resp_h, c$id$resp_p, c$orig_bytes);
        
        local log_line = fmt("%s,%s,%s,%s:%d,%d", 
                           strftime("%Y-%m-%d %H:%M:%S", network_time()),
                           c$id$orig_h,
                           "HIGH_DATA_TRANSFER",
                           c$id$resp_h,
                           c$id$resp_p,
                           c$orig_bytes);
        print log_line >> "malicious_activity.log";
    }
}
EOF
```

---

### ✨ Subtask 4.2 — Generate Test Traffic for Detection

![TestTraffic](https://img.shields.io/badge/Action-Test_Traffic_Gen-FF5722?style=flat-square&logo=gnubash&logoColor=white)
![Simulation](https://img.shields.io/badge/Simulate-Port_Scan%20%7C%20SQLMap%20%7C%20DNS-blueviolet?style=flat-square&logo=nmap&logoColor=white)

Create various types of network traffic to test our detection scripts.

```bash
# Create a script to generate test traffic
cat > generate_test_traffic.sh << 'EOF'
#!/bin/bash

echo "Generating test traffic for Zeek analysis..."

# Generate normal HTTP traffic
echo "1. Generating normal HTTP traffic..."
curl -s http://httpbin.org/get > /dev/null &
curl -s http://example.com > /dev/null &

# Generate suspicious user agent traffic
echo "2. Generating suspicious user agent traffic..."
curl -s -A "sqlmap/1.0" http://httpbin.org/user-agent > /dev/null &
curl -s -A "nikto/2.1.6" http://httpbin.org/user-agent > /dev/null &

# Generate DNS queries (including suspicious ones)
echo "3. Generating DNS queries..."
nslookup google.com > /dev/null &
nslookup malware-example.com > /dev/null &

# Simulate port scanning by connecting to multiple ports
echo "4. Simulating port scan..."
for port in 22 23 25 53 80 110 143 443 993 995; do
    timeout 1 nc -z localhost $port 2>/dev/null &
done

# Generate some file transfers
echo "5. Generating file transfer traffic..."
wget -q -O /dev/null http://httpbin.org/bytes/1024 &

echo "Test traffic generation complete. Waiting for connections to finish..."
sleep 10
EOF

# Make the script executable and run it
chmod +x generate_test_traffic.sh
./generate_test_traffic.sh
```

---

### ✨ Subtask 4.3 — Run Zeek with Detection Scripts

![Run](https://img.shields.io/badge/Execute-Zeek_Detection-1565C0?style=flat-square&logo=gnubash&logoColor=white)

Execute Zeek with our comprehensive detection scripts.

```bash
# Run Zeek with all detection scripts
echo "Starting Zeek with comprehensive detection..."

# Create a new capture session
sudo timeout 60 zeek -i $(ip route | grep default | awk '{print $5}' | head -1) comprehensive_detection.zeek &

# Generate test traffic while Zeek is running
sleep 5
./generate_test_traffic.sh

# Wait for Zeek to finish
wait

echo "Zeek analysis complete. Checking results..."
```

---

### ✨ Subtask 4.4 — Analyze Detection Results

![Results](https://img.shields.io/badge/Analysis-Detection_Results-43A047?style=flat-square&logo=elastic&logoColor=white)

Examine the results of our malicious traffic detection.

```bash
# Check if malicious activity log was created
if [ -f "malicious_activity.log" ]; then
    echo "=== Malicious Activity Detected ==="
    cat malicious_activity.log
    echo ""
    
    # Count different types of alerts
    echo "=== Alert Summary ==="
    echo "DNS Suspicious: $(grep -c 'DNS_SUSPICIOUS' malicious_activity.log)"
    echo "HTTP Suspicious: $(grep -c 'HTTP_SUSPICIOUS' malicious_activity.log)"
    echo "Port Scans: $(grep -c 'PORT_SCAN' malicious_activity.log)"
    echo "Suspicious User Agents: $(grep -c 'SUSPICIOUS_USER_AGENT' malicious_activity.log)"
    echo "Long Connections: $(grep -c 'LONG_CONNECTION' malicious_activity.log)"
    echo "High Data Transfers: $(grep -c 'HIGH_DATA_TRANSFER' malicious_activity.log)"
else
    echo "No malicious activity log found. This might indicate no threats were detected."
fi

# Analyze standard Zeek logs
echo ""
echo "=== Standard Zeek Log Analysis ==="

# Connection statistics
if [ -f "conn.log" ]; then
    echo "Total connections logged: $(wc -l < conn.log)"
    echo "Unique source IPs: $(cut -d',' -f3 conn.log | sort -u | wc -l)"
    echo "Unique destination IPs: $(cut -d',' -f4 conn.log | sort -u | wc -l)"
fi

# DNS statistics
if [ -f "dns.log" ]; then
    echo "Total DNS queries: $(wc -l < dns.log)"
    echo "Unique domains queried: $(cut -d',' -f10 dns.log | sort -u | wc -l)"
fi

# HTTP statistics
if [ -f "http.log" ]; then
    echo "Total HTTP requests: $(wc -l < http.log)"
    echo "Unique user agents: $(cut -d',' -f13 http.log | sort -u | wc -l)"
fi
```

---

## 📊 Task 5 — Advanced Analysis and Reporting

### ✨ Subtask 5.1 — Create a Forensic Analysis Script

![Python](https://img.shields.io/badge/Python-3.x-3776AB?style=flat-square&logo=python&logoColor=white)
![Forensics](https://img.shields.io/badge/Script-Forensic_Analyzer-546E7A?style=flat-square&logo=readthedocs&logoColor=white)
![JSON](https://img.shields.io/badge/Parser-JSON_Log_Reader-F7DF1E?style=flat-square&logo=json&logoColor=black)

Develop a script to perform comprehensive forensic analysis of Zeek logs.

```python
# Create a forensic analysis script
cat > forensic_analysis.py << 'EOF'
#!/usr/bin/env python3
"""
Zeek Log Forensic Analysis Tool
Analyzes Zeek logs to identify security incidents and generate reports
"""

import json
import csv
import sys
from collections import defaultdict, Counter
from datetime import datetime
import os

class ZeekForensicAnalyzer:
    def __init__(self):
        self.connections = []
        self.dns_queries = []
        self.http_requests = []
        self.alerts = []
        
    def load_malicious_activity_log(self, filename):
        """Load malicious activity alerts"""
        if not os.path.exists(filename):
            print(f"Warning: {filename} not found")
            return
            
        with open(filename, 'r') as f:
            for line in f:
                parts = line.strip().split(',')
                if len(parts) >= 3:
                    self.alerts.append({
                        'timestamp': parts[0],
                        'source_ip': parts[1],
                        'alert_type': parts[2],
                        'details': ','.join(parts[3:]) if len(parts) > 3 else ''
                    })
    
    def analyze_connections(self, filename):
        """Analyze connection patterns"""
        if not os.path.exists(filename):
            print(f"Warning: {filename} not found")
            return
            
        connection_stats = {
            'total_connections': 0,
            'unique_sources': set(),
            'unique_destinations': set(),
            'protocols': Counter(),
            'top_talkers': Counter()
        }
        
        try:
            with open(filename, 'r') as f:
                # Skip header if present
                first_line = f.readline()
                if not first_line.startswith('{'):
                    f.seek(0)
                else:
                    f.seek(0)
                
                for line in f:
                    try:
                        if line.strip().startswith('{'):
                            conn = json.loads(line.strip())
                        else:
                            # Handle TSV format
                            continue
                            
                        connection_stats['total_connections'] += 1
                        connection_stats['unique_sources'].add(conn.get('id.orig_h', ''))
                        connection_stats['unique_destinations'].add(conn.get('id.resp_h', ''))
                        connection_stats['protocols'][conn.get('proto', 'unknown')] += 1
                        connection_stats['top_talkers'][conn.get('id.orig_h', '')] += 1
                        
                    except json.JSONDecodeError:
                        continue
                        
        except Exception as e:
            print(f"Error analyzing connections: {e}")
            
        return connection_stats
    
    def generate_report(self):
        """Generate comprehensive forensic report"""
        print("=" * 60)
        print("ZEEK FORENSIC ANALYSIS REPORT")
        print("=" * 60)
        print(f"Report Generated: {datetime.now().strftime('%Y-%m-%d %H:%M:%S')}")
        print()
        
        # Alert Summary
        print("SECURITY ALERTS SUMMARY")
        print("-" * 30)
        if self.alerts:
            alert_types = Counter([alert['alert_type'] for alert in self.alerts])
            for alert_type, count in alert_types.most_common():
                print(f"{alert_type}: {count}")
            
            print("\nDETAILED ALERTS:")
            for alert in self.alerts[-10:]:  # Show last 10 alerts
                print(f"  {alert['timestamp']} - {alert['source_ip']} - {alert['alert_type']}")
                if alert['details']:
                    print(f"    Details: {alert['details']}")
        else:
            print("No security alerts detected.")
        
        print()
        
        # Connection Analysis
        conn_stats = self.analyze_connections('conn.log')
        print("CONNECTION ANALYSIS")
        print("-" * 20)
        print(f"Total Connections: {conn_stats['total_connections']}")
        print(f"Unique Source IPs: {len(conn_stats['unique_sources'])}")
        print(f"Unique Destination IPs: {len(conn_stats['unique_destinations'])}")
        
        print("\nTop Protocols:")
        for proto, count in conn_stats['protocols'].most_common(5):
            print(f"  {proto}: {count}")
        
        print("\nTop Talkers:")
        for ip, count in conn_stats['top_talkers'].most_common(5):
            print(f"  {ip}: {count} connections")
        
        print()
        
        # Recommendations
        print("SECURITY RECOMMENDATIONS")
        print("-" * 25)
        if self.alerts:
            print("1. Investigate flagged IP addresses for potential threats")
            print("2. Review DNS queries to suspicious domains")
            print("3. Analyze HTTP traffic with suspicious user agents")
            print("4. Monitor for continued port scanning activities")
        else:
            print("1. Continue monitoring network traffic")
            print("2. Update detection rules regularly")
            print("3. Review baseline network behavior")
        
        print("\n" + "=" * 60)

def main():
    analyzer = ZeekForensicAnalyzer()
    
    # Load malicious activity alerts
    analyzer.load_malicious_activity_log('malicious_activity.log')
    
    # Generate comprehensive report
    analyzer.generate_report()

if __name__ == "__main__":
    main()
EOF

# Make the script executable
chmod +x forensic_analysis.py

# Run the forensic analysis
echo "Running forensic analysis..."
python3 forensic_analysis.py
```

---

### ✨ Subtask 5.2 — Create Network Timeline Analysis

![Timeline](https://img.shields.io/badge/Analysis-Timeline-00ACC1?style=flat-square&logo=clockify&logoColor=white)
![Bash](https://img.shields.io/badge/Script-Bash-4EAA25?style=flat-square&logo=gnubash&logoColor=white)

Generate a timeline of network events for forensic investigation.

```bash
# Create a timeline analysis script
cat > timeline_analysis.sh << 'EOF'
#!/bin/bash

echo "NETWORK TIMELINE ANALYSIS"
echo "========================="

# Create a combined timeline from all logs
echo "Creating network event timeline..."

# Function to extract timestamps and events
create_timeline() {
    local output_file="network_timeline.txt"
    
    # Clear previous timeline
    > "$output_file"
    
    # Process malicious activity log
    if [ -f "malicious_activity.log" ]; then
        while IFS=',' read -r timestamp source_ip alert_type details; do
            echo "$timestamp [ALERT] $source_ip - $alert_type: $details" >> "$output_file"
        done < malicious_activity.log
    fi
    
    # Process connection log (first 20 entries)
    if [ -f "conn.log" ]; then
        head -20 conn.log | while read -r line; do
            if [[ $line == \{* ]]; then
                # Extract timestamp from JSON
                timestamp=$(echo "$line" | python3 -c "import sys, json; data=json.load(sys.stdin); print(data.get('ts', 'N/A'))" 2>/dev/null)
                orig_h=$(echo "$line" | python3 -c "import sys, json; data=json.load(sys.stdin); print(data.get('id.orig_h', 'N/A'))" 2>/dev/null)
                resp_h=$(echo "$line" | python3 -c "import sys, json; data=json.load(sys.stdin); print(data.get('id.resp_h', 'N/A'))" 2>/dev/null)
                resp_p=$(echo "$line" | python3 -c "import sys, json; data=json.load(sys.stdin); print(data.get('id.resp_p', 'N/A'))" 2>/dev/null)
                
                if [ "$timestamp" != "N/A" ]; then
                    readable_time=$(date -d "@$timestamp" "+%Y-%m-%d %H:%M:%S" 2>/dev/null || echo "$timestamp")
                    echo "$readable_time [CONN] $orig_h -> $resp_h:$resp_p" >> "$output_file"
                fi
            fi
        done
    fi
    
    # Sort timeline by timestamp
    sort "$output_file" -o "$output_file"
    
    echo "Timeline created: $output_file"
    echo ""
    echo "Recent network events:"
    echo "----------------------"
    tail -20 "$output_file"
}

create_timeline
EOF

# Make executable and run
chmod +x timeline_analysis.sh
./timeline_analysis.sh
```

---

### ✨ Subtask 5.3 — Generate Final Security Report

![FinalReport](https://img.shields.io/badge/Output-Final_Report-455A64?style=flat-square&logo=readthedocs&logoColor=white)
![Archive](https://img.shields.io/badge/Action-Export_Results-607D8B?style=flat-square&logo=files&logoColor=white)

Create a comprehensive security assessment report.

```bash
# Create final report generator
cat > generate_final_report.sh << 'EOF'
#!/bin/bash

REPORT_FILE="zeek_security_report_$(date +%Y%m%d_%H%M%S).txt"

cat > "$REPORT_FILE" << EOL
================================================================================
                        NETWORK SECURITY ANALYSIS REPORT
                              Generated by Zeek
================================================================================

Report Date: $(date)
Analysis Period: Network traffic capture session
Analyst: Lab Student

EXECUTIVE SUMMARY
-----------------
This report presents the findings from network traffic analysis using Zeek
(formerly Bro) network security monitor. The analysis focused on detecting
malicious activities, suspicious patterns, and potential security threats.

METHODOLOGY
-----------
1. Network traffic capture using Zeek on local interface
2. Custom script deployment for threat detection
3. Log analysis and pattern recognition
4. Forensic timeline reconstruction
5. Security assessment and recommendations

FINDINGS
--------
EOL

# Add alert summary
if [ -f "malicious_activity.log" ]; then
    echo "Security Alerts Detected: YES" >> "$REPORT_FILE"
    echo "Total Alerts: $(wc -l < malicious_activity.log)" >> "$REPORT_FILE"
    echo "" >> "$REPORT_FILE"
    echo "Alert Breakdown:" >> "$REPORT_FILE"
    grep -o '[A-Z_]*' malicious_activity.log | sort | uniq -c | while read count type; do
        echo "  $type: $count" >> "$REPORT_FILE"
    done
else
    echo "Security Alerts Detected: NO" >> "$REPORT_FILE"
fi

echo "" >> "$REPORT_FILE"

# Add traffic statistics
cat >> "$REPORT_FILE" << EOL

TRAFFIC STATISTICS
------------------
EOL

if [ -f "conn.log" ]; then
    echo "Total Connections: $(wc -l < conn.log)" >> "$REPORT_FILE"
fi

if [ -f "dns.log" ]; then
    echo "DNS Queries: $(wc -l < dns.log)" >> "$REPORT_FILE"
fi

if [ -f "http.log" ]; then
    echo "HTTP Requests: $(wc -l < http.log)" >> "$REPORT_FILE"
fi

cat >> "$REPORT_FILE" << EOL

SECURITY RECOMMENDATIONS
------------------------
1. Continue monitoring network traffic with Zeek
2. Regularly update threat detection signatures
3. Investigate any flagged suspicious activities
4. Implement network segmentation for critical assets
5. Establish baseline network behavior patterns
6. Create automated alerting for high-priority threats
7. Conduct regular security assessments

TECHNICAL DETAILS
-----------------
Detection Scripts Used:
- Malicious domain detection
- Port scan detection
- Suspicious user agent identification
- Connection anomaly detection

Log Files Generated:
EOL

ls -la *.log >> "$REPORT_FILE" 2>/dev/null

cat >> "$REPORT_FILE" << EOL

CONCLUSION
----------
The Zeek network security monitoring system successfully captured and analyzed
network traffic, providing valuable insights into network behavior and potential
security threats. The custom detection scripts demonstrated effective capability
in identifying suspicious activities and generating actionable security alerts.

Regular deployment of such monitoring tools is essential for maintaining
network security posture and enabling rapid incident response.

================================================================================
                                END OF REPORT
================================================================================
EOL

echo "Final security report generated: $REPORT_FILE"
echo ""
echo "Report preview:"
echo "==============="
head -30 "$REPORT_FILE"
echo "..."
echo "(Full report saved to $REPORT_FILE)"
EOF

# Make executable and run
chmod +x generate_final_report.sh
./generate_final_report.sh
```

---

## 🔧 Troubleshooting

### ⚠️ Issue 1 — Zeek Not Found in PATH

![Error](https://img.shields.io/badge/Error-PATH_Not_Set-red?style=flat-square&logo=linux&logoColor=white)

**Problem:** Zeek binary not accessible from the command line.

**Solution:**

```bash
# Solution: Add Zeek to PATH manually
export PATH=/opt/zeek/bin:$PATH
# Or find Zeek installation
find /usr -name "zeek" 2>/dev/null
```

---

### ⚠️ Issue 2 — Permission Denied When Capturing Traffic

![Error](https://img.shields.io/badge/Error-Permission_Denied-orange?style=flat-square&logo=lock&logoColor=white)

**Problem:** Cannot capture traffic without elevated privileges.

**Solution:**

```bash
# Solution: Run with sudo or add user to appropriate group
sudo zeek -i eth0 local.zeek
# Or add user to pcap group
sudo usermod -a -G pcap $USER
```

---

### ⚠️ Issue 3 — No Log Files Generated

![Error](https://img.shields.io/badge/Error-No_Logs-yellow?style=flat-square&logo=elastic&logoColor=white)

**Problem:** Zeek runs but produces no output log files.

**Solution:**

```bash
# Solution: Check Zeek syntax and permissions
zeek -C local.zeek  # Check syntax
ls -la *.log        # Check if files exist
zeek --help         # Review options
```

---

### ⚠️ Issue 4 — JSON Parsing Errors

![Error](https://img.shields.io/badge/Error-JSON_Parse_Fail-critical?style=flat-square&logo=json&logoColor=white)

**Problem:** Log files not in expected JSON format.

**Solution:**

```bash
# Solution: Verify log format
head -1 conn.log    # Check first line
# Enable JSON format explicitly
echo 'redef LogAscii::use_json = T;' >> local.zeek
```

---

## 🏁 Conclusion

### 🧠 Skills Acquired in This Lab

![Zeek](https://img.shields.io/badge/✔-Zeek_Installation_%26_Config-FF6600?style=flat-square)
![Capture](https://img.shields.io/badge/✔-Traffic_Capture_%26_Analysis-blue?style=flat-square)
![Scripts](https://img.shields.io/badge/✔-Custom_Zeek_Scripts-green?style=flat-square)
![Detection](https://img.shields.io/badge/✔-Threat_Detection_Rules-red?style=flat-square)
![Reporting](https://img.shields.io/badge/✔-Forensic_Reporting-purple?style=flat-square)

| Skill | Description |
|-------|-------------|
| 🔧 Installation | Installed and configured Zeek on a Linux system for network security monitoring |
| 📡 Capture | Captured and analyzed live network traffic using Zeek |
| 📂 Log Analysis | Understood Zeek's log structure and JSON data formats |
| ✍️ Scripting | Wrote custom Zeek scripts to detect malicious traffic patterns |
| 🔍 Investigation | Analyzed network connections, DNS queries, and HTTP traffic |
| 🛡️ Detection Rules | Created detection rules for common attack patterns |
| 📝 Reporting | Generated professional forensic reports from Zeek logs |

---

### 🌍 Real-World Applications

The techniques learned in this lab directly apply to:

- 🔥 **Incident Response** — Rapid network traffic analysis during active incidents
- 🕵️ **Threat Hunting** — Proactively searching for adversaries in network logs
- 🦠 **Malware Analysis** — Identifying C2 communication and malicious domains
- 🛡️ **SOC Operations** — Continuous network monitoring and alert triage
- ⚖️ **Digital Forensics** — Timeline reconstruction from network evidence

---

### 💡 Why This Matters

> Zeek provides **unparalleled visibility** into network traffic that traditional firewall logs cannot offer.  
> Its scripting language allows analysts to write **custom detection logic** tailored to their environment,  
> making it one of the most powerful open-source network security tools available.

Network forensics with Zeek is an essential skill for professionals working in:

![SOC](https://img.shields.io/badge/Role-SOC_Analyst-blue?style=for-the-badge&logo=shield&logoColor=white)
![IR](https://img.shields.io/badge/Role-Incident_Responder-red?style=for-the-badge&logo=firefighters&logoColor=white)
![TH](https://img.shields.io/badge/Role-Threat_Hunter-orange?style=for-the-badge&logo=target&logoColor=white)
![DFIR](https://img.shields.io/badge/Role-DFIR_Specialist-darkblue?style=for-the-badge&logo=forensicscience&logoColor=white)

---

<div align="center">

**🌐 Network Forensics with Zeek Lab — Complete**

![Made With](https://img.shields.io/badge/Made%20with-❤️%20%26%20Zeek-FF6600?style=for-the-badge)
![Platform](https://img.shields.io/badge/Al%20Nafi-Cybersecurity%20Labs-0A66C2?style=for-the-badge&logo=academia&logoColor=white)

*"Know your network. Defend your network."*

</div>
