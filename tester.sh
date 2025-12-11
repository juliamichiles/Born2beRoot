#!/bin/bash

divider() { printf "\n-----------------------------\n\n"; }

echo "BORN2BEROOT - DEBIAN SELF-CHECK SCRIPT"
echo "This script only performs NON-destructive checks."
divider

### HOSTNAME CHECK ###
echo "[1] Checking hostname format (should be login42):"
hostnamectl hostname
divider

### CHECK CURRENT USER AND GROUPS ###
echo "[2] Checking your login user groups (should include sudo and user42):"
echo "User: $USER"
id $USER
divider

### CHECK UFW ###
echo "[3] Checking UFW status:"
sudo ufw status verbose
divider

### CHECK SSH STATUS ###
echo "[4] Checking SSH service status:"
systemctl status ssh --no-pager | grep -E "Active|Loaded"
divider

echo "[5] Checking SSH configuration (port 4242, root login disabled):"
grep -E "Port|PermitRootLogin" /etc/ssh/sshd_config
divider

### CHECK APPARMOR ###
echo "[6] Checking AppArmor status:"
sudo aa-status
divider

### CHECK SUDO CONFIGURATION ###
echo "[7] Checking sudoers rules existence (NOT printing full file for safety):"
echo "Looking for required directives..."
grep -E "log_output|passwd_tries|badpass_message|requiretty" /etc/sudoers /etc/sudoers.d/* 2>/dev/null
divider

echo "[8] Checking /var/log/sudo/ exists and contains logs:"
ls -l /var/log/sudo/
divider

### CHECK PASSWORD POLICY ###
echo "[9] Checking password policy (login.defs & pam_pwquality):"
echo "Extracting relevant lines from /etc/login.defs:"
grep -E "PASS_MAX_DAYS|PASS_MIN_DAYS|PASS_WARN_AGE" /etc/login.defs
echo
echo "Checking /etc/pam.d/common-password:"
grep -E "pam_pwquality" /etc/pam.d/common-password
divider

### CHECK PARTITIONS ###
echo "[10] Checking LVM and encrypted partitions:"
lsblk
echo
echo "LVM status:"
sudo lvscan
divider

### CHECK RUNNING SERVICES ###
echo "[11] Checking that required services are active:"
for svc in ufw ssh; do
    echo "- $svc:"
    systemctl is-active $svc
done
divider

### CHECK USER AND GROUP 'evaluating' (created during eval) ###
echo "[12] Checking if the group 'evaluating' exists (only present AFTER peer evaluation):"
getent group evaluating
divider

### CHECK MONITORING.SH ###
echo "[13] Checking monitoring.sh existence, permissions, and ownership:"
locate monitoring.sh 2>/dev/null || echo "monitoring.sh not found via locate; checking manually..."
echo
find / -maxdepth 3 -name monitoring.sh 2>/dev/null
echo
if [ -f /usr/local/bin/monitoring.sh ]; then
    ls -l /usr/local/bin/monitoring.sh
fi
divider

### CHECK CRON JOB FOR MONITORING.SH ###
echo "[14] Checking cron job (should run every 10 minutes on boot):"
echo "System cron entries for root:"
sudo crontab -l
divider

### CHECK CPU / RAM / DISK VALUES (for debugging monitoring.sh) ###
echo "[15] Gathering data that monitoring.sh should normally display:"
echo "- Architecture:"
uname -a
echo
echo "- CPU physical:"
lscpu | grep "Socket(s)"
echo "- vCPU:"
nproc
echo
echo "- Memory:"
free -h
echo
echo "- Disk:"
df -h /
echo
echo "- CPU Load:"
top -bn1 | grep "Cpu(s)"
echo
echo "- Last boot:"
who -b
echo
echo "- LVM active?:"
sudo lvscan | grep ACTIVE
echo
echo "- Active TCP connections:"
ss -t state established | wc -l
echo
echo "- Logged-in users:"
who | wc -l
echo
echo "- IPv4 + MAC:"
ip -4 a | grep inet
ip link | grep link/ether
echo
echo "- Sudo command count:"
grep -c "COMMAND=" /var/log/sudo/* 2>/dev/null
divider

echo "All automated checks completed."
echo "Scroll up to review each section."
echo "---"
echo "WARNING: some of the requested tests are not checked here and must be done \"manually\", they are:"
echo "- Reboot hostname persistence
- Creating a new user during evaluation
- Adding group during evaluation
- Demonstrating cron triggering on reboot
- Stopping monitoring.sh without modifying it
- Verifying no snapshots exist
- Verifying password creation rules manually
- Verifying SSH login with the new evaluation user
- And obviously anything regarding explanations"
