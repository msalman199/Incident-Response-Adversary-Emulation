#!/bin/bash

# Audit Log Analysis Script
# Students: Complete the analysis functions

TIMESTAMP=$(date +"%Y%m%d_%H%M%S")
AUDIT_LOG="/var/log/audit/audit.log"
OUTPUT_DIR="audit_analysis_$TIMESTAMP"
mkdir -p "$OUTPUT_DIR"

echo "=== Starting Audit Log Analysis ==="

# TODO: Function to analyze specific audit events
# Hint: Use ausearch command with -k flag for key-based searches
analyze_events() {
    local event_type="$1"
    local description="$2"
    local output_file="$3"
    
    {
        echo "=== $description ==="
        echo "Analysis Date: $(date)"
        
        # TODO: Search for events using ausearch
        # TODO: Count total occurrences
        # TODO: Display summary statistics
        
    } > "$OUTPUT_DIR/$output_file"
}

# TODO: Analyze different event types
# Call analyze_events for: identity, logins, process_execution, privilege_escalation

# TODO: Analyze failed system calls
# Hint: Use ausearch with -sv no flag

# TODO: Generate summary report
# Include: event counts, top users, suspicious activity indicators

echo "Audit log analysis completed!"
echo "Results saved in: $OUTPUT_DIR"
