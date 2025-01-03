# Basic server monitoring script for Linux


echo "Server Performace"
echo "================="


time_start=$(date +%s)

echo -e "\n CPU Usage:"
usage=$(top -bn1 | grep -i  "Cpu(s)" | awk '{print $2 + $4}')
echo "Current usage: $usage%"

echo -e "\n Memory Usage:"
m_usage=$(free -m | awk 'NR==2{printf "used: %sMB | Free: %sMB | Total: %sMB | Usage: %.2f%%\n", $3, $4, $2, $3+100/$2}')
echo "Current usage: $m_usage"

echo -e "\n Disk Usage:"
d_usage=$(df -h --total | grep 'total' | awk '{printf "Used %s | Free: %s | Usage %s\n", $3, $4, $5}')
echo "Current usage: $d_usage"

echo -e "\n Top 5 Processes (CPU Usage):"
ps -eo pid,ppid,cmd,%mem,%cpu --sort=-%cpu | head -n 6

echo -e "\n Top 5 Processes (Memory Usage):"
ps -eo pid,ppid,cmd,%mem,%cpu --sort=-%mem | head -n 6

echo -e "\n Uptime: "
uptime -p

echo -e "\n OS Version:"
cat /etc/os-release | grep -w "PRETTY_NAME" | cut -d= -f2 | tr -d '"'

time_end=$(date +%s)

runtime=$((time_end - time_start))

echo -e "\n Script Complete"
echo "Total runtime: $runtime secs"

echo
