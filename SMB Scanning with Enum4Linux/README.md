# 🔍 SMB Scanning with Enum4Linux

![Linux](https://img.shields.io/badge/Linux-Ubuntu-E95420?style=for-the-badge\&logo=ubuntu)
![Enum4Linux](https://img.shields.io/badge/Enum4Linux-SMB%20Enumeration-blue?style=for-the-badge)
![Python](https://img.shields.io/badge/Python-3.x-3776AB?style=for-the-badge\&logo=python)
![Samba](https://img.shields.io/badge/Samba-SMB%2FCIFS-green?style=for-the-badge)
![Cybersecurity](https://img.shields.io/badge/Cybersecurity-Enumeration-red?style=for-the-badge)
![AlNafi](https://img.shields.io/badge/AlNafi-Cloud%20Lab-purple?style=for-the-badge)

---

# 📖 Overview

This lab introduces **SMB (Server Message Block) Enumeration** using **Enum4Linux**, one of the most widely used tools for gathering information from SMB services.

Students will learn how to:

* Enumerate SMB users, groups, and shares
* Identify system and operating system information
* Automate SMB assessments using Python
* Analyze enumeration findings
* Detect security weaknesses
* Apply SMB enumeration during Incident Response and Adversary Emulation engagements

---

# 🎯 Objectives

By the end of this lab, you will be able to:

✅ Understand SMB enumeration fundamentals

✅ Use Enum4Linux for information gathering

✅ Enumerate users, groups, shares, and OS information

✅ Automate SMB assessments with Python

✅ Analyze enumeration results

✅ Apply SMB techniques in real-world cybersecurity operations

---

# 📋 Prerequisites

Before starting:

* Linux command-line knowledge
* Basic networking concepts
* Python fundamentals
* Understanding of SMB/CIFS protocol
* Familiarity with penetration testing methodologies

---

# 🖥️ Lab Environment

Al Nafi Cloud Machine provides:

* Ubuntu Linux
* Root access
* Enum4Linux
* Python 3
* Samba
* Networking utilities

No additional installation is required.

---

# 🚀 Task 1: SMB Enumeration with Enum4Linux

---

## 🔹 Subtask 1.1 – Verify Enum4Linux Installation

```bash
enum4linux --help
```

---

## 🔹 Subtask 1.2 – Configure Local SMB Service

### Install Samba

```bash
sudo apt update
sudo apt install samba samba-common-bin -y
```

### Create Test Share

```bash
sudo mkdir -p /srv/samba/testshare
sudo chmod 755 /srv/samba/testshare
```

### Create Users

```bash
sudo useradd -m testuser1
sudo useradd -m testuser2

echo "testuser1:password123" | sudo chpasswd
echo "testuser2:password456" | sudo chpasswd
```

### Add Samba Users

```bash
echo -e "password123\npassword123" | sudo smbpasswd -a testuser1

echo -e "password456\npassword456" | sudo smbpasswd -a testuser2
```

### Configure Samba

```bash
sudo tee /etc/samba/smb.conf > /dev/null << 'EOF'
[global]
   workgroup = WORKGROUP
   server string = Test SMB Server
   security = user
   map to guest = bad user
   dns proxy = no

[testshare]
   path = /srv/samba/testshare
   browsable = yes
   writable = yes
   guest ok = no
   valid users = testuser1, testuser2
EOF
```

### Start Samba

```bash
sudo systemctl restart smbd
sudo systemctl enable smbd
sudo systemctl status smbd
```

---

## 🔹 Subtask 1.3 – Basic SMB Enumeration

### Full Enumeration

```bash
enum4linux -a 127.0.0.1
```

Information discovered:

* Workgroup
* Domain Information
* Sessions
* Shares
* Users
* Groups
* Password Policies

---

## 🔹 Subtask 1.4 – Targeted Enumeration

### Enumerate Users

```bash
enum4linux -U 127.0.0.1
```

### RID Cycling

```bash
enum4linux -r 127.0.0.1
```

### Enumerate Groups

```bash
enum4linux -G 127.0.0.1
```

### Enumerate Shares

```bash
enum4linux -S 127.0.0.1
```

---

# 🛠️ Code File 1 – SMB_enum_comprehensive.sh

```bash
#!/bin/bash
# SMB_enum_comprehensive.sh

TARGET=$1
OUTPUT_DIR="smb_enum_$(date +%Y%m%d_%H%M%S)"

if [ -z "$TARGET" ]; then
    echo "Usage: $0 <target_ip>"
    exit 1
fi

mkdir -p $OUTPUT_DIR

echo "[+] Starting comprehensive SMB enumeration of $TARGET"

enum4linux -a $TARGET > $OUTPUT_DIR/basic_enum.txt 2>&1
enum4linux -U $TARGET > $OUTPUT_DIR/users.txt 2>&1
enum4linux -G $TARGET > $OUTPUT_DIR/groups.txt 2>&1
enum4linux -S $TARGET > $OUTPUT_DIR/shares.txt 2>&1
enum4linux -P $TARGET > $OUTPUT_DIR/password_policy.txt 2>&1
enum4linux -o $TARGET > $OUTPUT_DIR/os_info.txt 2>&1

echo "[+] Enumeration complete."
```

### Execute

```bash
chmod +x SMB_enum_comprehensive.sh

./SMB_enum_comprehensive.sh 127.0.0.1
```

---

# 🐍 Code File 2 – analyze_smb_results.py

```python
#!/usr/bin/env python3

import os
import re
import sys
from datetime import datetime

def analyze_users(file_path):
    users = []

    try:
        with open(file_path, 'r') as f:
            content = f.read()

            user_matches = re.findall(
                r'user:\[([^\]]+)\]',
                content
            )

            users.extend(user_matches)

            rid_matches = re.findall(
                r'S-1-5-21-\d+-\d+-\d+-(\d+)\s+(\w+)',
                content
            )

            for rid, username in rid_matches:
                if username not in users:
                    users.append(username)

    except FileNotFoundError:
        pass

    return users

def analyze_shares(file_path):
    shares = []

    try:
        with open(file_path,'r') as f:
            content=f.read()

            share_matches=re.findall(
                r'Sharename\s+Type\s+Comment\s*\n\s*-+\s*\n(.*?)(?=\n\n|\Z)',
                content,
                re.DOTALL
            )

            for match in share_matches:
                lines=match.strip().split('\n')

                for line in lines:
                    if line.strip():
                        parts=line.split()

                        if parts:
                            shares.append(parts[0])

    except FileNotFoundError:
        pass

    return shares

def main():

    if len(sys.argv)!=2:
        print("Usage: python3 analyze_smb_results.py <results_directory>")
        sys.exit(1)

    results_dir=sys.argv[1]

    users=analyze_users(
        os.path.join(results_dir,'users.txt')
    )

    shares=analyze_shares(
        os.path.join(results_dir,'shares.txt')
    )

    print("="*60)
    print("SMB ENUMERATION ANALYSIS REPORT")
    print("="*60)

    print("\nUsers Found:")
    for user in users:
        print(f" - {user}")

    print("\nShares Found:")
    for share in shares:
        print(f" - {share}")

if __name__=="__main__":
    main()
```

### Run

```bash
chmod +x analyze_smb_results.py

python3 analyze_smb_results.py smb_enum_*
```

---

# 🚀 Task 2 – Automated SMB Enumeration

---

# 🐍 Code File 3 – smb_network_scanner.py

```python
#!/usr/bin/env python3

import subprocess
import threading
import argparse
import ipaddress
import os
import time

from concurrent.futures import (
    ThreadPoolExecutor,
    as_completed
)

class SMBScanner:

    def __init__(self,max_threads=10):
        self.max_threads=max_threads
        self.results={}
        self.lock=threading.Lock()

    def check_smb_port(self,target):

        import socket

        try:
            sock=socket.socket(
                socket.AF_INET,
                socket.SOCK_STREAM
            )

            sock.settimeout(3)

            result=sock.connect_ex(
                (str(target),445)
            )

            sock.close()

            return result==0

        except:
            return False

    def run_enum4linux(self,target):

        output_dir=f"smb_scan_{target}_{int(time.time())}"

        os.makedirs(output_dir,exist_ok=True)

        cmd=[
            "enum4linux",
            "-a",
            str(target)
        ]

        result=subprocess.run(
            cmd,
            capture_output=True,
            text=True
        )

        outfile=os.path.join(
            output_dir,
            "enum4linux_output.txt"
        )

        with open(outfile,"w") as f:
            f.write(result.stdout)

        return {
            "target":str(target),
            "success":True,
            "output_file":outfile
        }

    def scan_target(self,target):

        if not self.check_smb_port(target):
            return

        result=self.run_enum4linux(target)

        with self.lock:
            self.results[str(target)]=result

    def scan_network(self,targets):

        with ThreadPoolExecutor(
            max_workers=self.max_threads
        ) as executor:

            futures=[
                executor.submit(
                    self.scan_target,
                    target
                )
                for target in targets
            ]

            for future in as_completed(futures):
                future.result()

def parse_targets(target_input):

    targets=[]

    if os.path.isfile(target_input):

        with open(target_input) as f:
            for line in f:
                line=line.strip()

                if line:
                    targets.append(line)

    else:

        try:
            network=ipaddress.ip_network(
                target_input,
                strict=False
            )

            targets=[
                str(ip)
                for ip in network.hosts()
            ]

        except:
            targets=[target_input]

    return targets

def main():

    parser=argparse.ArgumentParser()

    parser.add_argument("targets")

    args=parser.parse_args()

    targets=parse_targets(args.targets)

    scanner=SMBScanner()

    scanner.scan_network(targets)

if __name__=="__main__":
    main()
```

---

## Create Target List

```bash
cat > targets.txt << EOF
127.0.0.1
EOF
```

---

## Run Scanner

```bash
python3 smb_network_scanner.py 127.0.0.1
```

OR

```bash
python3 smb_network_scanner.py targets.txt
```

---

# 🐍 Code File 4 – advanced_smb_analyzer.py

```python
#!/usr/bin/env python3

import subprocess
import json
import re

from datetime import datetime

class AdvancedSMBAnalyzer:

    def extract_users(self,data):

        patterns=[
            r'user:\[([^\]]+)\]'
        ]

        users=[]

        for pattern in patterns:
            users.extend(
                re.findall(
                    pattern,
                    data,
                    re.IGNORECASE
                )
            )

        return list(set(users))

    def extract_os_info(self,data):

        os_info={}

        patterns={
            "os":r'OS=\[([^\]]+)\]',
            "server":r'Server=\[([^\]]+)\]',
            "domain":r'Domain=\[([^\]]+)\]'
        }

        for key,pattern in patterns.items():

            match=re.search(pattern,data)

            if match:
                os_info[key]=match.group(1)

        return os_info

    def run_enumeration(self,target):

        result=subprocess.run(
            ["enum4linux","-a",target],
            capture_output=True,
            text=True
        )

        return result.stdout

    def analyze_target(self,target):

        output=self.run_enumeration(target)

        analysis={
            "target":target,
            "timestamp":datetime.now().isoformat(),
            "users":self.extract_users(output),
            "os_info":self.extract_os_info(output)
        }

        return analysis

def main():

    analyzer=AdvancedSMBAnalyzer()

    result=analyzer.analyze_target(
        "127.0.0.1"
    )

    with open(
        "detailed_smb_report.json",
        "w"
    ) as f:
        json.dump(result,f,indent=4)

if __name__=="__main__":
    main()
```

### Run

```bash
chmod +x advanced_smb_analyzer.py

python3 advanced_smb_analyzer.py
```

---

# ✅ Verification

### Check Enum4Linux

```bash
enum4linux --help | head -5
```

### Verify Python Modules

```bash
python3 -c "import subprocess,threading,json; print('All modules available')"
```

### Verify Samba

```bash
sudo systemctl status smbd
```

### Test Enumeration

```bash
enum4linux -U 127.0.0.1
```

---

# 🧪 Troubleshooting

## ❌ Enum4Linux Missing

```bash
sudo apt update
sudo apt install enum4linux -y
```

---

## ❌ Samba Not Starting

```bash
sudo testparm

sudo journalctl -u smbd -f

sudo systemctl restart smbd
```

---

## ❌ Permission Errors

```bash
sudo chmod 755 /srv/samba/testshare

sudo chown nobody:nogroup /srv/samba/testshare
```

---

## ❌ Python Errors

```bash
python3 --version

pip3 install ipaddress
```

---

# 🔐 Security Considerations

* Obtain authorization before scanning
* Respect organizational policies
* Avoid excessive network traffic
* Monitor logs responsibly
* Follow responsible disclosure practices
* Document all enumeration activities

---

# 📊 Expected Outcomes

After completing this lab, you will be able to:

✅ Enumerate SMB services

✅ Discover users and groups

✅ Identify SMB shares

✅ Automate enumeration with Python

✅ Generate detailed reports

✅ Assess SMB security risks

✅ Apply SMB enumeration in Incident Response and Adversary Emulation

---

# 🎓 Conclusion

This lab provided practical experience with SMB enumeration using Enum4Linux and Python automation. You learned how to gather critical information from SMB services, automate large-scale assessments, identify security risks, and generate professional reports.

These skills are essential for:

* Incident Response
* Threat Hunting
* Red Team Operations
* Adversary Emulation
* Vulnerability Assessments
* Enterprise Security Auditing

🚀 Continue expanding this project by integrating Nmap, CrackMapExec, Impacket, BloodHound, and Active Directory enumeration techniques for advanced enterprise assessments.
