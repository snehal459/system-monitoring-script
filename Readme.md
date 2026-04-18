# System Monitoring and Alerting Script

## Overview
This project is a Bash-based system monitoring script that checks:

- Disk usage
- Memory usage
- Top CPU-consuming processes
- Top Memory-consuming processes

It generates alerts if predefined thresholds are exceeded.

## Thresholds

- Disk usage threshold: 80%
- Memory usage threshold: 75%

You can modify these values inside the script.

## How to Run

```bash
chmod +x system_monitor.sh
./system_monitor.sh
