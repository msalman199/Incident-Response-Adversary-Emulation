# Incident Containment Report

## Incident Overview
- **Incident ID**: INC-001-$(date '+%Y%m%d')
- **Detection Time**: $(date '+%Y-%m-%d %H:%M:%S')
- **Containment Time**: $(date '+%Y-%m-%d %H:%M:%S')
- **Severity Level**: Medium (Training Simulation)

## Containment Actions Taken

### Immediate Actions
1. **Process Termination**
   - Killed suspicious 'yes' process consuming high CPU
   - Terminated any related malicious processes
   - Verified process termination through system monitoring

2. **File Quarantine**
   - Moved suspicious_file.txt to quarantine directory
   - Isolated fake_malware.sh script
   - Preserved file metadata and timestamps

3. **Network Isolation**
   - Identified suspicious network activity
   - Documented connection attempts for analysis
   - Prepared firewall rules for IP blocking (simulated)

### Evidence Preservation
- Captured volatile system data before containment
- Preserved process lists and network connections
- Documented system state at time of incident

## Current Status
- **Threat Contained**: Yes
- **System Operational**: Yes
- **Evidence Secured**: Yes
- **Next Phase**: Recovery and Analysis

## Recommendations
1. Proceed with detailed forensic analysis
2. Implement additional monitoring
3. Review security policies and procedures
4. Conduct lessons learned session
