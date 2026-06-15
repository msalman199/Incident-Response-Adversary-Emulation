# 🛡️ Privilege Escalation with Mimikatz 

![Security](https://img.shields.io/badge/Category-Cybersecurity-red?style=for-the-badge&logo=shield&logoColor=white)
![Level](https://img.shields.io/badge/Level-Intermediate-orange?style=for-the-badge&logo=bookstack&logoColor=white)
![Platform](https://img.shields.io/badge/Platform-Linux%20%2F%20Wine-blue?style=for-the-badge&logo=linux&logoColor=white)
![Python](https://img.shields.io/badge/Python-3.8+-yellow?style=for-the-badge&logo=python&logoColor=white)
![PowerShell](https://img.shields.io/badge/PowerShell-Core-5391FE?style=for-the-badge&logo=powershell&logoColor=white)
![Wine](https://img.shields.io/badge/Wine-6.0+-A80000?style=for-the-badge&logo=wine&logoColor=white)
![Windows](https://img.shields.io/badge/Target-Windows-0078D6?style=for-the-badge&logo=windows&logoColor=white)
![License](https://img.shields.io/badge/Use-Educational%20Only-green?style=for-the-badge&logo=academia&logoColor=white)

> ⚠️ **Ethical Reminder:** All techniques in this lab must only be used in **authorized penetration testing engagements** or **controlled lab environments**. Unauthorized credential harvesting is **illegal and unethical**.

---

## 📋 Table of Contents

- [🎯 Objectives](#-objectives)
- [📚 Prerequisites](#-prerequisites)
- [🖥️ Lab Environment Setup](#️-lab-environment-setup)
- [🔧 Task 1 — Environment Preparation & Mimikatz Setup](#-task-1--environment-preparation--mimikatz-setup)
- [🔑 Task 2 — Credential Extraction with Mimikatz](#-task-2--credential-extraction-with-mimikatz)
- [⚙️ Task 3 — PowerShell Automation for Privilege Escalation Checks](#️-task-3--powershell-automation-for-privilege-escalation-checks)
- [🔒 Task 4 — Defensive Measures Implementation](#-task-4--defensive-measures-implementation)
- [✅ Expected Outcomes](#-expected-outcomes)
- [🛠️ Troubleshooting Tips](#️-troubleshooting-tips)
- [📌 Conclusion & Key Takeaways](#-conclusion--key-takeaways)
- [🚀 Next Steps](#-next-steps)

---

## 🎯 Objectives

By the end of this lab, students will be able to:

- 🧠 Understand Windows credential storage mechanisms and vulnerabilities
- 🔍 Use Mimikatz for credential extraction in controlled environments
- 🤖 Implement automated privilege escalation checks using PowerShell
- 🔬 Analyze security configurations that enable credential theft
- 🛡️ Apply defensive measures against credential harvesting attacks

---

## 📚 Prerequisites

| Requirement | Description |
|---|---|
| 🖥️ OS Knowledge | Basic Windows operating system knowledge |
| 💻 Scripting | Familiarity with PowerShell scripting |
| 🔐 Auth Protocols | Understanding of Windows authentication (NTLM, Kerberos) |
| 🐍 Programming | Basic Python programming skills |
| ⚖️ Ethics | Knowledge of ethical hacking principles |

---

## 🖥️ Lab Environment Setup

> 🌐 **Cloud-Based Environment:** This lab uses Al Nafi's pre-configured Linux machines with Wine and simulation tools. Click **Start Lab** to access your environment — no VM setup required.

> 📝 **Important:** This lab simulates Windows-based attacks in a controlled Linux environment for **educational purposes only**.

---

## 🔧 Task 1 — Environment Preparation & Mimikatz Setup

### ✅ Step 1.1 — Verify Lab Tools

Check that all required tools are installed:

```bash
# Verify Wine installation
wine --version

# Check PowerShell Core
pwsh --version

# Verify Python
python3 --version

# List lab tools
ls -la /opt/lab-tools/
```

---

### 📁 Step 1.2 — Create Working Directory

Set up your workspace:

```bash
# Create lab directory
mkdir -p ~/lab16-mimikatz
cd ~/lab16-mimikatz

# Download Mimikatz (pre-configured version)
wget https://github.com/gentilkiwi/mimikatz/releases/download/2.2.0-20220919/mimikatz_trunk.zip

# Extract archive
unzip mimikatz_trunk.zip
cd mimikatz_trunk
```

---

### 🍷 Step 1.3 — Configure Wine Environment

```bash
# Initialize Wine
winecfg

# Set Windows 10 compatibility
winetricks win10

# Install required components
winetricks vcrun2019 dotnet48
```

---

### 🐍 Step 1.4 — Create Simulated Credential Environment

**File:** `simulate_credentials.py`

```python
#!/usr/bin/env python3
# File: simulate_credentials.py

import os
import json

def generate_simulated_credentials():
    """
    Generate simulated Windows credential structures for testing.
    
    TODO: Create credential dictionary with username, domain, NTLM hash, and password
    TODO: Add at least 3 different user accounts
    TODO: Include various account types (admin, user, service)
    
    Returns:
        list: List of credential dictionaries
    """
    credentials = []
    
    # TODO: Implement credential generation
    # Example structure:
    # {
    #     'username': 'administrator',
    #     'domain': 'CORPORATE',
    #     'ntlm_hash': '31d6cfe0d16ae931b73c59d7e0c089c0',
    #     'password': 'P@ssw0rd123'
    # }
    
    return credentials


def create_memory_dump(credentials):
    """
    Create simulated LSASS memory dump file.
    
    Args:
        credentials: List of credential dictionaries
    
    TODO: Write credentials to binary file format
    TODO: Simulate LSASS process memory structure
    TODO: Save as 'simulated_lsass.dmp'
    """
    pass


if __name__ == "__main__":
    creds = generate_simulated_credentials()
    create_memory_dump(creds)
    print("[+] Simulated environment created")
```

---

## 🔑 Task 2 — Credential Extraction with Mimikatz

### 🖱️ Step 2.1 — Explore Mimikatz Modules

Run Mimikatz interactively:

```bash
# Launch Mimikatz
wine mimikatz.exe

# Inside Mimikatz console:
# mimikatz # help
# mimikatz # privilege::debug
# mimikatz # sekurlsa::help
# mimikatz # exit
```

---

### 🤖 Step 2.2 — Create Extraction Script

**File:** `extract_credentials.py`

```python
#!/usr/bin/env python3
# File: extract_credentials.py

import subprocess
import re
import json
from datetime import datetime


class CredentialExtractor:
    def __init__(self):
        self.results = {
            'timestamp': datetime.now().isoformat(),
            'credentials': [],
            'hashes': []
        }

    def extract_logon_passwords(self):
        """
        Extract logon passwords using Mimikatz.
        
        TODO: Execute Mimikatz with sekurlsa::logonpasswords command
        TODO: Parse output for usernames, domains, and passwords
        TODO: Store results in self.results dictionary
        """
        pass

    def parse_mimikatz_output(self, output):
        """
        Parse Mimikatz output and extract credential information.
        
        Args:
            output: Raw Mimikatz command output
        
        TODO: Use regex to extract username, domain, password, NTLM hash
        TODO: Handle multiple credential entries
        TODO: Return structured credential data
        
        Returns:
            list: Parsed credentials
        """
        credentials = []

        # TODO: Implement parsing logic
        # Look for patterns like:
        # * Username : administrator
        # * Domain   : CORPORATE
        # * Password : P@ssw0rd123
        # * NTLM     : 31d6cfe0d16ae931b73c59d7e0c089c0

        return credentials

    def extract_sam_hashes(self):
        """
        Extract SAM database password hashes.
        
        TODO: Execute Mimikatz lsadump::sam command
        TODO: Parse hash output format
        TODO: Store hashes with RID and username
        """
        pass

    def generate_report(self):
        """
        Generate comprehensive extraction report.
        
        TODO: Format results for display
        TODO: Save to JSON file
        TODO: Print summary statistics
        """
        pass


def main():
    extractor = CredentialExtractor()

    # TODO: Call extraction methods
    # TODO: Generate and display report

    pass


if __name__ == "__main__":
    main()
```

---

### 🔍 Step 2.3 — Analyze Password Security

**File:** `analyze_passwords.py`

```python
#!/usr/bin/env python3
# File: analyze_passwords.py

import json
import re
import hashlib


def analyze_password_strength(password):
    """
    Analyze password complexity and strength.
    
    Args:
        password: Password string to analyze
    
    TODO: Check length (minimum 8, recommended 12+)
    TODO: Verify character variety (upper, lower, digits, special)
    TODO: Check for common patterns and dictionary words
    TODO: Calculate strength score (0-10)
    
    Returns:
        dict: Analysis results with score and recommendations
    """
    analysis = {
        'score': 0,
        'strength': 'Weak',
        'feedback': []
    }

    # TODO: Implement strength analysis

    return analysis


def check_hash_vulnerability(ntlm_hash):
    """
    Check if NTLM hash is commonly cracked or weak.
    
    Args:
        ntlm_hash: NTLM hash string
    
    TODO: Compare against known weak hash database
    TODO: Check for empty password hash
    TODO: Assess crackability risk
    
    Returns:
        dict: Vulnerability assessment
    """
    pass


def generate_security_report(credentials):
    """
    Generate comprehensive security report.
    
    Args:
        credentials: List of extracted credentials
    
    TODO: Analyze all passwords and hashes
    TODO: Identify high-risk accounts
    TODO: Provide remediation recommendations
    """
    pass


if __name__ == "__main__":
    # TODO: Load extraction results
    # TODO: Perform analysis
    # TODO: Display report
    pass
```

---

## ⚙️ Task 3 — PowerShell Automation for Privilege Escalation Checks

### 📝 Step 3.1 — Create System Enumeration Script

**File:** `privilege_check.ps1`

```powershell
# File: privilege_check.ps1

param(
    [switch]$Detailed,
    [switch]$Export,
    [string]$OutputPath = "results.json"
)

$Results = @{
    Timestamp      = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    SystemInfo     = @{}
    SecurityChecks = @{}
    Vulnerabilities = @()
}

function Get-SystemInformation {
    <#
    .SYNOPSIS
    Gather system information for privilege escalation assessment.
    
    .DESCRIPTION
    TODO: Collect OS version, architecture, domain membership
    TODO: Get current user and privilege level
    TODO: Check if running with elevated privileges
    #>

    # TODO: Implement system enumeration
}

function Get-UserPrivileges {
    <#
    .SYNOPSIS
    Enumerate user privileges and group memberships.
    
    .DESCRIPTION
    TODO: List current user's groups
    TODO: Check for administrative privileges
    TODO: Identify service accounts
    #>

    # TODO: Implement user enumeration
}

function Test-SecurityConfiguration {
    <#
    .SYNOPSIS
    Check security configurations relevant to credential theft.
    
    .DESCRIPTION
    TODO: Check UAC status
    TODO: Verify Credential Guard status
    TODO: Check LSA Protection
    TODO: Verify WDigest configuration
    TODO: Check LAPS installation
    #>

    # TODO: Implement security checks
}

function Get-VulnerableProcesses {
    <#
    .SYNOPSIS
    Identify processes running with high privileges.
    
    .DESCRIPTION
    TODO: List SYSTEM processes
    TODO: Identify LSASS process
    TODO: Check for unprotected high-privilege processes
    #>

    # TODO: Implement process enumeration
}

function Get-PrivilegeEscalationVectors {
    <#
    .SYNOPSIS
    Identify potential privilege escalation vectors.
    
    .DESCRIPTION
    TODO: Analyze security configuration weaknesses
    TODO: Identify vulnerable services
    TODO: Check for weak permissions
    TODO: Generate risk assessment
    #>

    # TODO: Implement vector identification
}

function Export-Results {
    <#
    .SYNOPSIS
    Export results to JSON file.
    
    .DESCRIPTION
    TODO: Convert results to JSON
    TODO: Save to specified output path
    #>

    # TODO: Implement export functionality
}

# Main execution
function Main {
    Write-Host "Privilege Escalation Assessment Tool" -ForegroundColor Cyan

    # TODO: Call all enumeration functions
    # TODO: Generate comprehensive report
    # TODO: Export results if requested
}

Main
```

---

### ▶️ Step 3.2 — Run Automated Assessment

Execute the PowerShell script:

```bash
# Run with PowerShell Core
pwsh -File privilege_check.ps1 -Export -OutputPath "assessment_results.json"

# View results
cat assessment_results.json | python3 -m json.tool
```

---

## 🔒 Task 4 — Defensive Measures Implementation

### 🛡️ Step 4.1 — Create Security Hardening Script

**File:** `implement_defenses.py`

```python
#!/usr/bin/env python3
# File: implement_defenses.py

import subprocess
import json


class SecurityHardening:
    def __init__(self):
        self.recommendations = []
        self.implemented = []

    def disable_wdigest(self):
        """
        Disable WDigest authentication to prevent plaintext password storage.
        
        TODO: Check current WDigest status
        TODO: Modify registry to disable WDigest
        TODO: Verify changes
        TODO: Log implementation status
        """
        pass

    def enable_lsa_protection(self):
        """
        Enable LSA Protection to prevent LSASS memory dumps.
        
        TODO: Check if LSA Protection is supported
        TODO: Enable RunAsPPL registry key
        TODO: Verify configuration
        TODO: Note reboot requirement
        """
        pass

    def configure_credential_guard(self):
        """
        Configure Credential Guard for virtualization-based security.
        
        TODO: Check Windows version compatibility
        TODO: Verify hardware requirements (TPM, UEFI)
        TODO: Enable Credential Guard via Group Policy
        TODO: Document configuration steps
        """
        pass

    def implement_laps(self):
        """
        Provide guidance for LAPS implementation.
        
        TODO: Check if LAPS is installed
        TODO: Provide installation instructions
        TODO: Document configuration requirements
        TODO: Explain password rotation policy
        """
        pass

    def configure_audit_policies(self):
        """
        Configure audit policies for credential access monitoring.
        
        TODO: Enable credential validation auditing
        TODO: Configure logon/logoff event logging
        TODO: Set up sensitive privilege use auditing
        TODO: Document SIEM integration points
        """
        pass

    def generate_hardening_report(self):
        """
        Generate comprehensive hardening report.
        
        TODO: List all implemented measures
        TODO: Provide remaining recommendations
        TODO: Include verification steps
        TODO: Save report to file
        """
        pass


def main():
    hardening = SecurityHardening()

    # TODO: Implement each hardening measure
    # TODO: Generate final report
    # TODO: Display summary

    pass


if __name__ == "__main__":
    main()
```

---

### 👁️ Step 4.2 — Create Monitoring Script

**File:** `monitor_credential_access.py`

```python
#!/usr/bin/env python3
# File: monitor_credential_access.py

import time
import json
from datetime import datetime


class CredentialAccessMonitor:
    def __init__(self):
        self.alerts = []
        self.baseline = {}

    def establish_baseline(self):
        """
        Establish baseline for normal credential access patterns.
        
        TODO: Record normal LSASS memory usage
        TODO: Document typical authentication patterns
        TODO: Identify legitimate administrative tools
        """
        pass

    def monitor_lsass_access(self):
        """
        Monitor for suspicious LSASS process access.
        
        TODO: Check for unusual process handles to LSASS
        TODO: Detect memory dump attempts
        TODO: Alert on suspicious access patterns
        """
        pass

    def detect_mimikatz_indicators(self):
        """
        Detect indicators of Mimikatz execution.
        
        TODO: Check for Mimikatz process names
        TODO: Monitor for sekurlsa module usage
        TODO: Detect privilege::debug attempts
        """
        pass

    def analyze_authentication_logs(self):
        """
        Analyze Windows authentication logs for anomalies.
        
        TODO: Parse Security event log
        TODO: Identify unusual logon patterns
        TODO: Detect credential validation anomalies
        """
        pass

    def generate_alert(self, alert_type, details):
        """
        Generate security alert for suspicious activity.
        
        Args:
            alert_type: Type of security alert
            details: Alert details and context
        
        TODO: Format alert message
        TODO: Log to file and console
        TODO: Integrate with SIEM if available
        """
        pass


def main():
    monitor = CredentialAccessMonitor()

    # TODO: Establish baseline
    # TODO: Start monitoring loop
    # TODO: Generate alerts for suspicious activity

    pass


if __name__ == "__main__":
    main()
```

---

## ✅ Expected Outcomes

After completing this lab, you should have:

| # | Deliverable |
|---|---|
| 1️⃣ | Functional credential extraction scripts using Mimikatz simulation |
| 2️⃣ | Automated PowerShell privilege escalation assessment tools |
| 3️⃣ | Password security analysis capabilities |
| 4️⃣ | Security hardening implementation scripts |
| 5️⃣ | Credential access monitoring tools |
| 6️⃣ | Comprehensive understanding of Windows credential vulnerabilities |
| 7️⃣ | Knowledge of defensive measures against credential theft |

---

## 🛠️ Troubleshooting Tips

### 🍷 Wine Compatibility Issues

```bash
# Ensure Wine version 6.0 or higher is installed
wine --version

# Run winecfg and set Windows 10 compatibility mode
winecfg

# Install required dependencies
winetricks vcrun2019 dotnet48
```

### 💠 PowerShell Script Execution

```bash
# Use PowerShell Core (pwsh) instead of Windows PowerShell
pwsh --version

# Check execution policy
pwsh -ExecutionPolicy Bypass -File script.ps1

# Verify script syntax
pwsh -File script.ps1 -WhatIf
```

### 🐍 Python Script Errors

```bash
# Verify Python 3.8+ is installed
python3 --version

# Install required modules
pip3 install -r requirements.txt

# Fix file permissions
chmod +x script.py
```

### 🔧 Mimikatz Simulation Issues

- Ensure simulated credential files are created **before** running extraction scripts
- Verify Wine environment is properly configured with `winecfg`
- Double-check that all paths are correct inside your scripts

---

## 📌 Conclusion & Key Takeaways

This lab provided hands-on experience with Windows privilege escalation techniques using Mimikatz in a controlled environment.

| 🔑 Key Concept | 📖 Summary |
|---|---|
| 🧠 LSASS Memory | Windows stores credentials in the LSASS process memory |
| ⚔️ Mimikatz Attack | Mimikatz exploits LSASS to extract plaintext passwords and hashes |
| ⚠️ Root Causes | WDigest, missing LSA Protection, and absent Credential Guard enable attacks |
| 🛡️ Defenses | Disable WDigest, enable LSA Protection, implement Credential Guard & LAPS |
| 📊 Monitoring | Continuous audit logging is essential for detecting credential theft |

---

## 🚀 Next Steps

- [ ] 🔐 Practice implementing all defensive measures in test environments
- [ ] 📖 Study Windows authentication protocols (NTLM, Kerberos) in depth
- [ ] 🎟️ Learn about Kerberos ticket attacks (Golden Ticket, Silver Ticket)
- [ ] 🛡️ Explore additional credential protection mechanisms
- [ ] 🚨 Develop incident response procedures for credential compromise scenarios

---

## 📂 File Structure

```
lab16-mimikatz/
├── 📄 README.md                        ← This file
├── 🐍 simulate_credentials.py          ← Task 1.4 — Simulated credential environment
├── 🐍 extract_credentials.py           ← Task 2.2 — Credential extraction tool
├── 🐍 analyze_passwords.py             ← Task 2.3 — Password security analyzer
├── 💠 privilege_check.ps1              ← Task 3.1 — PowerShell assessment script
├── 🐍 implement_defenses.py            ← Task 4.1 — Security hardening script
└── 🐍 monitor_credential_access.py     ← Task 4.2 — Credential access monitor
```

---

<div align="center">

![Made with](https://img.shields.io/badge/Made%20with-❤️%20for%20Learning-blueviolet?style=for-the-badge)
![Al Nafi](https://img.shields.io/badge/Platform-Al%20Nafi-0a0a0a?style=for-the-badge)
![Ethical Hacking](https://img.shields.io/badge/Domain-Ethical%20Hacking-critical?style=for-the-badge&logo=hackthebox&logoColor=white)

> 🔒 *"Security is not a product, but a process."* — Bruce Schneier

</div>
