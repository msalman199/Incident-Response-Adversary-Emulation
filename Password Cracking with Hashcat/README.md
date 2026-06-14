# 🔐 Password Cracking with Hashcat

<div align="center">

![Linux](https://img.shields.io/badge/Linux-Ubuntu-E95420?style=for-the-badge\&logo=ubuntu)
![Hashcat](https://img.shields.io/badge/Hashcat-Password%20Cracking-red?style=for-the-badge)
![Python](https://img.shields.io/badge/Python-3.x-blue?style=for-the-badge\&logo=python)
![Bash](https://img.shields.io/badge/Bash-Scripting-black?style=for-the-badge\&logo=gnu-bash)
![OpenCL](https://img.shields.io/badge/OpenCL-GPU%20Acceleration-green?style=for-the-badge)
![Cybersecurity](https://img.shields.io/badge/Cybersecurity-Offensive%20Security-darkred?style=for-the-badge)

</div>

---

# 📖 Overview

This lab provides hands-on experience with **Hashcat**, one of the world's fastest password recovery tools. Students will learn password auditing techniques, hash identification, dictionary attacks, brute-force attacks, GPU acceleration, performance benchmarking, and password security analysis.

---

# 🎯 Objectives

By the end of this lab, students will be able to:

✅ Understand password cracking fundamentals

✅ Install and configure Hashcat

✅ Perform dictionary attacks

✅ Execute brute-force attacks

✅ Utilize GPU acceleration

✅ Compare CPU vs GPU performance

✅ Create custom wordlists

✅ Identify hash types

✅ Generate password security reports

---

# 📋 Prerequisites

* Linux Command Line Fundamentals
* Cryptographic Hash Knowledge (MD5, SHA1, SHA256)
* Basic Cybersecurity Concepts
* Bash Scripting Basics
* Ethical Hacking Awareness

---

# 🖥️ Lab Environment

### Al Nafi Cloud Machine

Preconfigured Environment Includes:

* Ubuntu Linux
* Hashcat
* Python 3
* OpenCL Support
* GPU Drivers
* Wordlist Support

---

# 🚀 Task 1: Environment Setup & Hash Preparation

## 🔹 Install Hashcat

```bash
sudo apt update && sudo apt upgrade -y

sudo apt install hashcat opencl-headers ocl-icd-opencl-dev -y

sudo apt install nvidia-driver-470 nvidia-opencl-dev -y

hashcat --version

hashcat -I
```

---

## 🔹 Create Hash Files

```bash
mkdir ~/hashcat_lab
cd ~/hashcat_lab

echo -n "password123" | md5sum | cut -d' ' -f1 > md5_hashes.txt
echo -n "admin2023" | md5sum | cut -d' ' -f1 >> md5_hashes.txt
echo -n "welcome" | md5sum | cut -d' ' -f1 >> md5_hashes.txt
echo -n "qwerty" | md5sum | cut -d' ' -f1 >> md5_hashes.txt

echo -n "password123" | sha256sum | cut -d' ' -f1 > sha256_hashes.txt
echo -n "admin2023" | sha256sum | cut -d' ' -f1 >> sha256_hashes.txt
echo -n "welcome" | sha256sum | cut -d' ' -f1 >> sha256_hashes.txt
echo -n "qwerty" | sha256sum | cut -d' ' -f1 >> sha256_hashes.txt
```

---

## 🔹 Create Wordlists

```bash
mkdir wordlists
cd wordlists
```

### Download SecLists

```bash
wget https://github.com/danielmiessler/SecLists/raw/master/Passwords/Common-Credentials/10-million-password-list-top-1000000.txt -O top1m.txt
```

### Custom Wordlist

```text
password
123456
password123
admin
admin2023
welcome
qwerty
letmein
monkey
dragon
```

### Numeric Wordlist

```bash
seq 1000 9999 > numeric.txt
```

---

# 🚀 Task 2: Dictionary Attacks

## 🔹 Crack MD5 Hashes

```bash
hashcat -m 0 -a 0 md5_hashes.txt wordlists/custom_wordlist.txt

hashcat -m 0 md5_hashes.txt --show

hashcat -m 0 md5_hashes.txt --show > md5_cracked.txt
```

---

## 🔹 Crack SHA256 Hashes

```bash
hashcat -m 1400 -a 0 sha256_hashes.txt wordlists/custom_wordlist.txt

hashcat -m 1400 sha256_hashes.txt --show > sha256_cracked.txt
```

---

# 🚀 Task 3: CPU vs GPU Performance Testing

## 📄 performance_test.sh

```bash
#!/bin/bash

echo "=== Performance Comparison Test ==="
echo "Testing MD5 hash cracking performance"
echo

echo "CPU-only test:"
time hashcat -m 0 -a 0 -d 1 --quiet md5_hashes.txt wordlists/top1m.txt 2>/dev/null

echo
echo "GPU-accelerated test:"
time hashcat -m 0 -a 0 -d 2 --quiet md5_hashes.txt wordlists/top1m.txt 2>/dev/null

echo
echo "Performance test completed"
```

### Execute

```bash
chmod +x performance_test.sh
./performance_test.sh
```

---

# 🚀 Task 4: Brute Force Attacks

## Create Test Hashes

```bash
echo -n "abc" | md5sum | cut -d' ' -f1 > simple_md5.txt
echo -n "123" | md5sum | cut -d' ' -f1 >> simple_md5.txt
```

### Lowercase Attack

```bash
hashcat -m 0 -a 3 simple_md5.txt ?l?l?l
```

### Numeric Attack

```bash
hashcat -m 0 -a 3 simple_md5.txt ?d?d?d
```

### Show Results

```bash
hashcat -m 0 simple_md5.txt --show
```

---

# 🚀 Task 5: Rule-Based Attack

## 📄 custom.rule

```text
:
c
u
$1
$2
$3
$!
$@
^1
^2
^3
```

### Run Attack

```bash
hashcat -m 0 -a 0 md5_hashes.txt wordlists/custom_wordlist.txt -r custom.rule
```

---

# 🚀 Task 6: Combination Attack

## Create Wordlists

```bash
echo -e "pass\nadmin\nuser" > left.txt

echo -e "word\n123\n2023" > right.txt
```

## Create Test Hashes

```bash
echo -n "password" | md5sum | cut -d' ' -f1 > combo_test.txt
echo -n "admin123" | md5sum | cut -d' ' -f1 >> combo_test.txt
echo -n "user2023" | md5sum | cut -d' ' -f1 >> combo_test.txt
```

## Execute Combination Attack

```bash
hashcat -m 0 -a 1 combo_test.txt left.txt right.txt
```

---

# 🚀 Task 7: Benchmarking Hashcat

## 📄 benchmark.sh

```bash
#!/bin/bash

echo "=== Hashcat Benchmark Analysis ==="

echo "Benchmarking MD5"
hashcat -b -m 0

echo "Benchmarking SHA256"
hashcat -b -m 1400

echo "Benchmarking NTLM"
hashcat -b -m 1000

echo "Benchmarking bcrypt"
hashcat -b -m 3200

echo
echo "GPU Information"
lspci | grep -i vga

echo
echo "CPU Information"
lscpu | grep "Model name"

echo
echo "Memory Information"
free -h
```

### Run Benchmark

```bash
chmod +x benchmark.sh

./benchmark.sh > benchmark_results.txt
```

---

# 🚀 Task 8: Optimized GPU Cracking

## 📄 optimized_crack.sh

```bash
#!/bin/bash

HASH_FILE="$1"
WORDLIST="$2"
HASH_MODE="$3"

if [ $# -ne 3 ]; then
    echo "Usage: $0 <hash_file> <wordlist> <hash_mode>"
    exit 1
fi

hashcat -m "$HASH_MODE" -a 0 "$HASH_FILE" "$WORDLIST" \
    --optimized-kernel-enable \
    --workload-profile 3 \
    --status \
    --status-timer 10

hashcat -m "$HASH_MODE" "$HASH_FILE" --show
```

### Execute

```bash
chmod +x optimized_crack.sh

./optimized_crack.sh md5_hashes.txt wordlists/top1m.txt 0
```

---

# 🚀 Task 9: Password Analysis Report

## 📄 analysis_report.sh

```bash
#!/bin/bash

echo "=== Password Cracking Analysis Report ==="

echo "Generated on: $(date)"

echo
echo "MD5 Hashes:"
wc -l md5_hashes.txt

echo
echo "SHA256 Hashes:"
wc -l sha256_hashes.txt

echo
echo "Security Recommendations"

echo "1. Avoid common passwords"
echo "2. Use complex passphrases"
echo "3. Enforce password policies"
echo "4. Use stronger hashing algorithms"
echo "5. Implement salted hashes"
```

### Run Report

```bash
chmod +x analysis_report.sh

./analysis_report.sh > final_report.txt
```

---

# 🚀 Task 10: Performance Metrics

## 📄 metrics.sh

```bash
#!/bin/bash

echo "=== Performance Metrics Collection ==="

echo -n "testpassword" | md5sum | cut -d' ' -f1 > test_hash.txt

echo "Dictionary Attack"
time hashcat -m 0 -a 0 test_hash.txt wordlists/custom_wordlist.txt --quiet

echo "Brute Force Attack"
time hashcat -m 0 -a 3 test_hash.txt ?l?l?l?l --quiet

echo "Rule-Based Attack"
time hashcat -m 0 -a 0 test_hash.txt wordlists/custom_wordlist.txt -r custom.rule --quiet

nvidia-smi 2>/dev/null || echo "GPU Not Available"

uptime
```

---

# 🚀 Task 11: Lab Validation

## 📄 validate_lab.sh

```bash
#!/bin/bash

echo "=== Lab Validation ==="

command -v hashcat >/dev/null && echo "✓ Hashcat Installed"

[ -f md5_hashes.txt ] && echo "✓ MD5 Hashes Created"

[ -f sha256_hashes.txt ] && echo "✓ SHA256 Hashes Created"

[ -f wordlists/custom_wordlist.txt ] && echo "✓ Wordlist Created"

[ -f md5_cracked.txt ] && echo "✓ Passwords Cracked"

hashcat -I | grep OpenCL >/dev/null && echo "✓ OpenCL Detected"

echo "Validation Complete"
```

### Execute

```bash
chmod +x validate_lab.sh

./validate_lab.sh
```

---

# 🔍 Troubleshooting

## OpenCL Device Not Found

```bash
clinfo

sudo apt install clinfo ocl-icd-opencl-dev
```

---

## GPU Not Detected

```bash
nvidia-smi

lspci | grep -i vga
```

---

## Performance Issues

```bash
htop

sensors

hashcat --help | grep workload-profile
```

---

# ✅ Lab Validation Checklist

* [x] Hashcat Installed
* [x] OpenCL Working
* [x] Wordlists Created
* [x] MD5 Hashes Cracked
* [x] SHA256 Hashes Cracked
* [x] Rule-Based Attack Completed
* [x] Combination Attack Completed
* [x] GPU Benchmark Performed
* [x] Reports Generated

---

# 🎓 Skills Gained

### Offensive Security

* Password Auditing
* Hash Identification
* Credential Analysis
* Attack Simulation

### System Administration

* Linux Package Management
* GPU Driver Configuration
* OpenCL Configuration

### Automation

* Bash Scripting
* Performance Benchmarking
* Automated Reporting

### Incident Response

* Credential Recovery
* Breach Impact Assessment
* Security Validation

---

# 🏆 Conclusion

This lab provided practical experience with **Hashcat**, one of the most powerful password recovery frameworks available today.

Students successfully:

✅ Installed and configured Hashcat

✅ Performed dictionary attacks

✅ Executed brute-force attacks

✅ Used rule-based and combination attacks

✅ Leveraged GPU acceleration

✅ Benchmarked cracking performance

✅ Generated professional reports

✅ Developed real-world password auditing skills

These skills are directly applicable to:

* Incident Response
* Digital Forensics
* Penetration Testing
* Red Team Operations
* Adversary Emulation
* Security Assessments

---

### ⚠️ Ethical Use Notice

Password cracking techniques must only be used on systems you own or have explicit authorization to assess. Unauthorized password attacks are illegal and unethical.

**Use responsibly and follow all applicable laws and organizational policies.**

🔐 Happy Learning & Ethical Hacking!
