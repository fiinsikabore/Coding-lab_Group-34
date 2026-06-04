#!/usr/bin/env python3
import random
import time
import os
from datetime import datetime

LOG_DIR = "active_logs"

DEVICES = {
    "heart": [f"WARD_A_HR_{i:02d}" for i in range(1, 6)],
    "temp": [f"WARD_B_TEMP_{i:02d}" for i in range(1, 6)],
    "water": ["FACILITY_WATER_MAIN", "ICU_WATER_RESERVE"]
}

LOGS = {
    "heart": os.path.join(LOG_DIR, "heart_rate_log.log"),
    "temp": os.path.join(LOG_DIR, "temperature_log.log"),
    "water": os.path.join(LOG_DIR, "water_usage_log.log")
}

def ensure_environment():
    if not os.path.exists(LOG_DIR):
        os.makedirs(LOG_DIR)
    headers = {
        "heart": "Timestamp | Device_ID | Heart_Rate (BPM) | Status\n",
        "temp": "Timestamp | Device_ID | Temperature (Celsius) | Status\n",
        "water": "Timestamp | Device_ID | Usage (Liters/min) | Status\n"
    }
    for key, path in LOGS.items():
        if not os.path.exists(path) or os.stat(path).st_size == 0:
            with open(path, "w") as f:
                f.write(headers[key])

def generate_data():
    ensure_environment()
    print("[*] Generating hospital data... Press Ctrl+C to stop.")
    while True:
        timestamp = datetime.now().strftime("%Y-%m-%d %H:%M:%S")
        for device in DEVICES["heart"]:
            hr = random.randint(45, 150)
            status = "CRITICAL" if hr < 60 or hr > 100 else "WARNING" if 90 <= hr <= 100 else "NORMAL"
            with open(LOGS["heart"], "a") as f:
                f.write(f"{timestamp} | {device} | {hr} | {status}\n")
        for device in DEVICES["temp"]:
            temp = round(random.uniform(34.5, 40.5), 1)
            status = "CRITICAL" if temp > 38.0 or temp < 35.5 else "WARNING" if 37.5 <= temp <= 38.0 else "NORMAL"
            with open(LOGS["temp"], "a") as f:
                f.write(f"{timestamp} | {device} | {temp} | {status}\n")
        for device in DEVICES["water"]:
            usage = random.randint(5, 45)
            status = "HIGH_USAGE" if usage > 35 else "NORMAL"
            with open(LOGS["water"], "a") as f:
                f.write(f"{timestamp} | {device} | {usage} | {status}\n")
        time.sleep(1)

generate_data()
