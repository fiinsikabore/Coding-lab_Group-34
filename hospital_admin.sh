#!/usr/bin/env bash 


#Script: hospital_admin.sh
#Authors: Fatima (M1) & Quentin (M2)
#Objective :Initialze and secure KNH environments
# ____MEMBER 1(Fatima): THE ARCHITECT____
initialize_system(){
	echo "[*] Initializing Kenyatta National Hospital Digital Infrastructure..."

	local dirs=("active_logs" "archived_logs" "reports")

	for dir in "${dirs[@]}";do 
		if [ ! -d "$dir"]; then 
			echo "[-] Directory '$dir' not found. Creating '$dir' directory..."
			mkdir -p "$dir"
		else
			echo "[+] Directory '$dir' already exists."
		fi 
	done 
}  
