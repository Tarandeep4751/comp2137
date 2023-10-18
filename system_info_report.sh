#!/bin/bash

# Author: Tarandeep Singh
# Date/Time: October 18, 2023

# System Information
echo -e "\nSystem Report generated by $(whoami), $(date)\n"

# Hostname
hostname=$(hostname)
echo "System Information
------------------"
echo "Hostname: $hostname"

# Operating System
os_info=$(source /etc/os-release; echo "$NAME $VERSION")
echo "OS: $os_info"

# Uptime
uptime_info=$(uptime -p)
echo "Uptime: $uptime_info"

# Hardware Information
echo -e "\nHardware Information
--------------------"
# CPU
cpu_info=$(lscpu | grep "Model name" | cut -d: -f2 | sed 's/^[[:space:]]*//')
cpu_speed_info=$(lscpu | grep "CPU max MHz" | cut -d: -f2 | sed 's/^[[:space:]]*//')

echo "CPU: $cpu_info"
echo "Speed: $cpu_speed_info MHz"

# RAM
ram_info=$(free -h | awk '/Mem:/ {print $2}')
echo "RAM: $ram_info"

# Disks (Active Only)
disks_info=$(lsblk -o NAME,MODEL,SIZE | grep -v "NAME" | awk '$3 > 0')
echo "Disk(s):"
echo "$disks_info"


# Video Card
video_card_info=$(lspci | grep -i "VGA" | cut -d: -f3 | sed 's/^[[:space:]]*//')
echo "Video: $video_card_info"

# Network Information
echo -e "\nNetwork Information
-------------------"
# FQDN
fqdn_info=$(hostname -f)
echo "FQDN: $fqdn_info"

# Host Address
ip_info=$(ip a | grep -E 'inet ' | grep -v "127.0.0.1" | awk '{print $2}')
echo "Host Address: $ip_info"

# Gateway IP
gateway_info=$(ip r | awk '/default/ {print $3}')
echo "Gateway IP: $gateway_info"

# DNS Server
dns_info=$(cat /etc/resolv.conf | awk '/nameserver/ {print $2}')
echo "DNS Server: $dns_info"

# Interface Name
interface_info=$(ip a | grep -E 'inet ' | grep -v "127.0.0.1" | awk '{print $7}')
echo "Interface Name: $interface_info"

# IP Address (CIDR format)
ip_cidr_info=$(ip a | grep -E 'inet ' | grep -v "127.0.0.1" | awk '{print $2}')
echo "IP Address: $ip_cidr_info"

# System Status
echo -e "\nSystem Status
-------------"
# Users Logged In
users_logged_in=$(who | cut -d ' ' -f 1 | sort | uniq | tr '\n' ', ')
echo "Users Logged In: $users_logged_in"

# Disk Space
disk_space_info=$(df -h | awk '/^\/dev/ {print $6 " " $4}')
echo "Disk Space:"
echo "$disk_space_info"

# Process Count
process_count=$(ps aux | wc -l)
echo "Process Count: $process_count"

# Load Averages
load_average_info=$(cat /proc/loadavg | awk '{print $1, $2, $3}')
echo "Load Averages: $load_average_info"

# Memory Allocation
memory_info=$(free -h | awk '/Mem:/ {print "Total: " $2, "Used: " $3, "Free: " $4"}')
echo "Memory Allocation: $memory_info"

# Listening Network Ports
listening_ports_info=$(ss -tuln | awk 'NR>1 {print $5}' | cut -d: -f2 | sort -n | uniq | tr '\n' ', ')
echo "Listening Network Ports: $listening_ports_info"

# UFW Rules
ufw_rules_info=$(sudo ufw show added | awk '/[0-9]+\/[a-z]+/ {print $1}' | tr '\n' ', ')
echo "UFW Rules: $ufw_rules_info"

# End of report
echo -e "\n"
