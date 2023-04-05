#!/bin/bash

refresh_rate=5

top_command="top -b -n 1 -o %CPU"
free_command="free -m"
df_command="df -h"

while true; do

  echo "=== $(date) ==="

  echo "Top processes by CPU usage:"
  $top_command | head -n 15

  echo "Memory usage:"
  $free_command

  echo "Disk usage:"
  $df_command

  sleep $refresh_rate

done
