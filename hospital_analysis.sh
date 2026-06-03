#!/usr/bin/env bash
# ==========================================
# Script: hospital_analysis.sh
# Objective: Clinical and facility metrics analytics
# ==========================================

HEART_LOG="active_logs/heart_rate_log.log"
TEMP_LOG="active_logs/temperature_log.log"
WATER_LOG="active_logs/water_usage_log.log"

# --- MEMBER 3: CLINICAL ANALYST ---
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
        timestamp = $1
        sub(/^.*\.log:/, "", timestamp)
        device_id = $2
        value = $4
        print timestamp, device_id, value
    }' >> reports/critical_alerts.txt
    echo "[+] Critical summary compiled into: reports/critical_alerts.txt"
}

# --- MEMBER 4: FACILITY AUDITOR ---
water_audit() {
    echo "[*] Executing infrastructure utility audit..."
    if [ ! -f "$WATER_LOG" ]; then
        echo "[WARN] Water telemetry logs unavailable."
        return 1
    fi
    awk -F ' | ' '
    BEGIN { sum = 0; count = 0 }
    {
        dev = $2; gsub(/^ *| *$/, "", dev);
        val = $3; gsub(/^ *| *$/, "", val);
        if (dev == "ICU_WATER_RESERVE") {
            sum += val
            count++
        }
    }
    END {
        print "\n=============================================="
        print "       KNH INFRASTRUCTURE REPORT             "
        print "=============================================="
        if (count > 0) {
            printf " TARGET DEVICE : ICU_WATER_RESERVE\n"
            printf " LOG ENTRIES   : %d data packets\n", count
            printf " AVG WATER FLOW: %.2f Liters/min\n", sum / count
        } else {
            print " [!] ALERT: No metric logs captured for ICU_WATER_RESERVE."
        }
        print "==============================================\n"
    }' "$WATER_LOG"
}

# --- RUN BOTH ---
main() {
    process_vitals
    water_audit
}

main
