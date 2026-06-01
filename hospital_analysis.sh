#!/bin/bash
process_vitals() {
	echo "Starting clinical analysis on live logs..."
	mkdir -p reports
if [ -f "active_logs/heart_rate.log" ] || [ -f "active_logs/temperature.log" ]; then
        grep "CRITICAL" active_logs/heart_rate.log active_logs/temperature.log 2>/dev/null | awk '{print $1, $2, $4}' > reports/critical_alerts.txt
        echo "Analysis complete. Alerts saved in reports/critical_alerts.txt"
    else
        echo "Warning: No active logs found. Is the medical engine running?"
    fi
}
process_vitals
