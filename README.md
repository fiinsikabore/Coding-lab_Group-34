# Coding-lab_Group-34 — KNH Digital Infrastructure

A shell scripting project simulating a secure data pipeline for Kenyatta National Hospital (KNH). Built by a 4-member DevOps team as part of the ALU Group Coding Lab.

## Team Members

| Name                   | Role                          | Responsibility                              |
|------------------------|-------------------------------|---------------------------------------------|
| Fatima Mohamed         | The Architect & Orchestrator  | initialize_system() and main execution flow |
| Quentin Ntore          | The Security Lead & Archivist | secure_data() and log rotation              |
| Fiinsi Kabore          | The Clinical Analyst          | process_vitals() and repo setup             |
| Regan Ayiecho          | The Facility Auditor          | water_audit() and ICU metrics               |

## Project Structure
Coding-lab_Group-34/
├── hospital_system.py      # Python engine — generates sensor data
├── hospital_admin.sh       # Sets up folders and secures permissions
├── hospital_analysis.sh    # Analyzes critical alerts and water usage
├── hospital_archive.sh     # Rotates and archives logs
├── .gitignore              # Excludes patient data from GitHub
└── README.md               # This file

## How to Run

Requirements: Python 3 and Git installed.

Step 1 — Clone the repo:
git clone https://github.com/fiinsikabore/Coding-lab_Group-34.git
cd Coding-lab_Group-34

Step 2 — Generate hospital data:
python3 hospital_system.py start
Wait 10 seconds, then press Ctrl+C

Step 3 — Run all scripts in order:
bash hospital_admin.sh
bash hospital_analysis.sh
bash hospital_archive.sh

Step 4 — Check the results:
cat reports/critical_alerts.txt
ls archived_logs/

## What Each Script Does

hospital_admin.sh — Creates the required directories (active_logs, archived_logs, reports) and locks down active_logs with chmod 700 so only the owner can access sensitive medical data.

hospital_analysis.sh — Scans heart rate and temperature logs for CRITICAL alerts using grep and awk, saves them to reports/critical_alerts.txt. Also calculates average water usage for the ICU_WATER_RESERVE device.

hospital_archive.sh — Moves current logs from active_logs to archived_logs with a timestamp in the filename, then recreates empty log files so the Python engine can continue.

## Git Collaboration

Each member worked on their own branch:
- Fatima: feature/admin-init-flow
- Quentin: feature/secure-data-archive
- Fiinsi: feature/clinical-vitals-analysis
- Regan: feature/water-utility-audit

All branches were merged into main via pull requests.
