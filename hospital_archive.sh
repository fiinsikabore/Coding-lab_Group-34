#!/usr/bin/env bash

rotate_logs() {
    local active_dir="active_logs"
    local archive_dir="archived_logs"
    local timestamp
    timestamp=$(date +"%Y%m%d_%H%M")

    echo "[*] Initiating secure log rotation process..."

    if [ ! -d "$active_dir" ] || [ ! -d "$archive_dir" ]; then
        echo "[ERROR] Environments uninitialized. Run admin script setup first."
        exit 1
    fi

    local targets=("heart_rate_log" "temperature_log" "water_usage_log")

    for log_base in "${targets[@]}"; do
        local source_file="${active_dir}/${log_base}.log"
        local destination_file="${archive_dir}/${log_base}_${timestamp}.log"

        if [ -f "$source_file" ]; then
            mv "$source_file" "$destination_file"
            echo "[+] Rotated: $source_file -> $destination_file"
            
            touch "$source_file"
            chmod 600 "$source_file"
        else
            echo "[-] System log path ${source_file} empty. Skipping rotation."
        fi
    done
    echo "[SUCCESS] Log rotation sequences accomplished."
}

rotate_logs
