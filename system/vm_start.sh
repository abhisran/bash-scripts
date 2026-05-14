#!/bin/bash
# Lab VM Startup Script
# Automates starting VMs on a remote Windows host via SSH and scheduled tasks.

TASK_NAME="StartVMs"
BAT_PATH="D:\\vmdk\\start_vms.bat"
EXPECTED_VMS=4

echo "Creating scheduled task on winlab..."
ssh winlab "schtasks /create /tn ${TASK_NAME} /tr \"${BAT_PATH}\" /sc once /st 00:00 /f" 2>/dev/null

echo "Starting VMs via scheduled task..."
ssh winlab "schtasks /run /tn ${TASK_NAME}" 2>/dev/null

echo "Waiting for VMs to boot..."
TIMEOUT=300
ELAPSED=0

while [ $ELAPSED -lt $TIMEOUT ]; do
    sleep 30
    ELAPSED=$((ELAPSED + 30))
    RUNNING=$(ssh winlab "vmrun list" 2>/dev/null | head -1 | grep -oE '[0-9]+')
    echo "  ${RUNNING:-0} / ${EXPECTED_VMS} VMs running (${ELAPSED}s elapsed)"
    if [ "${RUNNING:-0}" -ge "$EXPECTED_VMS" ] 2>/dev/null; then
        echo ""
        ssh winlab "vmrun list" 2>/dev/null
        break
    fi
done

if [ "${RUNNING:-0}" -lt "$EXPECTED_VMS" ] 2>/dev/null; then
    echo "Timed out waiting for VMs. Check log on winlab: D:\\vmdk\\start_vms.log"
    ssh winlab "vmrun list" 2>/dev/null
fi

echo "Cleaning up scheduled task..."
ssh winlab "schtasks /delete /tn ${TASK_NAME} /f" 2>/dev/null

echo "Full lab is up ✅"
