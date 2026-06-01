#!/usr/bin/env bash
HEART_LOG="active_logs/heart_rate_log.log"
TEMP_LOG="active_logs/temperature_log.log"
WATER_LOG="active_logs/water_usage_log.log"

process_vitals() {
    echo "[*] Analyzing clinical engine data for CRITICAL alerts..."
if [ ! -f "$HEART_LOG" ] && [ ! -f "$TEMP_LOG" ]; then
        echo "[WARN] Data stream missing. Run the Python system engine first."
        return 1
    fi

mkdir -p reports

echo "--- CRITICAL PATIENT ALERTS DETECTED ---" > reports/critical_alerts.txt
    
    grep "CRITICAL" "$HEART_LOG" "$TEMP_LOG" 2>/dev/null | awk -F' ' \
    'BEGIN {OFS = "|"}
    {
        # Extract fields reliably clearing extra spaces
        timestamp = $1
        # If grep prefixes file names, isolate the true timestamp
        sub(/^.*\.log:/, "", timestamp)
        device_id = $2
        value = $4
        print timestamp, device_id, value
    }' >> reports/critical_alerts.txt

    echo "[+] Critical summary compiled into: reports/critical_alerts.txt"
}
main() {
    process_vitals
}

main
