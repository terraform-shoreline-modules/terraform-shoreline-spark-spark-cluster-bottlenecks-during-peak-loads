

#!/bin/bash



# Check available memory

free_mem=$(free -m | awk 'NR==2{printf "%.2f%%", $4*100/$2}')

if (( $(echo "$free_mem 80" | bc -l) )); then

   echo "There is insufficient memory available to the Spark cluster"

fi



# Check CPU usage

cpu_usage=$(top -bn1 | grep load | awk '{printf "%.2f%%", $(NF-2)}')

if (( $(echo "$cpu_usage > 80" | bc -l) )); then

   echo "The Spark cluster is using too much CPU power"

fi



# Check disk space

free_disk=$(df -h / | awk '{print $4}' | tail -n 1 | sed 's/G//')

if (( $(echo "$free_disk 80" | bc -l) )); then

   echo "There is insufficient disk space available to the Spark cluster"

fi