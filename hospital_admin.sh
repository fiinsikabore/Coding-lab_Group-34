<<<<<<< HEAD
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
=======
#!/usr/bin/env bash 


#Script: hospital_admin.sh
#Authors: Fatima (M1) & Quentin (M2)
#Objective :Initialze and secure KNH environments
# ____MEMBER 1(Fatima): THE ARCHITECT____
initialize_system(){
	echo "[*] Initializing Kenyatta National Hospital Digital Infrastructure..."

	local dirs=("active_logs" "archived_logs" "reports")

	for dir in "${dirs[@]}";do 
		if [ ! -d "$dir" ]; then 
			echo "[-] Directory '$dir' not found. Creating '$dir' directory..."
			mkdir -p "$dir"
		else
			echo "[+] Directory '$dir' already exists."
		fi 
	done 
}  
#----Member 1 : THE ORCHESTRATOR
main(){
	clear 
    echo "=================================================="
    echo "       KNH ADMIN SYSTEM INITIALIZATION            "
    echo "=================================================="

    initialize_system
    echo "--------------------------------------------------"

    echo "--------------------------------------------------"
    echo "[SUCCESS] System Environment Secured | $(date)"
    echo "=================================================="
}

main

>>>>>>> origin/feature/admin-init-flow
