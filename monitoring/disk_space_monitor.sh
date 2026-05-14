#!/bin/bash
# Disk Space Usage Monitor

THRESHOLD=80
USAGE=$(df -h / | grep / | awk '{print $5}' | sed 's/%//')

if [ "$USAGE" -ge "$THRESHOLD" ]; then
  echo "CRITICAL: Disk space is low. Usage: $USAGE%"
else
  echo "OK: Disk space is sufficient. Usage: $USAGE%"
fi
