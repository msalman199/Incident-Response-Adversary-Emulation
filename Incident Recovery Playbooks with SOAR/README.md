# 🛡️ Incident Recovery Playbooks with SOAR 

![Security](https://img.shields.io/badge/Category-Cybersecurity-red?style=for-the-badge&logo=shield&logoColor=white)
![Level](https://img.shields.io/badge/Level-Intermediate-orange?style=for-the-badge&logo=bookstack&logoColor=white)
![Platform](https://img.shields.io/badge/Platform-Ubuntu%2022.04-blue?style=for-the-badge&logo=ubuntu&logoColor=white)
![Docker](https://img.shields.io/badge/Docker-Compose-2496ED?style=for-the-badge&logo=docker&logoColor=white)
![Python](https://img.shields.io/badge/Python-3.10+-yellow?style=for-the-badge&logo=python&logoColor=white)
![TheHive](https://img.shields.io/badge/TheHive-4.x-orange?style=for-the-badge&logo=data:image/svg+xml;base64,&logoColor=white)
![Cortex](https://img.shields.io/badge/Cortex-3.x-blueviolet?style=for-the-badge&logoColor=white)
![Elasticsearch](https://img.shields.io/badge/Elasticsearch-7.17-005571?style=for-the-badge&logo=elasticsearch&logoColor=white)
![SOAR](https://img.shields.io/badge/SOAR-Automation-green?style=for-the-badge&logo=automationstudio&logoColor=white)
![License](https://img.shields.io/badge/Use-Educational%20Only-green?style=for-the-badge&logo=academia&logoColor=white)

> 🔵 **Blue Team Lab:** This lab focuses entirely on **defensive security** — building automated incident response playbooks using open-source SOAR platforms to detect, contain, and remediate security incidents faster and more consistently.

---

## 📋 Table of Contents

- [🎯 Objectives](#-objectives)
- [📚 Prerequisites](#-prerequisites)
- [🖥️ Lab Environment](#️-lab-environment)
- [🚀 Task 1 — Deploy SOAR Platform](#-task-1--deploy-soar-platform)
- [🦠 Task 2 — Create Malware Response Playbook](#-task-2--create-malware-response-playbook)
- [🎣 Task 3 — Create Phishing Response Playbook](#-task-3--create-phishing-response-playbook)
- [🔗 Task 4 — Integrate with SIEM Alerts](#-task-4--integrate-with-siem-alerts)
- [✅ Expected Outcomes](#-expected-outcomes)
- [🛠️ Troubleshooting Tips](#️-troubleshooting-tips)
- [📌 Conclusion & Key Takeaways](#-conclusion--key-takeaways)
- [📂 File Structure](#-file-structure)

---

## 🎯 Objectives

By the end of this lab, students will be able to:

- 🧠 Understand Security Orchestration, Automation, and Response (SOAR) fundamentals
- 🐝 Deploy and configure open-source SOAR platforms (TheHive and Cortex)
- 📋 Design automated incident response playbooks for common security scenarios
- 🔒 Implement containment and remediation workflows
- 🧪 Test playbook effectiveness through simulated incidents

---

## 📚 Prerequisites

| Requirement | Description |
|---|---|
| 🔄 IR Lifecycle | Basic understanding of incident response lifecycle |
| 🐧 Linux + Docker | Familiarity with Linux command line and Docker |
| 📊 SIEM Concepts | Knowledge of SIEM concepts and security monitoring |
| 🐍 Python | Basic Python scripting experience (helpful but not required) |

---

## 🖥️ Lab Environment

> 🌐 **Ready-to-Use Cloud Machines:** Al Nafi provides pre-configured Linux-based cloud machines. Click **Start Lab** to access your environment.

| Component | Version |
|---|---|
| 🐧 OS | Ubuntu 22.04 LTS |
| 🐳 Docker | Docker + Docker Compose pre-installed |
| 🐍 Python | Python 3.10 with pip |
| 🔧 Tools | All necessary networking tools |

---

## 🚀 Task 1 — Deploy SOAR Platform

### 📁 Step 1 — Create Project Structure

```bash
mkdir -p ~/soar-lab/{thehive,cortex,data}
cd ~/soar-lab
```

---

### 🐳 Step 2 — Configure Docker Compose

**File:** `docker-compose.yml`

```yaml
version: '3.8'

services:
  elasticsearch:
    image: docker.elastic.co/elasticsearch/elasticsearch:7.17.9
    container_name: elasticsearch
    environment:
      - discovery.type=single-node
      - cluster.name=hive
      - xpack.security.enabled=false
      - ES_JAVA_OPTS=-Xms256m -Xmx256m
    volumes:
      - ./data/elasticsearch:/usr/share/elasticsearch/data
    ports:
      - "9200:9200"
    networks:
      - soar-net

  cortex:
    image: thehiveproject/cortex:3.1.7
    container_name: cortex
    depends_on:
      - elasticsearch
    ports:
      - "9001:9001"
    volumes:
      - ./cortex/application.conf:/etc/cortex/application.conf
    networks:
      - soar-net

  thehive:
    image: thehiveproject/thehive4:4.1.24
    container_name: thehive
    depends_on:
      - elasticsearch
      - cortex
    ports:
      - "9000:9000"
    volumes:
      - ./thehive/application.conf:/etc/thehive/application.conf
      - ./data/thehive:/opt/thp/thehive/data
    command: --no-config-secret
    networks:
      - soar-net

networks:
  soar-net:
    driver: bridge
```

---

### 🐝 Step 3 — Configure TheHive

**File:** `thehive/application.conf`

```hocon
db.janusgraph {
  storage {
    backend = berkeleyje
    directory = /opt/thp/thehive/data/databases
  }
}

storage {
  provider = localfs
  localfs.location = /opt/thp/thehive/data/files
}

play.http.secret.key = "ThiSiSaVeRyStRoNgSeCrEtKeY"

scalligraph.auth {
  providers = [
    {name = session}
    {name = local}
  ]
}

play.modules.enabled += org.thp.thehive.connector.cortex.CortexModule
cortex {
  servers = [
    {
      name = local
      url = "http://cortex:9001"
    }
  ]
}
```

---

### 🧠 Step 4 — Configure Cortex

**File:** `cortex/application.conf`

```hocon
search {
  index = cortex
  uri = "http://elasticsearch:9200"
}

play.http.secret.key = "CortexSecretKey"
```

---

### ▶️ Step 5 — Launch SOAR Platform

```bash
# Set permissions
sudo chown -R 1000:1000 data/
chmod -R 755 data/

# Start services
docker-compose up -d

# Wait for initialization
sleep 120

# Verify services
docker-compose ps
curl http://localhost:9200/_cluster/health
curl http://localhost:9000/api/status
```

---

## 🦠 Task 2 — Create Malware Response Playbook

### 📋 Step 1 — Design Playbook Structure

**File:** `playbooks/malware_response.json`

```json
{
  "name": "Malware Incident Response",
  "description": "Automated malware detection and containment",
  "version": "1.0",
  "phases": [
    {
      "name": "Detection",
      "tasks": ["collect_artifacts", "threat_intelligence"]
    },
    {
      "name": "Containment",
      "tasks": ["isolate_host", "block_indicators"]
    },
    {
      "name": "Eradication",
      "tasks": ["remove_malware", "restore_system"]
    }
  ]
}
```

---

### 🐍 Step 2 — Implement Playbook Logic

**File:** `playbooks/malware_playbook.py`

```python
#!/usr/bin/env python3
import json
import hashlib
import requests
from datetime import datetime


class MalwarePlaybook:
    def __init__(self, thehive_url="http://localhost:9000"):
        self.thehive_url = thehive_url
        self.session = requests.Session()

    def create_case(self, title, description, severity="medium"):
        """
        Create a new incident case in TheHive.

        Args:
            title: Case title
            description: Case description
            severity: Severity level (low, medium, high, critical)

        Returns:
            Dictionary with case details or None if failed
        """
        # TODO: Implement case creation
        # - Prepare case_data dictionary with required fields
        # - Convert severity to numeric value (1-4)
        # - Send POST request to /api/case endpoint
        # - Handle response and return case object
        pass

    def add_observable(self, case_id, data_type, data, tags=None):
        """
        Add observable (IOC) to a case.

        Args:
            case_id: The case ID to add observable to
            data_type: Type of observable (hash, ip, domain, etc.)
            data: The observable value
            tags: List of tags for the observable

        Returns:
            Observable object or None if failed
        """
        # TODO: Implement observable addition
        # - Prepare observable_data with dataType, data, tags
        # - Send POST request to /api/case/{case_id}/artifact
        # - Return the created observable
        pass

    def analyze_file_hash(self, file_hash):
        """
        Analyze file hash for malicious indicators.

        Args:
            file_hash: MD5, SHA1, or SHA256 hash

        Returns:
            Dictionary with analysis results including threat_score
        """
        # TODO: Implement hash analysis
        # - Calculate threat score (simulate or use real API)
        # - Determine if hash is malicious (threshold > 70)
        # - Return analysis results with malware family info
        pass

    def isolate_host(self, host_ip):
        """
        Isolate infected host from network.

        Args:
            host_ip: IP address of host to isolate

        Returns:
            Dictionary with isolation status and commands
        """
        # TODO: Implement host isolation
        # - Generate firewall rules to block traffic
        # - Log isolation action with timestamp
        # - Return isolation status and method used
        pass

    def block_indicators(self, indicators):
        """
        Block malicious indicators at network level.

        Args:
            indicators: List of IOCs to block (IPs, domains, hashes)

        Returns:
            List of blocked indicators with timestamps
        """
        # TODO: Implement indicator blocking
        # - Iterate through indicators list
        # - Apply blocking rules for each indicator
        # - Return list of successfully blocked indicators
        pass

    def execute_playbook(self, incident_data):
        """
        Execute complete malware response playbook.

        Args:
            incident_data: Dictionary with incident details

        Returns:
            Dictionary with playbook execution results
        """
        # TODO: Implement playbook execution
        # Phase 1: Detection and Analysis
        #   - Create case
        #   - Add observables
        #   - Analyze file hashes

        # Phase 2: Containment
        #   - Isolate affected hosts if malicious
        #   - Block malicious indicators

        # Phase 3: Eradication
        #   - Generate manual remediation tasks
        #   - Document recovery steps

        # Return execution summary
        pass


# Test the playbook
if __name__ == "__main__":
    playbook = MalwarePlaybook()

    incident = {
        "title": "Suspicious File Detected",
        "description": "Potential malware on workstation",
        "severity": "high",
        "affected_hosts": ["192.168.1.100"],
        "observables": [
            {"type": "hash", "value": "d41d8cd98f00b204e9800998ecf8427e", "tags": ["suspicious"]},
            {"type": "ip", "value": "192.168.1.100", "tags": ["infected_host"]}
        ]
    }

    # TODO: Execute playbook and print results
```

---

### ▶️ Step 3 — Test Malware Playbook

```bash
chmod +x playbooks/malware_playbook.py
python3 playbooks/malware_playbook.py
```

---

## 🎣 Task 3 — Create Phishing Response Playbook

### 🐍 Step 1 — Design Phishing Playbook

**File:** `playbooks/phishing_playbook.py`

```python
#!/usr/bin/env python3
import re
import hashlib
import urllib.parse
from datetime import datetime


class PhishingPlaybook:
    def __init__(self, thehive_url="http://localhost:9000"):
        self.thehive_url = thehive_url

    def analyze_email_headers(self, email_data):
        """
        Analyze email headers for phishing indicators.

        Args:
            email_data: Dictionary with email headers and content

        Returns:
            Dictionary with header analysis results
        """
        # TODO: Implement header analysis
        # - Check SPF, DKIM, DMARC validation
        # - Verify sender reputation
        # - Identify suspicious header patterns
        # - Return analysis results
        pass

    def extract_urls(self, email_body):
        """
        Extract all URLs from email body.

        Args:
            email_body: Email body text

        Returns:
            List of extracted URLs
        """
        # TODO: Implement URL extraction
        # - Use regex to find HTTP/HTTPS URLs
        # - Return list of unique URLs found
        pass

    def analyze_urls(self, urls):
        """
        Analyze URLs for malicious content.

        Args:
            urls: List of URLs to analyze

        Returns:
            List of dictionaries with URL analysis results
        """
        # TODO: Implement URL analysis
        # - For each URL, extract domain
        # - Calculate risk score
        # - Check against known malicious patterns
        # - Return analysis for each URL
        pass

    def quarantine_emails(self, search_criteria):
        """
        Quarantine phishing emails organization-wide.

        Args:
            search_criteria: Dictionary with search parameters

        Returns:
            Dictionary with quarantine results
        """
        # TODO: Implement email quarantine
        # - Search for similar emails using criteria
        # - Move matching emails to quarantine
        # - Return count of quarantined emails
        pass

    def block_malicious_urls(self, urls):
        """
        Block malicious URLs at proxy/DNS level.

        Args:
            urls: List of URLs to block

        Returns:
            List of blocked URLs with timestamps
        """
        # TODO: Implement URL blocking
        # - Filter for suspicious URLs
        # - Apply blocking rules
        # - Return list of blocked URLs
        pass

    def notify_users(self, affected_users, indicators):
        """
        Send security awareness notifications to users.

        Args:
            affected_users: List of user email addresses
            indicators: List of IOCs to include in notification

        Returns:
            List of notification results
        """
        # TODO: Implement user notification
        # - Generate notification message
        # - Send to each affected user
        # - Return notification status for each user
        pass

    def execute_playbook(self, phishing_incident):
        """
        Execute complete phishing response playbook.

        Args:
            phishing_incident: Dictionary with phishing email details

        Returns:
            Dictionary with playbook execution results
        """
        # TODO: Implement playbook execution
        # Phase 1: Initial Assessment
        #   - Analyze email headers
        #   - Extract and analyze URLs

        # Phase 2: Containment
        #   - Quarantine similar emails
        #   - Block malicious URLs

        # Phase 3: User Response
        #   - Notify affected users
        #   - Force password reset if needed

        # Return execution summary
        pass


# Test the playbook
if __name__ == "__main__":
    playbook = PhishingPlaybook()

    incident = {
        "subject": "Urgent: Verify Your Account",
        "sender": "noreply@suspicious-domain.com",
        "recipients": ["user1@company.com", "user2@company.com"],
        "body": "Click here to verify: http://malicious-site.com/verify",
        "headers": {
            "received-spf": "fail",
            "dkim-signature": "",
            "authentication-results": "dmarc=fail"
        }
    }

    # TODO: Execute playbook and print results
```

---

### ▶️ Step 2 — Test Phishing Playbook

```bash
chmod +x playbooks/phishing_playbook.py
python3 playbooks/phishing_playbook.py
```

---

## 🔗 Task 4 — Integrate with SIEM Alerts

### 🐍 Step 1 — Create Alert Integration Script

**File:** `integration/siem_integration.py`

```python
#!/usr/bin/env python3
import json
import time
from malware_playbook import MalwarePlaybook
from phishing_playbook import PhishingPlaybook


class SIEMIntegration:
    def __init__(self):
        self.malware_playbook = MalwarePlaybook()
        self.phishing_playbook = PhishingPlaybook()

    def process_alert(self, alert):
        """
        Process incoming SIEM alert and trigger appropriate playbook.

        Args:
            alert: Dictionary with alert details

        Returns:
            Playbook execution results
        """
        # TODO: Implement alert processing
        # - Parse alert type and severity
        # - Determine which playbook to execute
        # - Transform alert data to playbook format
        # - Execute appropriate playbook
        # - Return results
        pass

    def monitor_alerts(self, alert_queue):
        """
        Continuously monitor alert queue and process alerts.

        Args:
            alert_queue: Queue or list of alerts to process
        """
        # TODO: Implement alert monitoring
        # - Poll alert queue periodically
        # - Process each new alert
        # - Log processing results
        # - Handle errors gracefully
        pass


# Example usage
if __name__ == "__main__":
    integration = SIEMIntegration()

    # Simulate SIEM alerts
    alerts = [
        {
            "type": "malware",
            "severity": "high",
            "source": "endpoint_protection",
            "data": {
                "host": "192.168.1.100",
                "file_hash": "abc123def456",
                "detection_time": "2024-01-15T10:30:00Z"
            }
        },
        {
            "type": "phishing",
            "severity": "medium",
            "source": "email_gateway",
            "data": {
                "sender": "attacker@evil.com",
                "subject": "Urgent Action Required",
                "recipients": ["user@company.com"]
            }
        }
    ]

    # TODO: Process alerts using integration
```

---

### ▶️ Step 2 — Test SIEM Integration

```bash
chmod +x integration/siem_integration.py
python3 integration/siem_integration.py
```

---

## ✅ Expected Outcomes

After completing this lab, you should have:

| # | Deliverable |
|---|---|
| 1️⃣ | Functional SOAR platform (TheHive + Cortex) running in Docker |
| 2️⃣ | Automated malware response playbook that creates cases, analyzes threats, and isolates hosts |
| 3️⃣ | Phishing response playbook that analyzes emails, quarantines threats, and notifies users |
| 4️⃣ | SIEM integration script that routes alerts to appropriate playbooks |
| 5️⃣ | Understanding of playbook design patterns and automation workflows |

---

## 🛠️ Troubleshooting Tips

### 🐳 Services Won't Start

```bash
# Check Docker logs
docker-compose logs -f

# Verify port availability
netstat -tuln | grep -E '9000|9001|9200'

# Ensure sufficient disk space
df -h
```

### 🐝 Cannot Connect to TheHive API

```bash
# Verify service is running
curl http://localhost:9000/api/status

# Check firewall rules
sudo ufw status

# Review TheHive logs
docker logs thehive
```

### 🐍 Playbook Execution Fails

- Validate JSON syntax in playbook definition files
- Check Python dependencies: `pip3 list`
- Verify API endpoints are accessible with `curl`
- Review error messages in script output carefully

---

## 📌 Conclusion & Key Takeaways

This lab introduced SOAR concepts through hands-on implementation of automated incident response playbooks. You deployed an open-source SOAR platform, created playbooks for malware and phishing incidents, and integrated with SIEM alerts.

| 🔑 Concept | 📖 Summary |
|---|---|
| 🤖 Automation | SOAR platforms automate repetitive incident response tasks |
| 📋 Standardization | Playbooks standardize response procedures across the organization |
| 🔗 Integration | Integration with SIEM enables real-time automated response |
| 🧪 Testing | Proper testing and validation ensures playbook effectiveness |
| ⏱️ Speed | Automated response dramatically reduces mean time to respond (MTTR) |

> 💡 **Continue practicing** by creating additional playbooks for other incident types such as data breaches, DDoS attacks, or insider threats.

---

## 📂 File Structure

```
soar-lab/
├── 📄 README.md                          ← This file
├── 🐳 docker-compose.yml                 ← Task 1.2 — SOAR platform services
├── thehive/
│   └── ⚙️ application.conf              ← Task 1.3 — TheHive configuration
├── cortex/
│   └── ⚙️ application.conf              ← Task 1.4 — Cortex configuration
├── playbooks/
│   ├── 📋 malware_response.json          ← Task 2.1 — Malware playbook structure
│   ├── 🐍 malware_playbook.py            ← Task 2.2 — Malware response automation
│   └── 🐍 phishing_playbook.py           ← Task 3.1 — Phishing response automation
├── integration/
│   └── 🐍 siem_integration.py            ← Task 4.1 — SIEM alert routing
└── data/
    ├── elasticsearch/                    ← Elasticsearch data volume
    └── thehive/                          ← TheHive data volume
```

---

<div align="center">

![Made with](https://img.shields.io/badge/Made%20with-❤️%20for%20Learning-blueviolet?style=for-the-badge)
![Al Nafi](https://img.shields.io/badge/Platform-Al%20Nafi-0a0a0a?style=for-the-badge)
![Blue Team](https://img.shields.io/badge/Domain-Blue%20Team%20%7C%20Incident%20Response-0078D7?style=for-the-badge&logo=microsoftazure&logoColor=white)

> 🔵 *"The best incident response is the one that happens automatically before the attacker can do damage."*

</div>
