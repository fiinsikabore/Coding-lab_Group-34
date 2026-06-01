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
