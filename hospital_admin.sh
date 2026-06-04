#!/usr/bin/env bash 

#Script: hospital_admin.sh
#Authors: Fatima (M1) & Quentin (M2)
#Objective: Initialize and secure KNH environments

# ____MEMBER 1 (Fatima): THE ARCHITECT____
initialize_system(){
    echo "[*] Initializing Kenyatta National Hospital Digital Infrastructure..."

    local dirs=("active_logs" "archived_logs" "reports")

    for dir in "${dirs[@]}"; do 
        if [ ! -d "$dir" ]; then 
            echo "[-] Directory '$dir' not found. Creating '$dir' directory..."
            mkdir -p "$dir"
        else
            echo "[+] Directory '$dir' already exists."
        fi 
    done 
}  

# ____MEMBER 2 (Quentin): THE SECURITY LEAD____
secure_data() {
    echo "[*] Enforcing security permissions on medical logs..."

    if [ -d "active_logs" ]; then
        chmod 700 active_logs
        echo "[+] Permissions successfully applied to active_logs."

        echo "[*] Verification - Directory status:"
        ls -ld active_logs
    else
        echo "[ERROR] Active logs directory does not exist. Cannot secure data."
        exit 1
    fi
}

#---- MEMBER 1 (Fatima): THE ORCHESTRATOR ----
main(){
    clear 
    echo "=================================================="
    echo "       KNH ADMIN SYSTEM INITIALIZATION            "
    echo "=================================================="

    # Step 1: Fatima's system initialization runs first
    initialize_system
    echo "--------------------------------------------------"

    # Step 2: Quentin's security enforcement runs second
    secure_data
    echo "--------------------------------------------------"

    echo "[SUCCESS] System Environment Secured | $(date)"
    echo "=================================================="
}

main
