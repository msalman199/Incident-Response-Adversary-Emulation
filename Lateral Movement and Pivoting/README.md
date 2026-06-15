# 🌐 Lateral Movement and Pivoting 

![Security](https://img.shields.io/badge/Category-Cybersecurity-red?style=for-the-badge&logo=shield&logoColor=white)
![Level](https://img.shields.io/badge/Level-Intermediate-orange?style=for-the-badge&logo=bookstack&logoColor=white)
![Platform](https://img.shields.io/badge/Platform-Linux%20Cloud-blue?style=for-the-badge&logo=linux&logoColor=white)
![Python](https://img.shields.io/badge/Python-3.8+-yellow?style=for-the-badge&logo=python&logoColor=white)
![PowerShell](https://img.shields.io/badge/PowerShell-Core-5391FE?style=for-the-badge&logo=powershell&logoColor=white)
![NetworkX](https://img.shields.io/badge/NetworkX-Graph%20Analysis-orange?style=for-the-badge&logo=python&logoColor=white)
![BloodHound](https://img.shields.io/badge/BloodHound-AD%20Analysis-red?style=for-the-badge&logo=data:image/svg+xml;base64,&logoColor=white)
![Neo4j](https://img.shields.io/badge/Neo4j-Graph%20DB-008CC1?style=for-the-badge&logo=neo4j&logoColor=white)
![Nmap](https://img.shields.io/badge/Nmap-Network%20Scan-4B8BBE?style=for-the-badge&logo=nmap&logoColor=white)
![License](https://img.shields.io/badge/Use-Educational%20Only-green?style=for-the-badge&logo=academia&logoColor=white)

> ⚠️ **Authorization Reminder:** All techniques in this lab must only be used in **authorized penetration testing engagements** or **controlled lab environments**. Always ensure you have **proper written authorization** before performing any lateral movement or pivoting activities.

---

## 📋 Table of Contents

- [🎯 Objectives](#-objectives)
- [📚 Prerequisites](#-prerequisites)
- [🖥️ Lab Environment](#️-lab-environment)
- [🔎 Task 1 — Network Discovery and Reconnaissance](#-task-1--network-discovery-and-reconnaissance)
- [💻 Task 2 — PowerShell Lateral Movement Techniques](#-task-2--powershell-lateral-movement-techniques)
- [🩸 Task 3 — BloodHound Data Analysis](#-task-3--bloodhound-data-analysis)
- [🔀 Task 4 — Custom Pivot Point Identification](#-task-4--custom-pivot-point-identification)
- [✅ Expected Outcomes](#-expected-outcomes)
- [🛠️ Troubleshooting Tips](#️-troubleshooting-tips)
- [📌 Conclusion & Key Takeaways](#-conclusion--key-takeaways)
- [🚀 Next Steps](#-next-steps)
- [📂 File Structure](#-file-structure)

---

## 🎯 Objectives

By the end of this lab, students will be able to:

- 🧠 Understand lateral movement and pivoting concepts in network security
- 💻 Use PowerShell for network reconnaissance and lateral movement simulation
- 🩸 Analyze Active Directory attack paths using BloodHound data structures
- 📝 Create custom scripts to identify pivot points in a network
- 🗺️ Map network topology and identify high-value targets

---

## 📚 Prerequisites

| Requirement | Description |
|---|---|
| 🌐 Networking | Basic understanding of networking concepts (TCP/IP, ports, protocols) |
| 🐧 Linux CLI | Familiarity with Linux command line operations |
| 💠 PowerShell | Basic knowledge of PowerShell scripting |
| 🏢 Active Directory | Understanding of Active Directory fundamentals |
| 🐍 Python | Python scripting basics |

---

## 🖥️ Lab Environment

> 🌐 **Cloud Machine:** Al Nafi provides a pre-configured Linux-based cloud machine for this lab. Click **Start Lab** to access your environment.

> 🧰 **Pre-installed Tools:** PowerShell, Python3, Neo4j, network utilities — all ready to use, no setup required.

---

## 🔎 Task 1 — Network Discovery and Reconnaissance

### 📁 Step 1.1 — Set Up Lab Directory

Create your working directory and initialize the lab environment:

```bash
# Create lab directory structure
mkdir -p ~/lateral_movement_lab/{scripts,data,reports}
cd ~/lateral_movement_lab

# Verify required tools
pwsh --version
python3 --version
which nmap
```

---

### 🐍 Step 1.2 — Create Network Simulation Service

**File:** `scripts/network_simulator.py`

```python
#!/usr/bin/env python3
# File: scripts/network_simulator.py

import socket
import threading
import json


class NetworkSimulator:
    """
    Simulates network services for lateral movement practice.
    """

    def __init__(self):
        self.services = {
            'web':  8080,
            'smb':  8445,
            'db':   5432,
            'ldap': 8389
        }

    def start_service(self, name, port):
        """
        Start a simulated network service.

        Args:
            name: Service name
            port: Port number
        """
        # TODO: Create socket and bind to port
        # TODO: Listen for connections
        # TODO: Accept connections and send service banner
        # TODO: Handle errors gracefully
        pass

    def start_all(self):
        """Start all simulated services in background threads."""
        # TODO: Create thread for each service
        # TODO: Start all threads as daemons
        # TODO: Return list of active threads
        pass


if __name__ == "__main__":
    # TODO: Instantiate simulator
    # TODO: Start all services
    # TODO: Keep running until interrupted
    pass
```

> 📌 **Student Task:** Complete the network simulator to create listening services on the specified ports.

---

### 💠 Step 1.3 — Perform Network Discovery

**File:** `scripts/network_discovery.ps1`

```powershell
# File: scripts/network_discovery.ps1

function Get-NetworkHosts {
    <#
    .SYNOPSIS
    Discover hosts on the network

    .PARAMETER Network
    Network range to scan
    #>
    param([string]$Network = "127.0.0.0/24")

    # TODO: Implement network host discovery
    # TODO: Return array of discovered hosts with properties
    # Hint: Include IP, hostname, OS, services
}

function Test-ServiceConnectivity {
    <#
    .SYNOPSIS
    Test if a service port is open
    #>
    param(
        [string]$Target,
        [int]$Port,
        [int]$Timeout = 3000
    )

    # TODO: Create TCP client
    # TODO: Attempt connection with timeout
    # TODO: Return true if successful, false otherwise
}

function Invoke-NetworkScan {
    <#
    .SYNOPSIS
    Perform comprehensive network scan
    #>

    # TODO: Discover hosts using Get-NetworkHosts
    # TODO: Test common ports on each host
    # TODO: Generate scan report
    # TODO: Save results to JSON file
}

# Execute scan
Invoke-NetworkScan
```

> 📌 **Student Task:** Implement the network discovery functions and test against your simulator.

---

## 💻 Task 2 — PowerShell Lateral Movement Techniques

### 💠 Step 2.1 — Create Lateral Movement Functions

**File:** `scripts/lateral_movement.ps1`

```powershell
# File: scripts/lateral_movement.ps1

function Invoke-LateralMovement {
    <#
    .SYNOPSIS
    Simulate lateral movement to target system
    #>
    param(
        [string]$Target,
        [string]$Method,
        [string]$Credential
    )

    # TODO: Validate target connectivity
    # TODO: Simulate movement based on method (SSH, SMB, WinRM)
    # TODO: Log movement attempt
    # TODO: Return success/failure status
}

function Get-DomainInfo {
    <#
    .SYNOPSIS
    Enumerate domain information
    #>

    # TODO: Simulate domain enumeration
    # TODO: Return domain name, DC, users, groups, computers
    # Hint: Create mock data structure for practice
}

function Find-LocalAdmins {
    <#
    .SYNOPSIS
    Identify local administrators on target systems
    #>
    param([array]$Computers)

    # TODO: For each computer, enumerate local admins
    # TODO: Return hashtable of computer -> admins mapping
}

function Get-LoggedOnUsers {
    <#
    .SYNOPSIS
    Find currently logged on users
    #>
    param([array]$Computers)

    # TODO: Query each computer for active sessions
    # TODO: Return array of user/computer pairs
}

function Plan-AttackPath {
    <#
    .SYNOPSIS
    Generate potential attack path to target
    #>
    param(
        [string]$StartHost,
        [string]$TargetHost,
        [hashtable]$NetworkMap
    )

    # TODO: Analyze network topology
    # TODO: Identify intermediate pivot points
    # TODO: Generate step-by-step attack path
    # TODO: Return ordered list of steps
}
```

> 📌 **Student Task:** Implement these functions to simulate lateral movement scenarios.

---

### ▶️ Step 2.2 — Execute Lateral Movement Simulation

**File:** `scripts/execute_lateral_movement.ps1`

```powershell
# File: scripts/execute_lateral_movement.ps1

# TODO: Source the lateral_movement.ps1 functions
# TODO: Discover network topology
# TODO: Enumerate domain information
# TODO: Find local admins and logged on users
# TODO: Plan attack path from compromised host to domain controller
# TODO: Simulate movement along the path
# TODO: Generate comprehensive report
```

> 📌 **Student Task:** Build the orchestration script and execute a full lateral movement simulation.

---

## 🩸 Task 3 — BloodHound Data Analysis

### 🐍 Step 3.1 — Generate BloodHound Dataset

**File:** `scripts/generate_bloodhound_data.py`

```python
#!/usr/bin/env python3
# File: scripts/generate_bloodhound_data.py

import json
import random
from datetime import datetime


class BloodHoundDataGenerator:
    """
    Generate sample BloodHound-compatible AD data for analysis.
    """

    def __init__(self):
        self.domain = "LAB.LOCAL"
        self.users = []
        self.computers = []
        self.groups = []

    def generate_users(self, count=10):
        """
        Generate user objects with properties.

        Args:
            count: Number of users to generate

        Returns:
            List of user dictionaries
        """
        # TODO: Create user objects with required properties
        # TODO: Include: name, SID, highvalue, enabled, admincount
        # TODO: Mark some users as high-value (admins)
        pass

    def generate_computers(self, count=5):
        """Generate computer objects."""
        # TODO: Create computer objects
        # TODO: Include: name, OS, highvalue, enabled
        # TODO: Mark domain controllers as high-value
        pass

    def generate_groups(self):
        """Generate group objects."""
        # TODO: Create standard AD groups
        # TODO: Include: Domain Admins, Enterprise Admins, Domain Users
        # TODO: Assign members to groups
        pass

    def generate_relationships(self):
        """Generate relationships between objects."""
        # TODO: Create MemberOf relationships
        # TODO: Create AdminTo relationships
        # TODO: Create HasSession relationships
        pass

    def save_data(self, output_dir):
        """Save all data to JSON files."""
        # TODO: Save users.json
        # TODO: Save computers.json
        # TODO: Save groups.json
        # TODO: Save relationships.json
        pass


if __name__ == "__main__":
    # TODO: Instantiate generator
    # TODO: Generate all data types
    # TODO: Save to data directory
    pass
```

> 📌 **Student Task:** Complete the data generator to create realistic AD structures.

---

### 🔍 Step 3.2 — Analyze Attack Paths

**File:** `scripts/bloodhound_analyzer.py`

```python
#!/usr/bin/env python3
# File: scripts/bloodhound_analyzer.py

import json
import networkx as nx


class BloodHoundAnalyzer:
    """
    Analyze BloodHound data to identify attack paths.
    """

    def __init__(self):
        self.graph = nx.DiGraph()
        self.high_value_targets = []

    def load_data(self, data_dir):
        """
        Load BloodHound JSON files.

        Args:
            data_dir: Directory containing JSON files
        """
        # TODO: Load users.json and add to graph
        # TODO: Load computers.json and add to graph
        # TODO: Load groups.json and add to graph
        # TODO: Identify high-value targets
        pass

    def build_relationships(self, relationships_file):
        """Build edges in the graph from relationships."""
        # TODO: Load relationships JSON
        # TODO: Add edges to graph (MemberOf, AdminTo, HasSession)
        # TODO: Set edge weights based on relationship type
        pass

    def find_paths_to_target(self, target):
        """
        Find all paths to a high-value target.

        Args:
            target: Target node name

        Returns:
            List of paths (each path is a list of nodes)
        """
        # TODO: Find all nodes with paths to target
        # TODO: Calculate shortest paths
        # TODO: Return sorted by path length
        pass

    def analyze_attack_surface(self):
        """Analyze overall attack surface."""
        # TODO: Calculate graph metrics (centrality, clustering)
        # TODO: Identify critical nodes (high betweenness)
        # TODO: Find weakest paths to high-value targets
        pass

    def generate_report(self, output_file):
        """Generate analysis report."""
        # TODO: Summarize findings
        # TODO: List top attack paths
        # TODO: Identify critical vulnerabilities
        # TODO: Save to JSON report
        pass


if __name__ == "__main__":
    # TODO: Instantiate analyzer
    # TODO: Load data
    # TODO: Build relationships
    # TODO: Find attack paths
    # TODO: Generate report
    pass
```

> 📌 **Student Task:** Implement the analyzer to discover attack paths in your generated AD data.

---

### 📊 Step 3.3 — Visualize Attack Paths

**File:** `scripts/visualize_paths.py`

```python
#!/usr/bin/env python3
# File: scripts/visualize_paths.py

import json
import networkx as nx
import matplotlib.pyplot as plt


def visualize_attack_path(graph, path, output_file):
    """
    Visualize a specific attack path.

    Args:
        graph: NetworkX graph object
        path: List of nodes in the path
        output_file: Output image filename
    """
    # TODO: Create subgraph containing only path nodes
    # TODO: Set node colors (red for high-value, yellow for pivot)
    # TODO: Draw graph with labels
    # TODO: Save to file
    pass


def create_attack_graph_summary(analyzer, output_file):
    """Create summary visualization of all attack paths."""
    # TODO: Extract key paths from analyzer
    # TODO: Create combined visualization
    # TODO: Highlight critical nodes
    # TODO: Save summary graph
    pass


if __name__ == "__main__":
    # TODO: Load analyzer results
    # TODO: Generate visualizations for top 3 paths
    # TODO: Create summary graph
    pass
```

> 📌 **Student Task:** Complete the visualization functions to create attack path diagrams.

---

## 🔀 Task 4 — Custom Pivot Point Identification

### 🐍 Step 4.1 — Build Pivot Point Scanner

**File:** `scripts/pivot_scanner.py`

```python
#!/usr/bin/env python3
# File: scripts/pivot_scanner.py


class PivotScanner:
    """
    Identify systems that can serve as pivot points.
    """

    def __init__(self, network_data):
        self.network_data = network_data
        self.pivot_candidates = []

    def analyze_connectivity(self, host):
        """
        Analyze host connectivity to multiple network segments.

        Args:
            host: Host dictionary with network information

        Returns:
            Connectivity score (higher = better pivot)
        """
        # TODO: Check number of network interfaces
        # TODO: Analyze routing table
        # TODO: Count accessible subnets
        # TODO: Return connectivity score
        pass

    def analyze_privileges(self, host):
        """Analyze privilege level on host."""
        # TODO: Check if current user is admin
        # TODO: Check for stored credentials
        # TODO: Check for service accounts
        # TODO: Return privilege score
        pass

    def analyze_services(self, host):
        """Analyze running services for pivot potential."""
        # TODO: Check for SSH/RDP services
        # TODO: Check for proxy services
        # TODO: Check for VPN services
        # TODO: Return service score
        pass

    def score_pivot_potential(self, host):
        """
        Calculate overall pivot potential score.

        Returns:
            Dictionary with scores and overall rating
        """
        # TODO: Calculate connectivity score
        # TODO: Calculate privilege score
        # TODO: Calculate service score
        # TODO: Compute weighted total
        # TODO: Return detailed scoring breakdown
        pass

    def identify_pivot_points(self):
        """Identify and rank all potential pivot points."""
        # TODO: Score all hosts in network
        # TODO: Sort by pivot potential
        # TODO: Return ranked list
        pass


if __name__ == "__main__":
    # TODO: Load network data
    # TODO: Instantiate scanner
    # TODO: Identify pivot points
    # TODO: Generate ranked report
    pass
```

> 📌 **Student Task:** Implement the pivot point identification logic and test with your network data.

---

### 📋 Step 4.2 — Create Pivot Execution Plan

**File:** `scripts/pivot_planner.py`

```python
#!/usr/bin/env python3
# File: scripts/pivot_planner.py


class PivotPlanner:
    """
    Generate execution plans for pivoting through network.
    """

    def __init__(self, network_map, pivot_points):
        self.network_map = network_map
        self.pivot_points = pivot_points

    def plan_pivot_chain(self, start, target):
        """
        Plan a chain of pivots from start to target.

        Args:
            start: Starting host
            target: Target host

        Returns:
            List of pivot steps with commands
        """
        # TODO: Find path through pivot points
        # TODO: Generate commands for each hop
        # TODO: Include port forwarding setup
        # TODO: Return detailed execution plan
        pass

    def generate_ssh_tunnel_commands(self, pivot_chain):
        """Generate SSH tunnel commands for pivot chain."""
        # TODO: Create dynamic port forwarding commands
        # TODO: Create local port forwarding commands
        # TODO: Create ProxyChains configuration
        pass

    def generate_cleanup_commands(self, pivot_chain):
        """Generate commands to clean up after pivoting."""
        # TODO: Kill SSH tunnels
        # TODO: Remove temporary files
        # TODO: Clear logs (for authorized testing only)
        pass


if __name__ == "__main__":
    # TODO: Load network map and pivot points
    # TODO: Plan pivot from compromised host to target
    # TODO: Generate execution commands
    # TODO: Save plan to file
    pass
```

> 📌 **Student Task:** Complete the pivot planner to generate actionable pivot strategies.

---

## ✅ Expected Outcomes

After completing this lab, you should have:

| # | Deliverable |
|---|---|
| 1️⃣ | Functional network discovery and reconnaissance scripts |
| 2️⃣ | PowerShell-based lateral movement simulation tools |
| 3️⃣ | BloodHound data generator and analyzer |
| 4️⃣ | Custom pivot point identification system |
| 5️⃣ | Understanding of attack path analysis |
| 6️⃣ | Practical experience with network topology mapping |

### 📦 Required Deliverables

- 📄 Network scan reports (JSON format)
- 📋 Lateral movement simulation logs
- 📊 BloodHound analysis reports with attack paths
- 🏆 Pivot point rankings and execution plans
- 🖼️ Visualization of attack paths

---

## 🛠️ Troubleshooting Tips

### ⚡ Network Simulator Services Won't Start

```bash
# Check if ports are already in use
netstat -tulpn

# Use different ports if needed and update network_simulator.py accordingly
```

### 💠 PowerShell Scripts Fail with Permission Errors

```bash
# Ensure scripts are executable
chmod +x script.ps1

# Run with explicit PowerShell invocation
pwsh -File script.ps1
```

### 🩸 BloodHound Data Analysis Produces Empty Results

- Verify JSON files are properly formatted
- Check that relationships reference **valid node IDs** from your generated data
- Use `python3 -m json.tool data/users.json` to validate JSON structure

### 📊 Graph Visualization Fails

```bash
# Install missing packages
pip3 install matplotlib networkx

# Ensure output directory exists
mkdir -p reports/
```

### 🔀 Pivot Scanner Returns No Candidates

- Verify network data includes **connectivity information** for each host
- Check that scoring thresholds in `score_pivot_potential()` aren't too restrictive
- Print intermediate scores to debug

---

## 📌 Conclusion & Key Takeaways

This lab provided hands-on experience with lateral movement and pivoting techniques used in network security assessments.

| 🔑 Concept | 📖 Summary |
|---|---|
| 🗺️ Network Topology | Discovering and mapping network topology is the first step in any assessment |
| 💻 Lateral Movement | PowerShell enables scripted simulation of movement between systems |
| 🩸 AD Attack Paths | BloodHound-style analysis reveals hidden paths to high-value targets |
| 🔀 Pivot Points | Systems with multi-segment access and high privileges are ideal pivots |
| 🔗 Multi-hop Traversal | Chains of SSH tunnels enable access through segmented networks |
| 🛡️ Best Defense | Network segmentation + least privilege + monitoring = effective protection |

---

## 🚀 Next Steps

- [ ] 🏁 Practice these techniques in authorized CTF environments
- [ ] 📖 Study real-world attack case studies involving lateral movement
- [ ] 🔧 Explore advanced pivoting tools (Metasploit routing, Cobalt Strike beacons)
- [ ] 🛡️ Research defensive countermeasures: network segmentation, Zero Trust
- [ ] 📊 Set up a SIEM to detect lateral movement indicators of compromise (IoCs)
- [ ] 🏢 Deep-dive into Active Directory security and hardening techniques

---

## 📂 File Structure

```
lateral_movement_lab/
├── 📄 README.md                            ← This file
├── scripts/
│   ├── 🐍 network_simulator.py             ← Task 1.2 — Simulated network services
│   ├── 💠 network_discovery.ps1            ← Task 1.3 — Network reconnaissance
│   ├── 💠 lateral_movement.ps1             ← Task 2.1 — Lateral movement functions
│   ├── 💠 execute_lateral_movement.ps1     ← Task 2.2 — Orchestration script
│   ├── 🐍 generate_bloodhound_data.py      ← Task 3.1 — AD data generator
│   ├── 🐍 bloodhound_analyzer.py           ← Task 3.2 — Attack path analyzer
│   ├── 🐍 visualize_paths.py               ← Task 3.3 — Path visualizer
│   ├── 🐍 pivot_scanner.py                 ← Task 4.1 — Pivot point scanner
│   └── 🐍 pivot_planner.py                 ← Task 4.2 — Pivot execution planner
├── data/
│   ├── 📄 users.json                       ← Generated AD users
│   ├── 📄 computers.json                   ← Generated AD computers
│   ├── 📄 groups.json                      ← Generated AD groups
│   └── 📄 relationships.json               ← Generated AD relationships
└── reports/
    ├── 📊 network_scan_report.json         ← Output from Task 1
    ├── 📋 lateral_movement_log.json        ← Output from Task 2
    ├── 📈 bloodhound_analysis.json         ← Output from Task 3
    └── 🗺️ pivot_plan.json                  ← Output from Task 4
```

---

<div align="center">

![Made with](https://img.shields.io/badge/Made%20with-❤️%20for%20Learning-blueviolet?style=for-the-badge)
![Al Nafi](https://img.shields.io/badge/Platform-Al%20Nafi-0a0a0a?style=for-the-badge)
![Ethical Hacking](https://img.shields.io/badge/Domain-Network%20Security-critical?style=for-the-badge&logo=hackthebox&logoColor=white)

> 🔒 *"Lateral movement is about understanding network relationships and trust boundaries. The best defense is network segmentation, least privilege, and comprehensive monitoring."*

</div>
