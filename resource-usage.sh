#!/bin/bash

#memory usage
free -m | head -n 2 >/home/arge/devops/mem.txt 

total_mem=$(awk '{print $2}' /home/arge/devops/mem.txt | tail -1)
used_mem=$(awk '{print $3}' /home/arge/devops/mem.txt | tail -1)
memory_usage=$((used_mem * 100 / total_mem))

if [ $memory_usage -ge 90 ]; then
    echo "-memory usage was exceeded- ${memory_usage}" >>/home/arge/devops/mem-log.txt
    /home/arge/devops/notifications.sh "DEV-Lin" "Memory Usage Exceeded = $memory_usage"
else
    echo "-memory- ${memory_usage}" >>/home/arge/devops/mem-log.txt
fi

#disk usage
df -h --type=ext4 >/home/arge/devops/disk.txt

disk_usage=$(awk '{print $5}' /home/arge/devops/disk.txt | tail -1)
disk_usage=$(echo $disk_usage | sed 's/%//')

if [ $disk_usage -ge 90 ]; then
    echo "-disk usage was exceeded- ${disk_usage}" >>/home/arge/devops/disk-log.txt
    /home/arge/devops/notifications.sh "DEV-Lin" "Disk Usage Exceeded = $disk_usage"
else
    echo "-disk- ${disk_usage}" >>/home/arge/devops/disk-log.txt
fi
