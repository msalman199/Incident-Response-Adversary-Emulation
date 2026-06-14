# 🕵️ Web Reconnaissance with Maltego

<div align="center">

# 🌐 Visual OSINT & Infrastructure Mapping with Maltego

### Discover • Correlate • Visualize • Investigate

![Linux](https://img.shields.io/badge/Linux-Ubuntu-E95420?style=for-the-badge&logo=ubuntu)
![Maltego](https://img.shields.io/badge/Maltego-OSINT-blue?style=for-the-badge)
![OSINT](https://img.shields.io/badge/OSINT-Reconnaissance-success?style=for-the-badge)
![Python](https://img.shields.io/badge/Python-Automation-yellow?style=for-the-badge&logo=python)
![DNSrecon](https://img.shields.io/badge/DNSrecon-DNS%20Analysis-red?style=for-the-badge)
![Recon-ng](https://img.shields.io/badge/Recon--ng-Framework-orange?style=for-the-badge)
![Sublist3r](https://img.shields.io/badge/Sublist3r-Subdomain%20Discovery-purple?style=for-the-badge)
![Threat Intelligence](https://img.shields.io/badge/Threat-Intelligence-darkgreen?style=for-the-badge)

</div>

---

# 📖 Overview

Maltego is one of the most powerful Open Source Intelligence (OSINT) and link analysis platforms used by cybersecurity professionals, threat intelligence analysts, incident responders, and red team operators.

In this lab, students will learn how to:

- Install and configure Maltego Community Edition
- Integrate Maltego with OSINT tools
- Discover domains, emails, IPs, and infrastructure
- Create visual intelligence graphs
- Correlate reconnaissance findings
- Build automation scripts
- Generate professional reconnaissance reports

---

# 🎯 Learning Objectives

By the end of this lab, students will be able to:

✅ Install Maltego Community Edition

✅ Configure OSINT tool integrations

✅ Perform web reconnaissance using transforms

✅ Discover domains and subdomains

✅ Enumerate email addresses

✅ Analyze infrastructure relationships

✅ Create visual intelligence maps

✅ Generate incident response reports

✅ Build custom Maltego transforms

✅ Automate reconnaissance workflows

---

# 🛠️ Technologies Used

| Technology | Purpose |
|------------|----------|
| Maltego CE | Visual Intelligence |
| Ubuntu Linux | Operating System |
| Python 3 | Automation |
| theHarvester | Email Discovery |
| Sublist3r | Subdomain Enumeration |
| DNSrecon | DNS Intelligence |
| Recon-ng | Recon Framework |
| Shodan | Internet Intelligence |
| Java | Maltego Runtime |

---

# 🏗️ Lab Architecture

```text
                         INTERNET
                             │
                             │
       ┌──────────────────────────────────────┐
       │               Maltego                │
       └──────────────────────────────────────┘
                             │
       ┌──────────────┬──────────────┬──────────────┐
       │              │              │              │
       ▼              ▼              ▼              ▼
 theHarvester     Sublist3r      DNSrecon      Recon-ng
       │              │              │              │
       └──────────────┴──────────────┴──────────────┘
                             │
                             ▼
                 Visual Intelligence Graph
                             │
                             ▼
                   Incident Response Report
```

---

# 📋 Prerequisites

Before starting this lab:

- Linux command-line proficiency
- Networking fundamentals
- DNS knowledge
- OSINT basics
- Cybersecurity reconnaissance concepts
- Understanding of domains and IP addresses

---

# 🚀 Task 1: Setting Up Maltego and OSINT Tools

## 🔹 Subtask 1.1: Install Maltego Community Edition

### Update System

```bash
sudo apt update && sudo apt upgrade -y
```

### Install Java

```bash
sudo apt install default-jre default-jdk -y
```

### Verify Installation

```bash
java -version
```

### Download Maltego

```bash
cd ~/Downloads

wget https://maltego-downloads.s3.us-east-2.amazonaws.com/linux/Maltego.v4.5.0.deb
```

### Install Maltego

```bash
sudo dpkg -i Maltego.v4.5.0.deb
```

### Fix Dependencies

```bash
sudo apt-get install -f
```

---

## 🔹 Subtask 1.2: Install Supporting OSINT Tools

### Install theHarvester

```bash
sudo apt install theharvester -y
```

### Install Sublist3r

```bash
git clone https://github.com/aboul3la/Sublist3r.git

cd Sublist3r

sudo pip3 install -r requirements.txt
```

### Install Recon-ng

```bash
git clone https://github.com/lanmaster53/recon-ng.git

cd recon-ng

sudo pip3 install -r REQUIREMENTS
```

### Install Shodan CLI

```bash
sudo pip3 install shodan
```

### Install DNSrecon

```bash
sudo apt install dnsrecon -y
```

### Return Home

```bash
cd ~
```

---

## 🔹 Subtask 1.3: Configure Maltego

Launch Maltego:

```bash
maltego &
```

### Manual Setup

1. Register Free Account
2. Choose Community Edition
3. Verify Email
4. Login
5. Accept Terms
6. Complete Setup Wizard

---

# 🌐 Task 2: Basic Reconnaissance with Maltego

## 🔹 Subtask 2.1: First Investigation Graph

### Create Graph

1. Click **New Graph**
2. Drag **Domain Entity**
3. Enter:

```text
example-target.com
```

### Run DNS Transform

```text
All Transforms → To DNS Name [DNS]
```

Observe newly discovered entities.

---

## 🔹 Subtask 2.2: Expand Domain Intelligence

Run:

```text
To IP Address [DNS]
```

Then:

```text
To Location [City, Country]
```

And:

```text
To Netblock [Whois]
```

---

## 🔹 Subtask 2.3: Discover Email Addresses

### Collect Emails

```bash
theharvester \
-d example-target.com \
-l 100 \
-b google,bing,yahoo \
> harvester_results.txt
```

### View Results

```bash
cat harvester_results.txt
```

### Import Into Maltego

Create Email entities and apply:

```text
To Person [HIBP]

To Domain [Email]
```

---

# 🔍 Task 3: Advanced OSINT Integration

## 🔹 Subtask 3.1: Subdomain Enumeration

### Run Sublist3r

```bash
cd ~/Sublist3r

python3 sublist3r.py \
-d example-target.com \
-o subdomains.txt
```

### View Results

```bash
cat subdomains.txt
```

### Format Results

```bash
echo "Discovered Subdomains:" > maltego_subdomains.txt

cat subdomains.txt >> maltego_subdomains.txt
```

---

## 🔹 Subtask 3.2: DNS Reconnaissance

### Standard Scan

```bash
dnsrecon \
-d example-target.com \
-t std \
> dns_recon_results.txt
```

### Zone Transfer Attempt

```bash
dnsrecon \
-d example-target.com \
-t axfr \
>> dns_recon_results.txt
```

### View Results

```bash
cat dns_recon_results.txt
```

### Extract Records

```bash
grep "A " dns_recon_results.txt > a_records.txt

grep "MX " dns_recon_results.txt > mx_records.txt

grep "NS " dns_recon_results.txt > ns_records.txt
```

---

## 🔹 Subtask 3.3: Recon-ng Framework

### Start Recon-ng

```bash
cd ~/recon-ng

python3 recon-ng
```

### Commands

```text
marketplace install all

modules load recon/domains-hosts/hackertarget

options set SOURCE example-target.com

run

show hosts

exit
```

---

# 🤖 Task 4: Recon-ng Automation Script

## 📄 recon_automation.py

```python
#!/usr/bin/env python3

import subprocess
import sys

def run_recon_ng(domain):

    commands = [
        "marketplace install hackertarget",
        "modules load recon/domains-hosts/hackertarget",
        f"options set SOURCE {domain}",
        "run",
        "show hosts",
        "exit"
    ]

    with open('recon_commands.txt', 'w') as f:
        for cmd in commands:
            f.write(cmd + '\n')

    subprocess.run(
        ['python3', 'recon-ng', '-r', 'recon_commands.txt']
    )

if __name__ == "__main__":
    domain = sys.argv[1] if len(sys.argv) > 1 else "example-target.com"
    run_recon_ng(domain)
```

### Execute

```bash
chmod +x recon_automation.py

python3 recon_automation.py example-target.com
```

---

# 📧 Task 5: Email Relationship Analysis

## 📄 email_analysis.py

```python
#!/usr/bin/env python3

import re
from collections import defaultdict

def analyze_emails(email_file):

    with open(email_file, 'r') as f:
        content = f.read()

    emails = re.findall(
        r'\b[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Z|a-z]{2,}\b',
        content
    )

    domain_groups = defaultdict(list)

    for email in emails:
        domain = email.split('@')[1]
        domain_groups[domain].append(email)

    print("Email Analysis Results")
    print("=" * 50)

    for domain, email_list in domain_groups.items():

        print(f"\nDomain: {domain}")
        print(f"Email Count: {len(email_list)}")

        for email in email_list:
            print(f" - {email}")

    return domain_groups

if __name__ == "__main__":
    analyze_emails('harvester_results.txt')
```

### Run

```bash
python3 email_analysis.py
```

---

# 🌍 Task 6: Infrastructure Analysis

## 📄 network_analysis.py

```python
#!/usr/bin/env python3

import subprocess

def analyze_network_range(ip_address):

    try:

        result = subprocess.run(
            ['whois', ip_address],
            capture_output=True,
            text=True
        )

        network_info = {}

        for line in result.stdout.split('\n'):

            if 'NetRange:' in line:
                network_info['range'] = line.split(':')[1].strip()

            elif 'Organization:' in line:
                network_info['org'] = line.split(':')[1].strip()

            elif 'Country:' in line:
                network_info['country'] = line.split(':')[1].strip()

        return network_info

    except Exception as e:
        print(e)
        return {}

def main():

    ips = ["8.8.8.8", "1.1.1.1"]

    for ip in ips:

        print(f"\nAnalyzing {ip}")

        info = analyze_network_range(ip)

        for k, v in info.items():
            print(f"{k}: {v}")

if __name__ == "__main__":
    main()
```

### Execute

```bash
python3 network_analysis.py
```

---

# ⚡ Task 7: Custom Maltego Transform

## 📄 custom_subdomain_transform.py

```python
#!/usr/bin/env python3

import sys
import subprocess
import xml.etree.ElementTree as ET

def create_entity(entity_type, value):

    entity = ET.Element(
        "Entity",
        Type=entity_type
    )

    entity_value = ET.SubElement(
        entity,
        "Value"
    )

    entity_value.text = value

    return entity

def main():

    if len(sys.argv) != 2:
        sys.exit(1)

    domain = sys.argv[1]

    response = ET.Element("MaltegoMessage")

    transform = ET.SubElement(
        response,
        "MaltegoTransformResponseMessage"
    )

    entities = ET.SubElement(
        transform,
        "Entities"
    )

    entity = create_entity(
        "maltego.Domain",
        domain
    )

    entities.append(entity)

    print(
        ET.tostring(
            response,
            encoding='unicode'
        )
    )

if __name__ == "__main__":
    main()
```

---

# 📊 Task 8: Reporting

## 📄 maltego_report_generator.py

```python
#!/usr/bin/env python3

import csv
from datetime import datetime

def generate_html_report(csv_file, output_file):

    rows = ""

    with open(csv_file, 'r') as f:

        reader = csv.reader(f)

        for row in reader:

            rows += f"""
            <tr>
                <td>{row}</td>
            </tr>
            """

    html = f"""
    <html>
    <body>

    <h1>Reconnaissance Report</h1>

    <p>Generated:
    {datetime.now()}</p>

    <table border="1">
    {rows}
    </table>

    </body>
    </html>
    """

    with open(output_file, 'w') as f:
        f.write(html)

if __name__ == "__main__":
    generate_html_report(
        "maltego_export.csv",
        "recon_report.html"
    )
```

### Generate Report

```bash
chmod +x maltego_report_generator.py

python3 maltego_report_generator.py
```

---

# 🧪 Task 9: Verification Script

## 📄 verify_integration.py

```python
#!/usr/bin/env python3

import subprocess

tests = [
    "java -version",
    "theharvester --help",
    "dnsrecon --help"
]

for cmd in tests:

    print(f"Testing: {cmd}")

    result = subprocess.run(
        cmd,
        shell=True
    )

    if result.returncode == 0:
        print("PASS\n")
    else:
        print("FAIL\n")
```

### Run

```bash
python3 verify_integration.py
```

---

# 🚀 Task 10: Performance Testing

## 📄 performance_test.py

```python
#!/usr/bin/env python3

import subprocess
import time

commands = [
    "nslookup example.com",
    "dnsrecon -d example.com -t std"
]

for cmd in commands:

    start = time.time()

    subprocess.run(
        cmd,
        shell=True
    )

    end = time.time()

    print(
        f"{cmd} : {end-start:.2f} sec"
    )
```

### Execute

```bash
python3 performance_test.py
```

---

# 📈 Expected Outcomes

After completing this lab you will:

✅ Install Maltego CE

✅ Integrate Multiple OSINT Tools

✅ Discover Domains & Subdomains

✅ Enumerate Email Addresses

✅ Build Intelligence Graphs

✅ Correlate Infrastructure

✅ Create Custom Transforms

✅ Generate Reports

✅ Automate Reconnaissance

---

# 🎓 Skills Gained

- OSINT Collection
- Digital Reconnaissance
- Visual Intelligence Analysis
- Infrastructure Mapping
- Threat Intelligence
- Relationship Analysis
- Automation Development
- Incident Response Investigation
- Adversary Emulation Support

---

# 💼 Career Relevance

This lab prepares students for:

- SOC Analyst
- Threat Intelligence Analyst
- Incident Responder
- Threat Hunter
- Red Team Operator
- Cybersecurity Analyst
- OSINT Researcher
- Security Consultant

---

# 🏁 Conclusion

In this lab, we successfully:

✅ Installed Maltego Community Edition

✅ Integrated theHarvester, Sublist3r, DNSrecon, Recon-ng and Shodan

✅ Performed comprehensive reconnaissance

✅ Built visual intelligence graphs

✅ Developed custom automation scripts

✅ Generated professional reconnaissance reports

✅ Applied OSINT techniques used in real-world threat intelligence and incident response operations

The skills gained from this lab form a strong foundation for advanced cyber threat intelligence, digital investigations, red teaming, adversary emulation, and incident response.

---

<div align="center">

# 🔎 Discover • Correlate • Visualize • Investigate

### Built for OSINT • Threat Intelligence • Incident Response

⭐ Star this repository if you found it useful!

</div>
