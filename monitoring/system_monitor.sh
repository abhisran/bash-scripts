#!/bin/bash
# System CPU Usage Monitor

cpu_usage=$(top -bn1 | grep "Cpu(s)" | awk '{print $2 + $4}')

echo "Current CPU Usage: $cpu_usage%"
