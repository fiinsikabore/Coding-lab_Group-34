#!/usr/bin/env bash
# Author: Regan Ayiecho | Role: Facility Auditor | Member 4
# ==========================================
# Script: hospital_analysis.sh
# Objective: Clinical and facility metrics analytics
# ==========================================

WATER_LOG="active_logs/water_usage_log.log"

# --- MEMBER 4: FACILITY AUDITOR ---
# Calculates average water flow for ICU_WATER_RESERVE device
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

water_audit
