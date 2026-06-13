#!/bin/bash

# System Information Collection Script
# Students: Complete the TODO sections to collect comprehensive system data

TIMESTAMP=$(date +"%Y%m%d_%H%M%S")
OUTPUT_DIR="system_analysis_$TIMESTAMP"
mkdir -p "$OUTPUT_DIR"

echo "=== Starting System Information Collection ==="

# TODO: Collect basic system information
# Hint: Use hostname, uname, uptime, date commands
collect_system_info() {
    {
        echo "=== SYSTEM INFORMATION ==="
        # TODO: Add hostname
        # TODO: Add kernel version
        # TODO: Add OS release information
        # TODO: Add system uptime
    } > "$OUTPUT_DIR/system_info.txt"
}

# TODO: Collect user information
# Hint: Use who, last, lastb, /etc/passwd
collect_user_info() {
    {
        echo "=== USER INFORMATION ==="
        # TODO: List currently logged in users
        # TODO: Show last 20 login records
        # TODO: Show failed login attempts
        # TODO: List all system users
    } > "$OUTPUT_DIR/user_info.txt"
}

# TODO: Collect process information
# Hint: Use ps, pstree, top commands
collect_process_info() {
    {
        echo "=== PROCESS INFORMATION ==="
        # TODO: List all running processes sorted by CPU
        # TODO: Display process tree
        # TODO: Show top CPU consuming processes
    } > "$OUTPUT_DIR/process_info.txt"
}

# TODO: Collect network information
# Hint: Use ip, netstat, ss commands
collect_network_info() {
    {
        echo "=== NETWORK INFORMATION ==="
        # TODO: Show network interfaces
        # TODO: Display routing table
        # TODO: List active connections
        # TODO: Show listening services
    } > "$OUTPUT_DIR/network_info.txt"
}

# TODO: Collect filesystem information
# Hint: Use mount, df, find commands
collect_filesystem_info() {
    {
        echo "=== FILESYSTEM INFORMATION ==="
        # TODO: List mounted filesystems
        # TODO: Show disk usage
        # TODO: Find recently modified files in /var/log
    } > "$OUTPUT_DIR/filesystem_info.txt"
}

# Execute collection functions
collect_system_info
collect_user_info
collect_process_info
collect_network_info
collect_filesystem_info

echo "System information collection completed!"
echo "Results saved in: $OUTPUT_DIR"
