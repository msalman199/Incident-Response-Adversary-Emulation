# 🔎 Open Source Intelligence (OSINT) with theHarvester

<div align="center">

# 🌐 Email & Subdomain Enumeration using theHarvester

### Discover • Enumerate • Analyze • Report

![Linux](https://img.shields.io/badge/Linux-Ubuntu-E95420?style=for-the-badge\&logo=ubuntu)
![OSINT](https://img.shields.io/badge/OSINT-Intelligence-blue?style=for-the-badge)
![theHarvester](https://img.shields.io/badge/theHarvester-Reconnaissance-red?style=for-the-badge)
![Python](https://img.shields.io/badge/Python-Automation-yellow?style=for-the-badge\&logo=python)
![DNS](https://img.shields.io/badge/DNS-Enumeration-success?style=for-the-badge)
![Threat Intelligence](https://img.shields.io/badge/Threat-Intelligence-orange?style=for-the-badge)
![Cyber Security](https://img.shields.io/badge/Cyber-Security-darkgreen?style=for-the-badge)

</div>

---

# 📖 Overview

Open-Source Intelligence (OSINT) is the process of collecting publicly available information from websites, search engines, certificate transparency logs, DNS databases, social media platforms, and other public sources.

In this lab, students will learn how to use **theHarvester** to gather intelligence about domains, collect email addresses, enumerate subdomains, automate reconnaissance workflows, and generate professional reports.

---

# 🎯 Learning Objectives

By the end of this lab, students will be able to:

✅ Understand OSINT fundamentals

✅ Install and configure theHarvester

✅ Gather emails and subdomains

✅ Use multiple intelligence sources

✅ Automate reconnaissance workflows

✅ Generate HTML, JSON, and CSV reports

✅ Apply OSINT to Incident Response

✅ Perform Adversary Emulation Reconnaissance

✅ Understand Legal & Ethical Boundaries

---

# 🛠️ Technologies Used

| Technology   | Purpose                  |
| ------------ | ------------------------ |
| Ubuntu Linux | Operating System         |
| theHarvester | OSINT Collection         |
| Python 3     | Automation               |
| Git          | Repository Management    |
| DNSDumpster  | Subdomain Discovery      |
| CRT.sh       | Certificate Transparency |
| VirusTotal   | Threat Intelligence      |
| LinkedIn     | Employee Enumeration     |
| Twitter      | Social Intelligence      |

---

# 🏗️ Lab Architecture

```text
                   INTERNET
                       │
                       │
        ┌─────────────────────────────┐
        │        theHarvester         │
        └─────────────────────────────┘
                       │
      ┌────────────────┼────────────────┐
      │                │                │
      ▼                ▼                ▼
 Search Engines   DNS Sources    Social Media
 (Google/Bing)   (CRT.sh/DNS)   (LinkedIn/X)
      │                │                │
      └────────────────┼────────────────┘
                       ▼
               Intelligence Data
                       │
                       ▼
               Python Processing
                       │
                       ▼
         HTML • CSV • JSON Reports
```

---

# 📋 Prerequisites

Before beginning this lab:

* Linux Command-Line Skills
* Networking Fundamentals
* DNS & Subdomain Knowledge
* Python Basics
* Cybersecurity Fundamentals
* Familiarity with Nano/Vim

---

# 🚀 Task 1: Installing and Configuring theHarvester

## 🔹 Update System

```bash
sudo apt update

sudo apt install python3 python3-pip git -y

sudo apt install python3-requests python3-beautifulsoup4 -y
```

---

## 🔹 Install theHarvester

```bash
cd ~

git clone https://github.com/laramies/theHarvester.git

cd theHarvester

pip3 install -r requirements.txt

chmod +x theHarvester.py
```

---

## 🔹 Verify Installation

```bash
python3 theHarvester.py -h

python3 theHarvester.py -h | grep -A 20 "engines"
```

Expected:

```text
theHarvester Help Menu
Available Search Engines
```

---

# 🌐 Task 2: Basic OSINT Gathering

## 📧 Email Enumeration

### Single Source

```bash
python3 theHarvester.py -d example.com -l 100 -b google
```

### Multiple Sources

```bash
python3 theHarvester.py -d example.com -l 100 -b google,bing,yahoo
```

### Save Results

```bash
python3 theHarvester.py -d example.com -l 100 -b google,bing -f example_emails
```

---

## 🌍 Subdomain Enumeration

### DNSDumpster

```bash
python3 theHarvester.py -d example.com -l 200 -b dnsdumpster
```

### Multiple Sources

```bash
python3 theHarvester.py -d example.com -l 200 -b dnsdumpster,crtsh,virustotal
```

### Save Results

```bash
python3 theHarvester.py -d example.com -l 200 -b dnsdumpster,crtsh -f example_subdomains
```

---

## 🔎 Comprehensive Reconnaissance

```bash
python3 theHarvester.py -d example.com -l 300 -b all -f comprehensive_scan
```

---

```bash
python3 theHarvester.py \
-d example.com \
-l 200 \
-b google,bing,dnsdumpster,crtsh,virustotal \
-f balanced_scan
```

---

# ⚡ Task 3: Advanced theHarvester Techniques

## 🔑 Configure API Keys

```bash
mkdir -p ~/.theHarvester
```

Create API key configuration:

```yaml
apikeys:
  shodan: your_shodan_api_key_here
  virustotal: your_virustotal_api_key_here
  hunter: your_hunter_api_key_here
```

Save as:

```bash
~/.theHarvester/api-keys.yaml
```

---

## 🌐 Passive DNS Reconnaissance

```bash
python3 theHarvester.py -d example.com -l 150 -b passivetotal
```

---

```bash
python3 theHarvester.py -d example.com -l 150 -b crtsh,certspotter
```

---

## 👥 Social Media Enumeration

### LinkedIn

```bash
python3 theHarvester.py -d example.com -l 100 -b linkedin
```

### Twitter/X

```bash
python3 theHarvester.py -d example.com -l 100 -b twitter
```

---

# 🤖 Task 4: Automation with Python

## 📄 harvester_automation.py

Features:

* Automated Scanning
* HTML Report Generation
* Timestamped Results
* Multi-Source Collection
* Report Storage

### Create Script

```bash
nano harvester_automation.py
```

Paste the complete code provided in the lab instructions.

Make executable:

```bash
chmod +x harvester_automation.py
```

Run:

```bash
python3 harvester_automation.py example.com
```

---

## 📊 Generated Report

Produces:

```text
example.com_report_TIMESTAMP.html
```

Contains:

* Scan Information
* Target Domain
* Collection Sources
* Raw Findings

---

# 🔥 Task 5: Advanced Data Processing

## 📄 advanced_processor.py

Features:

✅ Email Extraction

✅ Subdomain Enumeration

✅ URL Extraction

✅ CSV Reporting

✅ JSON Reporting

✅ Statistics Generation

---

### Create Script

```bash
nano advanced_processor.py
```

Paste the complete Python code from the lab instructions.

---

### Make Executable

```bash
chmod +x advanced_processor.py
```

---

### Execute

```bash
python3 advanced_processor.py example.com
```

---

### Generated Reports

```text
emails_example.com_TIMESTAMP.csv

subdomains_example.com_TIMESTAMP.csv

comprehensive_report_example.com_TIMESTAMP.json
```

---

# 🚨 Task 6: Incident Response Scenario

Create workspace:

```bash
mkdir incident_response_lab

cd incident_response_lab
```

---

Run intelligence collection:

```bash
python3 ../theHarvester.py \
-d example.com \
-l 500 \
-b all \
-f incident_analysis
```

---

Generate reports:

```bash
python3 ../advanced_processor.py example.com
```

---

# 🎭 Task 7: Adversary Emulation Exercise

Create directory:

```bash
mkdir adversary_emulation

cd adversary_emulation
```

---

## Phase 1: Reconnaissance

```bash
python3 ../theHarvester.py \
-d example.com \
-l 100 \
-b google,bing \
-f phase1_recon
```

---

## Phase 2: Enumeration

```bash
python3 ../theHarvester.py \
-d example.com \
-l 300 \
-b dnsdumpster,crtsh,virustotal \
-f phase2_enum
```

---

## Phase 3: Social Engineering Preparation

```bash
python3 ../theHarvester.py \
-d example.com \
-l 200 \
-b linkedin,twitter \
-f phase3_social
```

---

# 📈 Task 8: Manual Data Analysis

## Analyze Emails

```bash
grep -i "@" *.txt | sort | uniq > unique_emails.txt
```

---

## Analyze Subdomains

```bash
grep -E "([a-zA-Z0-9-]+\.)+[a-zA-Z]{2,}" *.txt \
| sort | uniq > unique_subdomains.txt
```

---

## Count Results

```bash
echo "Email addresses found: $(wc -l < unique_emails.txt)"

echo "Subdomains found: $(wc -l < unique_subdomains.txt)"
```

---

# 📊 Task 9: Visual Reporting

## 📄 visualize_results.py

Features:

* Email Domain Distribution
* Top Subdomains
* Text-Based Charts
* Summary Statistics

---

### Create Script

```bash
nano visualize_results.py
```

Paste the provided Python visualization code.

---

### Run Visualization

```bash
chmod +x visualize_results.py
```

---

```bash
python3 visualize_results.py \
comprehensive_report_example.com_*.json
```

---

### Example Output

```text
Email Domain Distribution
-------------------------
example.com ███████ (7)
support.com ████ (4)

Total Subdomains Found: 12
```

---

# ⚖️ Task 10: Security & Legal Considerations

## Create Legal Checklist

```bash
nano osint_legal_checklist.txt
```

Checklist:

```text
□ Obtain Authorization

□ Respect Terms of Service

□ Follow GDPR Requirements

□ Collect Public Information Only

□ Maintain Documentation

□ Respect Rate Limits

□ Avoid Restricted Systems
```

---

# ⏳ Task 11: Rate Limiting

## 📄 rate_limited_harvest.py

Purpose:

* Ethical Scanning
* Reduced Request Rate
* Prevent Service Abuse

---

Run:

```bash
python3 rate_limited_harvest.py \
example.com \
google,bing
```

---

Features:

```python
time.sleep(5)
```

between scans.

---

# 🛠️ Troubleshooting

## ❌ Installation Problems

```bash
pip3 install --user theHarvester

pip3 install theHarvester
```

---

## ❌ Missing Dependencies

```bash
pip3 install requests beautifulsoup4 plotly
```

---

## ❌ Permission Errors

```bash
chmod +x theHarvester.py

chmod +x *.py
```

---

## ❌ Connectivity Issues

```bash
ping -c 4 google.com
```

---

```bash
nslookup example.com
```

---

```bash
curl -I https://www.google.com
```

---

# ✅ Lab Verification

## Verify Installation

```bash
python3 theHarvester.py -h | head -10
```

---

## Basic Test

```bash
python3 theHarvester.py \
-d example.com \
-l 10 \
-b google
```

---

## Automation Test

```bash
python3 harvester_automation.py example.com
```

---

## Verify Reports

```bash
ls -la *.html *.json *.csv
```

---

## Advanced Processor Test

```bash
python3 advanced_processor.py example.com
```

---

# 📂 Expected Deliverables

After completing this lab you should have:

✅ Email Lists

✅ Subdomain Lists

✅ HTML Reports

✅ JSON Reports

✅ CSV Reports

✅ Automation Scripts

✅ OSINT Findings

✅ Adversary Emulation Results

---

# 🎓 Skills Gained

Students completing this lab will understand:

* Open Source Intelligence Collection
* Domain Enumeration
* Email Harvesting
* Certificate Transparency Analysis
* Passive DNS Reconnaissance
* Social Media Intelligence
* Automation Development
* Threat Intelligence Gathering
* Incident Response Reconnaissance
* Adversary Emulation Techniques

---

# 💼 Career Relevance

This lab prepares learners for:

* Threat Intelligence Analyst
* SOC Analyst
* Incident Responder
* Penetration Tester
* Red Team Operator
* OSINT Researcher
* Security Analyst
* Threat Hunter

---

# 🏁 Conclusion

In this lab, we successfully deployed and utilized **theHarvester** for Open-Source Intelligence (OSINT) gathering and automation.

### Key Achievements

✅ Installed and Configured theHarvester

✅ Enumerated Emails and Subdomains

✅ Automated Reconnaissance Tasks

✅ Generated HTML, CSV, and JSON Reports

✅ Conducted Incident Response Reconnaissance

✅ Performed Adversary Emulation Exercises

✅ Implemented Ethical Scanning Controls

✅ Applied Legal and Compliance Best Practices

The techniques learned in this lab provide a strong foundation for modern OSINT operations, threat intelligence gathering, incident response investigations, and adversary emulation exercises.

---

<div align="center">

# 🔎 Discover • Enumerate • Analyze • Report

### Built for OSINT, Threat Intelligence & Incident Response

⭐ Star this repository if you found it useful!

</div>
