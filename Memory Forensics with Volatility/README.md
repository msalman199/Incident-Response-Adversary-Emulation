# 🔬 Memory Forensics with Volatility
### Complete Lab Guide — Incident Response & Digital Forensics

![Memory Forensics](https://img.shields.io/badge/Domain-Memory%20Forensics-darkblue?style=for-the-badge&logo=linux&logoColor=white)
![Volatility](https://img.shields.io/badge/Tool-Volatility%203-orange?style=for-the-badge&logo=python&logoColor=white)
![Platform](https://img.shields.io/badge/Platform-Ubuntu%2020.04-E95420?style=for-the-badge&logo=ubuntu&logoColor=white)
![Level](https://img.shields.io/badge/Level-Intermediate-yellow?style=for-the-badge&logo=bookstack&logoColor=white)
![License](https://img.shields.io/badge/License-Educational-green?style=for-the-badge&logo=open-source-initiative&logoColor=white)

---

## 📋 Table of Contents

- [🎯 Objectives](#-objectives)
- [✅ Prerequisites](#-prerequisites)
- [🖥️ Lab Environment](#️-lab-environment)
- [📦 Task 1 — Environment Setup & Tool Installation](#-task-1--environment-setup--tool-installation)
- [💾 Task 2 — Memory Dump Creation & Preparation](#-task-2--memory-dump-creation--preparation)
- [🔍 Task 3 — Basic Memory Analysis with Volatility](#-task-3--basic-memory-analysis-with-volatility)
- [🚨 Task 4 — Advanced Suspicious Activity Detection](#-task-4--advanced-suspicious-activity-detection)
- [🦠 Task 5 — Malware Artifact Extraction](#-task-5--malware-artifact-extraction)
- [📊 Task 6 — Comprehensive Analysis & Reporting](#-task-6--comprehensive-analysis--reporting)
- [🛡️ Task 7 — Advanced Rootkit Detection](#️-task-7--advanced-rootkit-detection)
- [📝 Task 8 — Final Report Generation](#-task-8--final-report-generation)
- [🔧 Troubleshooting](#-troubleshooting)
- [🏁 Conclusion](#-conclusion)

---

## 🎯 Objectives

By the end of this lab, students will be able to:

| # | Objective |
|---|-----------|
| 1 | Understand the fundamentals of memory forensics and its importance in incident response |
| 2 | Install and configure Volatility framework for memory analysis |
| 3 | Create memory dumps from a running Linux system |
| 4 | Analyze memory dumps to identify suspicious processes and network connections |
| 5 | Detect potential rootkits and malware artifacts in memory |
| 6 | Generate comprehensive forensic reports from memory analysis |
| 7 | Apply memory forensics techniques in real-world incident response scenarios |

---

## ✅ Prerequisites

![Linux](https://img.shields.io/badge/Linux-CLI-FCC624?style=flat-square&logo=linux&logoColor=black)
![OS](https://img.shields.io/badge/OS-Concepts-0078D4?style=flat-square&logo=windows&logoColor=white)
![Security](https://img.shields.io/badge/Cybersecurity-Basics-red?style=flat-square&logo=hackthebox&logoColor=white)
![Malware](https://img.shields.io/badge/Malware-Concepts-8B0000?style=flat-square&logo=virustotal&logoColor=white)

Before starting this lab, students should have:

- Basic understanding of **Linux command line** operations
- Fundamental knowledge of **operating system processes** and memory management
- Basic familiarity with **cybersecurity concepts**
- Understanding of **malware and rootkit** concepts
- **No prior experience with Volatility** is required — this lab covers installation and basic usage

---

## 🖥️ Lab Environment

> 💡 **Al Nafi** provides ready-to-use Linux-based cloud machines for this lab.  
> Simply click **Start Lab** to access your pre-configured environment.

| Component | Specification |
|-----------|---------------|
| 🐧 OS | Ubuntu 20.04 LTS or newer |
| 🐍 Python | 3.8 or higher |
| 🔑 Access | Administrative privileges |
| 🌐 Network | Internet connectivity for tool downloads |

---

## 📦 Task 1 — Environment Setup & Tool Installation

### ✨ Subtask 1.1 — Update System and Install Dependencies

![apt](https://img.shields.io/badge/Package_Manager-APT-E95420?style=flat-square&logo=ubuntu&logoColor=white)
![Python](https://img.shields.io/badge/Python-3.8+-3776AB?style=flat-square&logo=python&logoColor=white)

First, ensure your system is up to date and install necessary dependencies.

```bash
# Update package lists
sudo apt update

# Install required dependencies
sudo apt install -y python3 python3-pip git build-essential python3-dev libssl-dev

# Install additional forensic tools
sudo apt install -y volatility volatility-tools
```

---

### ✨ Subtask 1.2 — Install Volatility 3 (Latest Version)

![Git](https://img.shields.io/badge/Git-Clone-F05032?style=flat-square&logo=git&logoColor=white)
![Volatility](https://img.shields.io/badge/Volatility-3.x-orange?style=flat-square&logo=python&logoColor=white)

While the system package provides Volatility 2, we'll install the latest **Volatility 3** for enhanced capabilities.

```bash
# Create a directory for forensic tools
mkdir ~/forensics-tools
cd ~/forensics-tools

# Clone Volatility 3 repository
git clone https://github.com/volatilityfoundation/volatility3.git

# Navigate to Volatility directory
cd volatility3

# Install Volatility 3 requirements
pip3 install -r requirements.txt

# Make Volatility executable
chmod +x vol.py

# Create symbolic link for easy access
sudo ln -sf $(pwd)/vol.py /usr/local/bin/vol3
```

---

### ✨ Subtask 1.3 — Verify Installation

![Verify](https://img.shields.io/badge/Status-Verify_Install-brightgreen?style=flat-square&logo=checkmarx&logoColor=white)

Confirm that both Volatility versions are properly installed.

```bash
# Test Volatility 2
volatility --info

# Test Volatility 3
vol3 --help

# Check Python version
python3 --version
```

---

## 💾 Task 2 — Memory Dump Creation & Preparation

### ✨ Subtask 2.1 — Create Sample Processes for Analysis

![Process](https://img.shields.io/badge/Activity-Simulation-blueviolet?style=flat-square&logo=processwire&logoColor=white)
![Python](https://img.shields.io/badge/Python-Script-3776AB?style=flat-square&logo=python&logoColor=white)

Before creating a memory dump, let's establish some processes that will be interesting to analyze.

```bash
# Create a directory for our lab work
mkdir ~/memory-forensics-lab
cd ~/memory-forensics-lab

# Start some background processes to make analysis interesting
# Start a simple web server
python3 -m http.server 8080 &

# Start a netcat listener (simulating suspicious network activity)
nc -l -p 9999 &

# Create a script that simulates suspicious activity
cat > suspicious_script.py << 'EOF'
#!/usr/bin/env python3
import time
import os
import socket

def suspicious_activity():
    while True:
        # Simulate file access
        try:
            with open('/etc/passwd', 'r') as f:
                content = f.read()
        except:
            pass
        
        # Simulate network activity
        try:
            s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
            s.settimeout(1)
            s.connect(('127.0.0.1', 8080))
            s.close()
        except:
            pass
        
        time.sleep(5)

if __name__ == "__main__":
    suspicious_activity()
EOF

# Make the script executable and run it in background
chmod +x suspicious_script.py
python3 suspicious_script.py &

# Note the process IDs for later reference
echo "Background processes started. Note these PIDs:"
jobs -l
```

---

### ✨ Subtask 2.2 — Install Memory Acquisition Tools

![LiME](https://img.shields.io/badge/Tool-LiME-darkred?style=flat-square&logo=linux&logoColor=white)
![Kernel](https://img.shields.io/badge/Kernel-Module-555555?style=flat-square&logo=linux&logoColor=white)

Install tools needed to create memory dumps.

```bash
# Install LiME (Linux Memory Extractor)
cd ~/forensics-tools
git clone https://github.com/504ensicsLabs/LiME.git
cd LiME/src

# Get kernel headers for current kernel
sudo apt install -y linux-headers-$(uname -r)

# Compile LiME module
make

# Verify the module was created
ls -la lime-*.ko
```

---

### ✨ Subtask 2.3 — Create Memory Dump

![Dump](https://img.shields.io/badge/Action-Memory_Dump-critical?style=flat-square&logo=databricks&logoColor=white)

Now create a memory dump of the running system.

```bash
# Create directory for memory dumps
mkdir ~/memory-dumps
cd ~/memory-dumps

# Load the LiME module and create memory dump
sudo insmod ~/forensics-tools/LiME/src/lime-$(uname -r).ko "path=./memory-dump.lime format=lime"

# Wait for dump to complete (this may take several minutes)
echo "Memory dump in progress... Please wait."

# Check if dump was created successfully
ls -lh memory-dump.lime

# Remove the LiME module
sudo rmmod lime
```

---

### ✨ Subtask 2.4 — Alternative Memory Dump Method

![Fallback](https://img.shields.io/badge/Fallback-Alternative_Method-gray?style=flat-square&logo=alteryx&logoColor=white)
![AVML](https://img.shields.io/badge/Tool-AVML-0078D4?style=flat-square&logo=microsoft&logoColor=white)

> ⚠️ **Use this if LiME compilation fails**

```bash
# Create a memory dump using /proc/kcore (less ideal but functional)
sudo dd if=/proc/kcore of=./kcore-dump.dd bs=1M count=1024

# Or create a dump using AVML (Another Volatility Memory Loader)
cd ~/forensics-tools
wget https://github.com/microsoft/avml/releases/latest/download/avml
chmod +x avml
sudo ./avml memory-dump-avml.lime
mv memory-dump-avml.lime ~/memory-dumps/
```

---

## 🔍 Task 3 — Basic Memory Analysis with Volatility

### ✨ Subtask 3.1 — Identify Operating System Profile

![Profile](https://img.shields.io/badge/Step-OS_Profile_ID-informational?style=flat-square&logo=linux&logoColor=white)

First, we need to identify the correct profile for our memory dump.

```bash
# Navigate to our working directory
cd ~/memory-dumps

# For Volatility 2 - identify image info
volatility -f memory-dump.lime imageinfo

# For Volatility 3 - check available plugins
vol3 -f memory-dump.lime windows.info 2>/dev/null || echo "Not a Windows dump"
vol3 -f memory-dump.lime linux.banner.Banner
```

---

### ✨ Subtask 3.2 — Extract Basic System Information

![SysInfo](https://img.shields.io/badge/Analysis-System_Info-blue?style=flat-square&logo=gnubash&logoColor=white)

Gather fundamental information about the system when the dump was taken.

```bash
# Get system banner and kernel information
vol3 -f memory-dump.lime linux.banner.Banner

# List running processes
vol3 -f memory-dump.lime linux.pslist.PsList

# Get process tree view
vol3 -f memory-dump.lime linux.pstree.PsTree

# Save process list to file for analysis
vol3 -f memory-dump.lime linux.pslist.PsList > process-list.txt
```

---

### ✨ Subtask 3.3 — Analyze Network Connections

![Network](https://img.shields.io/badge/Analysis-Network_Connections-009688?style=flat-square&logo=wireshark&logoColor=white)

Examine network activity at the time of the dump.

```bash
# List network connections
vol3 -f memory-dump.lime linux.netstat.Netstat

# Save network information
vol3 -f memory-dump.lime linux.netstat.Netstat > network-connections.txt

# Look for our suspicious processes
grep -E "(8080|9999|python)" network-connections.txt
```

---

### ✨ Subtask 3.4 — Examine Loaded Modules

![Modules](https://img.shields.io/badge/Analysis-Kernel_Modules-9C27B0?style=flat-square&logo=linux&logoColor=white)

Check for potentially malicious kernel modules.

```bash
# List loaded kernel modules
vol3 -f memory-dump.lime linux.lsmod.Lsmod

# Save module information
vol3 -f memory-dump.lime linux.lsmod.Lsmod > loaded-modules.txt

# Look for unusual or suspicious modules
cat loaded-modules.txt | grep -v -E "(ext4|usb|input|sound)"
```

---

## 🚨 Task 4 — Advanced Suspicious Activity Detection

### ✨ Subtask 4.1 — Process Analysis and Validation

![ProcessAnalysis](https://img.shields.io/badge/Detection-Process_Analysis-FF5722?style=flat-square&logo=processwire&logoColor=white)

Perform detailed analysis of running processes to identify anomalies.

```bash
# Get detailed process information with command lines
vol3 -f memory-dump.lime linux.pslist.PsList --pid > detailed-processes.txt

# Look for processes with suspicious characteristics
echo "=== Analyzing Suspicious Processes ==="

# Check for processes running from unusual locations
vol3 -f memory-dump.lime linux.pslist.PsList | grep -E "(/tmp|/var/tmp|/dev/shm)"

# Look for processes with no parent (potential rootkits)
vol3 -f memory-dump.lime linux.pslist.PsList | awk '$4 == 0 && $3 != 0 {print}'

# Find our suspicious script
vol3 -f memory-dump.lime linux.pslist.PsList | grep python
```

---

### ✨ Subtask 4.2 — Memory Strings Analysis

![Strings](https://img.shields.io/badge/Analysis-Strings_Extraction-FF9800?style=flat-square&logo=gnu&logoColor=white)

Extract and analyze strings from memory to find indicators of compromise.

```bash
# Extract strings from memory dump (this may take time)
strings memory-dump.lime > memory-strings.txt

# Search for common malware indicators
echo "=== Searching for Malware Indicators ==="

# Look for suspicious URLs or domains
grep -i -E "(http://|https://|ftp://)" memory-strings.txt | head -20

# Search for common attack tools
grep -i -E "(metasploit|meterpreter|payload|exploit)" memory-strings.txt

# Look for suspicious file paths
grep -E "(/tmp/\.|/var/tmp/\.|\.sh|\.py)" memory-strings.txt | head -10

# Search for our suspicious script content
grep -A5 -B5 "suspicious_activity" memory-strings.txt
```

---

### ✨ Subtask 4.3 — File System Analysis

![Filesystem](https://img.shields.io/badge/Analysis-File_System-607D8B?style=flat-square&logo=files&logoColor=white)

Examine file system artifacts in memory.

```bash
# List open files
vol3 -f memory-dump.lime linux.lsof.Lsof > open-files.txt

# Look for suspicious file access patterns
grep -E "(passwd|shadow|sudoers)" open-files.txt

# Check for files in suspicious locations
grep -E "(/tmp|/var/tmp|/dev/shm)" open-files.txt
```

---

### ✨ Subtask 4.4 — Rootkit Detection Techniques

![Rootkit](https://img.shields.io/badge/Detection-Rootkit-8B0000?style=flat-square&logo=virustotal&logoColor=white)
![Script](https://img.shields.io/badge/Script-Bash-4EAA25?style=flat-square&logo=gnubash&logoColor=white)

Apply specific techniques to detect rootkit presence.

```bash
# Create a rootkit detection script
cat > rootkit_detection.sh << 'EOF'
#!/bin/bash

echo "=== ROOTKIT DETECTION ANALYSIS ==="
echo "Memory Dump: $1"
echo "Analysis Date: $(date)"
echo

# Check for hidden processes (compare different process listing methods)
echo "1. Process Hiding Detection:"
vol3 -f "$1" linux.pslist.PsList | wc -l
vol3 -f "$1" linux.pstree.PsTree | wc -l

# Look for suspicious system calls
echo "2. Checking for suspicious system call modifications:"
vol3 -f "$1" linux.check_syscall.Check_syscall 2>/dev/null || echo "Syscall check not available"

# Check for module hiding
echo "3. Module Analysis:"
vol3 -f "$1" linux.lsmod.Lsmod | grep -v -E "(ext4|usb|input|sound|net)" | head -10

# Network connection analysis
echo "4. Suspicious Network Connections:"
vol3 -f "$1" linux.netstat.Netstat | grep -E "(LISTEN|ESTABLISHED)" | grep -v -E "(22|80|443)"

echo "=== Analysis Complete ==="
EOF

chmod +x rootkit_detection.sh
./rootkit_detection.sh memory-dump.lime > rootkit-analysis.txt
```

---

## 🦠 Task 5 — Malware Artifact Extraction

### ✨ Subtask 5.1 — Process Memory Dumping

![MemDump](https://img.shields.io/badge/Extraction-Process_Memory-B71C1C?style=flat-square&logo=databricks&logoColor=white)

Extract memory contents of suspicious processes for further analysis.

```bash
# First, identify PIDs of our suspicious processes
PYTHON_PID=$(vol3 -f memory-dump.lime linux.pslist.PsList | grep "suspicious_script.py" | awk '{print $3}' | head -1)

if [ ! -z "$PYTHON_PID" ]; then
    echo "Found suspicious Python process with PID: $PYTHON_PID"
    
    # Dump process memory
    vol3 -f memory-dump.lime linux.proc.Maps --pid $PYTHON_PID > process-${PYTHON_PID}-maps.txt
    
    # Extract process memory regions
    mkdir -p process-dumps
    vol3 -f memory-dump.lime linux.dump.Dump --pid $PYTHON_PID --output-dir process-dumps/
else
    echo "Suspicious process not found in memory dump"
fi
```

---

### ✨ Subtask 5.2 — Extract Executable Files

![ELF](https://img.shields.io/badge/Extraction-ELF_Binaries-4527A0?style=flat-square&logo=linux&logoColor=white)

Attempt to extract executable files from memory.

```bash
# Create extraction directory
mkdir -p extracted-files

# Extract all executable files from memory
vol3 -f memory-dump.lime linux.elfs.Elfs --output-dir extracted-files/

# List extracted files
echo "=== Extracted Executable Files ==="
ls -la extracted-files/

# Check file types
for file in extracted-files/*; do
    if [ -f "$file" ]; then
        echo "File: $(basename $file)"
        file "$file"
        echo "---"
    fi
done
```

---

### ✨ Subtask 5.3 — Timeline Analysis

![Timeline](https://img.shields.io/badge/Analysis-Timeline-00ACC1?style=flat-square&logo=clockify&logoColor=white)

Create a timeline of system activity.

```bash
# Generate timeline of process creation
echo "=== Process Timeline Analysis ===" > timeline-analysis.txt
echo "Analysis of process start times and relationships" >> timeline-analysis.txt
echo >> timeline-analysis.txt

# Sort processes by start time (if available)
vol3 -f memory-dump.lime linux.pslist.PsList | sort -k5 >> timeline-analysis.txt

# Analyze parent-child relationships
echo >> timeline-analysis.txt
echo "=== Parent-Child Process Relationships ===" >> timeline-analysis.txt
vol3 -f memory-dump.lime linux.pstree.PsTree >> timeline-analysis.txt
```

---

## 📊 Task 6 — Comprehensive Analysis & Reporting

### ✨ Subtask 6.1 — Create Comprehensive Analysis Script

![Automation](https://img.shields.io/badge/Script-Full_Analysis-2E7D32?style=flat-square&logo=gnubash&logoColor=white)

Develop a script that performs complete memory forensics analysis.

```bash
cat > comprehensive_analysis.sh << 'EOF'
#!/bin/bash

DUMP_FILE="$1"
OUTPUT_DIR="analysis-results"

if [ -z "$DUMP_FILE" ]; then
    echo "Usage: $0 <memory-dump-file>"
    exit 1
fi

echo "Starting comprehensive memory forensics analysis..."
echo "Memory Dump: $DUMP_FILE"
echo "Output Directory: $OUTPUT_DIR"

# Create output directory
mkdir -p "$OUTPUT_DIR"

# System Information
echo "1. Extracting system information..."
vol3 -f "$DUMP_FILE" linux.banner.Banner > "$OUTPUT_DIR/01-system-info.txt"

# Process Analysis
echo "2. Analyzing processes..."
vol3 -f "$DUMP_FILE" linux.pslist.PsList > "$OUTPUT_DIR/02-process-list.txt"
vol3 -f "$DUMP_FILE" linux.pstree.PsTree > "$OUTPUT_DIR/03-process-tree.txt"

# Network Analysis
echo "3. Analyzing network connections..."
vol3 -f "$DUMP_FILE" linux.netstat.Netstat > "$OUTPUT_DIR/04-network-connections.txt"

# Module Analysis
echo "4. Analyzing loaded modules..."
vol3 -f "$DUMP_FILE" linux.lsmod.Lsmod > "$OUTPUT_DIR/05-loaded-modules.txt"

# File System Analysis
echo "5. Analyzing open files..."
vol3 -f "$DUMP_FILE" linux.lsof.Lsof > "$OUTPUT_DIR/06-open-files.txt"

# String Analysis
echo "6. Extracting and analyzing strings..."
strings "$DUMP_FILE" | grep -E "(http|ftp|password|admin|root)" | head -100 > "$OUTPUT_DIR/07-suspicious-strings.txt"

# Generate Summary Report
echo "7. Generating summary report..."
cat > "$OUTPUT_DIR/00-analysis-summary.txt" << REPORT
MEMORY FORENSICS ANALYSIS SUMMARY
=================================
Analysis Date: $(date)
Memory Dump: $DUMP_FILE
Analyst: Lab Student

FINDINGS SUMMARY:
1. Total Processes Found: $(wc -l < "$OUTPUT_DIR/02-process-list.txt")
2. Network Connections: $(wc -l < "$OUTPUT_DIR/04-network-connections.txt")
3. Loaded Modules: $(wc -l < "$OUTPUT_DIR/05-loaded-modules.txt")
4. Open Files: $(wc -l < "$OUTPUT_DIR/06-open-files.txt")

SUSPICIOUS INDICATORS:
- Python processes: $(grep -c python "$OUTPUT_DIR/02-process-list.txt")
- Network listeners: $(grep -c LISTEN "$OUTPUT_DIR/04-network-connections.txt")
- Unusual file access: $(grep -c -E "(passwd|shadow)" "$OUTPUT_DIR/06-open-files.txt")

RECOMMENDATIONS:
1. Review all Python processes for malicious activity
2. Investigate network connections on non-standard ports
3. Examine processes accessing sensitive system files
4. Correlate findings with system logs and network monitoring

REPORT

echo "Analysis complete! Results saved in $OUTPUT_DIR/"
echo "Review the 00-analysis-summary.txt file for key findings."
EOF

chmod +x comprehensive_analysis.sh
```

---

### ✨ Subtask 6.2 — Execute Comprehensive Analysis

![Execute](https://img.shields.io/badge/Run-Analysis_Script-1565C0?style=flat-square&logo=gnubash&logoColor=white)

Run the comprehensive analysis script on our memory dump.

```bash
# Execute the comprehensive analysis
./comprehensive_analysis.sh memory-dump.lime

# Review the results
echo "=== ANALYSIS RESULTS ==="
ls -la analysis-results/

# Display the summary report
cat analysis-results/00-analysis-summary.txt
```

---

### ✨ Subtask 6.3 — Validate Findings

![Validate](https://img.shields.io/badge/Step-Validate_Findings-43A047?style=flat-square&logo=checkmarx&logoColor=white)

Cross-reference our analysis with the processes we created earlier.

```bash
# Check if our suspicious activities were detected
echo "=== VALIDATION OF FINDINGS ==="

# Look for our Python script
echo "1. Checking for suspicious Python script:"
grep -i "suspicious_script" analysis-results/02-process-list.txt

# Check for our network listeners
echo "2. Checking for network listeners on ports 8080 and 9999:"
grep -E "(8080|9999)" analysis-results/04-network-connections.txt

# Look for HTTP server process
echo "3. Checking for Python HTTP server:"
grep -E "(http\.server|SimpleHTTP)" analysis-results/02-process-list.txt

# Check for netcat process
echo "4. Checking for netcat listener:"
grep -i "nc" analysis-results/02-process-list.txt
```

---

## 🛡️ Task 7 — Advanced Rootkit Detection

### ✨ Subtask 7.1 — Implement Advanced Detection Techniques

![AdvancedDetect](https://img.shields.io/badge/Detection-Advanced_Rootkit-880E4F?style=flat-square&logo=virustotal&logoColor=white)
![Bash](https://img.shields.io/badge/Script-Bash-4EAA25?style=flat-square&logo=gnubash&logoColor=white)

Create specialized scripts for rootkit detection.

```bash
cat > advanced_rootkit_detection.sh << 'EOF'
#!/bin/bash

DUMP_FILE="$1"
if [ -z "$DUMP_FILE" ]; then
    echo "Usage: $0 <memory-dump-file>"
    exit 1
fi

echo "ADVANCED ROOTKIT DETECTION ANALYSIS"
echo "==================================="
echo "Memory Dump: $DUMP_FILE"
echo "Analysis Time: $(date)"
echo

# 1. Process Hiding Detection
echo "1. PROCESS HIDING DETECTION:"
echo "   Comparing different process enumeration methods..."

# Count processes using different methods
PSLIST_COUNT=$(vol3 -f "$DUMP_FILE" linux.pslist.PsList 2>/dev/null | wc -l)
PSTREE_COUNT=$(vol3 -f "$DUMP_FILE" linux.pstree.PsTree 2>/dev/null | wc -l)

echo "   - PSList count: $PSLIST_COUNT"
echo "   - PSTree count: $PSTREE_COUNT"

if [ "$PSLIST_COUNT" -ne "$PSTREE_COUNT" ]; then
    echo "   WARNING: Process count mismatch detected!"
else
    echo "   Process counts match - no obvious hiding detected"
fi
echo

# 2. Kernel Module Analysis
echo "2. KERNEL MODULE ANALYSIS:"
echo "   Checking for suspicious kernel modules..."

vol3 -f "$DUMP_FILE" linux.lsmod.Lsmod 2>/dev/null | while read line; do
    if echo "$line" | grep -qvE "(ext4|usb|input|sound|net|crypto|kernel|core)"; then
        echo "   Potentially suspicious module: $line"
    fi
done
echo

# 3. System Call Table Analysis
echo "3. SYSTEM CALL ANALYSIS:"
echo "   Checking for system call table modifications..."
vol3 -f "$DUMP_FILE" linux.check_syscall.Check_syscall 2>/dev/null || echo "   System call analysis not available for this kernel"
echo

# 4. Network Hiding Detection
echo "4. NETWORK HIDING DETECTION:"
echo "   Looking for hidden network connections..."

# Check for connections that might be hidden
vol3 -f "$DUMP_FILE" linux.netstat.Netstat 2>/dev/null | grep -E "(UNKNOWN|HIDDEN)" || echo "   No obviously hidden connections found"
echo

# 5. File Hiding Detection
echo "5. FILE HIDING DETECTION:"
echo "   Analyzing file system discrepancies..."

# Look for files that might be hidden
vol3 -f "$DUMP_FILE" linux.lsof.Lsof 2>/dev/null | grep -E "deleted|UNKNOWN" | head -5
echo

echo "ROOTKIT DETECTION ANALYSIS COMPLETE"
echo "Review the above output for potential indicators of rootkit presence."
EOF

chmod +x advanced_rootkit_detection.sh
./advanced_rootkit_detection.sh memory-dump.lime > advanced-rootkit-analysis.txt
```

---

### ✨ Subtask 7.2 — Memory Signature Analysis

![Signature](https://img.shields.io/badge/Detection-Signature_Based-D32F2F?style=flat-square&logo=virustotal&logoColor=white)

Implement signature-based detection for known malware families.

```bash
# Create a simple signature detection script
cat > signature_detection.sh << 'EOF'
#!/bin/bash

DUMP_FILE="$1"
if [ -z "$DUMP_FILE" ]; then
    echo "Usage: $0 <memory-dump-file>"
    exit 1
fi

echo "MEMORY SIGNATURE ANALYSIS"
echo "========================"
echo "Searching for known malware signatures in memory..."
echo

# Extract strings for analysis
echo "Extracting strings from memory dump..."
strings "$DUMP_FILE" > temp_strings.txt

# Common malware indicators
SIGNATURES=(
    "meterpreter"
    "metasploit"
    "payload"
    "shellcode"
    "backdoor"
    "rootkit"
    "keylogger"
    "botnet"
    "trojan"
    "ransomware"
)

echo "Searching for malware signatures:"
for sig in "${SIGNATURES[@]}"; do
    count=$(grep -ci "$sig" temp_strings.txt)
    if [ "$count" -gt 0 ]; then
        echo "  FOUND: $sig ($count occurrences)"
        grep -i "$sig" temp_strings.txt | head -3 | sed 's/^/    /'
    else
        echo "  Not found: $sig"
    fi
done

# Look for suspicious URLs
echo
echo "Suspicious URLs found:"
grep -iE "http://[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+" temp_strings.txt | head -5

# Look for base64 encoded content (common in malware)
echo
echo "Potential base64 encoded content:"
grep -E "[A-Za-z0-9+/]{20,}={0,2}" temp_strings.txt | head -5

# Clean up
rm temp_strings.txt

echo
echo "SIGNATURE ANALYSIS COMPLETE"
EOF

chmod +x signature_detection.sh
./signature_detection.sh memory-dump.lime > signature-analysis.txt
```

---

## 📝 Task 8 — Final Report Generation

### ✨ Subtask 8.1 — Create Executive Summary

![Report](https://img.shields.io/badge/Output-Forensic_Report-546E7A?style=flat-square&logo=readthedocs&logoColor=white)

Generate a professional forensic report.

```bash
cat > generate_final_report.sh << 'EOF'
#!/bin/bash

DUMP_FILE="$1"
CASE_NUMBER="LAB-MF-$(date +%Y%m%d)"

cat > "FORENSIC_REPORT_${CASE_NUMBER}.txt" << REPORT
DIGITAL FORENSIC ANALYSIS REPORT
===============================

Case Number: $CASE_NUMBER
Analysis Date: $(date)
Analyst: Lab Student
Evidence: $DUMP_FILE

EXECUTIVE SUMMARY
================
This report documents the memory forensic analysis performed on a Linux system memory dump. 
The analysis was conducted using Volatility framework to identify potential security incidents,
malware presence, and system compromise indicators.

METHODOLOGY
===========
1. Memory dump acquisition using LiME (Linux Memory Extractor)
2. Analysis using Volatility 3 framework
3. Process, network, and file system artifact examination
4. Rootkit and malware detection techniques
5. String analysis and signature matching

KEY FINDINGS
============
$(cat analysis-results/00-analysis-summary.txt | grep -A 20 "FINDINGS SUMMARY:")

DETAILED ANALYSIS RESULTS
========================

Process Analysis:
- Total processes identified: $(wc -l < analysis-results/02-process-list.txt)
- Suspicious Python processes detected
- Network service processes identified

Network Analysis:
- Active network connections documented
- Listening services on non-standard ports identified
- Potential command and control communications analyzed

System Integrity:
- Kernel module analysis completed
- System call integrity verified
- File system access patterns examined

INDICATORS OF COMPROMISE (IOCs)
==============================
1. Suspicious Python script execution detected
2. Network listeners on ports 8080 and 9999
3. Unusual file access patterns to system files
4. Background processes with network connectivity

RECOMMENDATIONS
===============
1. Immediate Actions:
   - Isolate the affected system from network
   - Preserve all log files for correlation
   - Conduct full system scan with updated antivirus

2. Investigation Actions:
   - Analyze network traffic logs for the timeframe
   - Review system authentication logs
   - Check for lateral movement indicators

3. Remediation Actions:
   - Remove identified malicious processes
   - Update system security patches
   - Implement enhanced monitoring

CONCLUSION
==========
The memory forensic analysis revealed evidence of suspicious activity on the target system.
Multiple indicators suggest potential compromise, including unauthorized network services
and suspicious script execution. Immediate containment and further investigation are recommended.

APPENDICES
==========
- Appendix A: Complete process listing
- Appendix B: Network connection details
- Appendix C: File system analysis
- Appendix D: String analysis results

Report prepared by: Lab Student
Date: $(date)
REPORT

echo "Final forensic report generated: FORENSIC_REPORT_${CASE_NUMBER}.txt"
EOF

chmod +x generate_final_report.sh
./generate_final_report.sh memory-dump.lime
```

---

### ✨ Subtask 8.2 — Clean Up and Archive Results

![Archive](https://img.shields.io/badge/Final-Archive_Results-455A64?style=flat-square&logo=7zip&logoColor=white)

Organize all analysis results for archival.

```bash
# Create final archive of all results
mkdir -p final-results
cp -r analysis-results final-results/
cp *.txt final-results/
cp FORENSIC_REPORT_*.txt final-results/

# Create archive
tar -czf "memory-forensics-analysis-$(date +%Y%m%d).tar.gz" final-results/

echo "=== LAB COMPLETION SUMMARY ==="
echo "Analysis files created:"
ls -la final-results/

echo
echo "Archive created: memory-forensics-analysis-$(date +%Y%m%d).tar.gz"
echo "Size: $(du -h memory-forensics-analysis-*.tar.gz | cut -f1)"

# Display final summary
echo
echo "=== FINAL ANALYSIS SUMMARY ==="
echo "Memory dump analyzed: $(ls -lh memory-dump.lime | awk '{print $5}')"
echo "Total analysis files: $(find final-results/ -type f | wc -l)"
echo "Suspicious processes found: $(grep -c python final-results/analysis-results/02-process-list.txt)"
echo "Network connections analyzed: $(wc -l < final-results/analysis-results/04-network-connections.txt)"
```

---

## 🔧 Troubleshooting

### ⚠️ Issue 1 — LiME Module Compilation Fails

![Error](https://img.shields.io/badge/Error-Kernel_Headers-red?style=flat-square&logo=linux&logoColor=white)

**Problem:** Kernel headers not matching or compilation errors.

**Solution:**

```bash
# Check kernel version
uname -r

# Install exact matching headers
sudo apt install linux-headers-$(uname -r)

# If still failing, use alternative method
sudo dd if=/proc/kcore of=./memory-dump.dd bs=1M count=512
```

---

### ⚠️ Issue 2 — Volatility Profile Not Found

![Error](https://img.shields.io/badge/Error-Profile_Missing-orange?style=flat-square&logo=volatility&logoColor=white)

**Problem:** Volatility cannot determine the correct profile.

**Solution:**

```bash
# For Volatility 3, profiles are auto-detected
# If issues persist, try specifying the symbol table
vol3 -f memory-dump.lime -s /usr/lib/volatility3/symbols/ linux.banner.Banner
```

---

### ⚠️ Issue 3 — Memory Dump Too Large

![Error](https://img.shields.io/badge/Error-File_Size-yellow?style=flat-square&logo=harddisk&logoColor=white)

**Problem:** Memory dump file is too large to process efficiently.

**Solution:**

```bash
# Create a smaller dump for testing
sudo dd if=/proc/kcore of=./small-dump.dd bs=1M count=256

# Or use compression
gzip memory-dump.lime
vol3 -f memory-dump.lime.gz linux.pslist.PsList
```

---

### ⚠️ Issue 4 — Permission Denied Errors

![Error](https://img.shields.io/badge/Error-Permissions-critical?style=flat-square&logo=lock&logoColor=white)

**Problem:** Cannot access memory or create dumps.

**Solution:**

```bash
# Ensure you have sudo privileges
sudo -v

# Check if running as root is required
sudo su -
# Then run the commands
```

---

## 🏁 Conclusion

### 🧠 Technical Skills Acquired

![Volatility](https://img.shields.io/badge/✔-Volatility_Framework-orange?style=flat-square)
![Memory](https://img.shields.io/badge/✔-Memory_Dumps-blue?style=flat-square)
![Analysis](https://img.shields.io/badge/✔-Artifact_Analysis-green?style=flat-square)
![Rootkit](https://img.shields.io/badge/✔-Rootkit_Detection-red?style=flat-square)
![Reporting](https://img.shields.io/badge/✔-Forensic_Reporting-purple?style=flat-square)

| Skill | Description |
|-------|-------------|
| 🔧 Installation | Installed and configured the Volatility framework |
| 💾 Acquisition | Created memory dumps from a live Linux system using LiME |
| 🔍 Analysis | Systematic analysis of processes, network connections, and file systems |
| 🛡️ Detection | Advanced rootkit detection techniques |
| 🦠 Malware | Signature-based malware analysis |
| 📝 Reporting | Generated professional forensic reports |

---

### 🌍 Real-World Applications

Memory forensics is crucial in modern incident response and digital investigations. The techniques learned in this lab directly apply to:

- 🔥 **Incident Response** — scenarios where disk-based evidence may be compromised
- 🕵️ **APT Investigations** — Advanced persistent threat (APT) investigations
- 🦠 **Malware Analysis** — Malware analysis and reverse engineering
- 🛡️ **Rootkit Detection** — System compromise assessment
- ⚖️ **Legal Investigations** — Requiring memory-based evidence

---

### 💡 Why This Matters

> Memory forensics provides unique insights that traditional disk forensics **cannot** offer.  
> Memory contains the current state of system execution, including **decrypted data**, **network connections**, and **running processes** that may not be visible through other analysis methods.

This makes memory forensics an essential skill for cybersecurity professionals working in:

![IR](https://img.shields.io/badge/Role-Incident_Response-red?style=for-the-badge&logo=firefighters&logoColor=white)
![TH](https://img.shields.io/badge/Role-Threat_Hunting-orange?style=for-the-badge&logo=target&logoColor=white)
![DFIR](https://img.shields.io/badge/Role-Digital_Forensics-blue?style=for-the-badge&logo=forensicscience&logoColor=white)

---

<div align="center">

**🔬 Memory Forensics Lab — Complete**

![Made With](https://img.shields.io/badge/Made%20with-❤️%20%26%20Volatility-blueviolet?style=for-the-badge)
![Platform](https://img.shields.io/badge/Al%20Nafi-Cybersecurity%20Labs-0A66C2?style=for-the-badge&logo=academia&logoColor=white)

*"The key to great security is knowing what's running in memory."*

</div>
