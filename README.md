# Server Health Monitor

Bash script that monitors CPU, memory, and disk usage.
Logs results with timestamps to health.log.
Alerts when any metric exceeds 80%.

## Usage
chmod +x health_monitor.sh
./health_monitor.sh

## Schedule (every 5 minutes)
crontab -e
*/5 * * * * /home/maxdrey/devops-training/phase1/project/health_monitor.sh

## What it monitors
- CPU usage
- Memory usage  
- Disk usage

## Alert threshold
80% — triggers an alert in the log file
