#!/bin/bash

LOG="/home/maxdrey/devops-training/phase1/project/health.log"
TIMESTAMP=$(date "+%Y-%m-%d %H:%M:%S")

echo "======================================================================================" >> $LOG

# CPU
idleCpu=$(top -bn1 | grep -i "Cpu(s)" | awk -F',' '{print $4}' | awk '{print $1}' | cut -d'.' -f1)
CpuUsage=$((100 - $idleCpu))
echo "[$TIMESTAMP] Cpu Idle    : $idleCpu%"  >> $LOG
echo "[$TIMESTAMP] Cpu Usage   : $CpuUsage%" >> $LOG

# Memory
MemAvail=$(free -m | grep -i "mem" | awk '{print $7}')
MemTotal=$(free -m | grep -i "mem" | awk '{print $2}')
MemUsage=$(( ($MemTotal - $MemAvail) * 100 / $MemTotal ))
MemAvailPercent=$((100 - $MemUsage))
echo "[$TIMESTAMP] Mem Available : $MemAvailPercent%" >> $LOG
echo "[$TIMESTAMP] Mem Usage     : $MemUsage%"        >> $LOG

# Disk
DiskUsage=$(df / | tail -1 | awk '{print $5}' | tr -d "%")
DiskAvail=$((100 - $DiskUsage))
echo "[$TIMESTAMP] Disk Available : $DiskAvail%" >> $LOG
echo "[$TIMESTAMP] Disk Usage     : $DiskUsage%" >> $LOG

# Alerts
if [ $CpuUsage -gt 80 ]; then
    echo "[$TIMESTAMP] ALERT! CPU is critical: $CpuUsage%" >> $LOG
fi
if [ $MemUsage -gt 80 ]; then
    echo "[$TIMESTAMP] ALERT! Memory is critical: $MemUsage%" >> $LOG
fi
if [ $DiskUsage -gt 80 ]; then
    echo "[$TIMESTAMP] ALERT! Disk is critical: $DiskUsage%" >> $LOG
fi
