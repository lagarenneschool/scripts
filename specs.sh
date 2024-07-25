#!/bin/bash

clear

echo "Hostname:"
hostname

echo "Model Number:"
sysctl hw.model

echo "CPU Specs:"
sysctl -n machdep.cpu.brand_string

echo "RAM Size (in bytes):"
ram_size_bytes=$(sysctl -n hw.memsize)
echo $ram_size_bytes

echo "RAM Size (in GB):"
ram_size_gb=$(echo "scale=2; $ram_size_bytes / (1024 * 1024 * 1024)" | bc)
echo $ram_size_gb

echo "Storage Information:"
diskutil list
echo "---------------------------------------"
diskutil info / | grep -E 'Device\ / Media\ Name:|Total\ Size:|Volume\ Free\ Space:|Disk\ Name:|Media\ Name:|File\ System:'
echo "---------------------------------------"

diskutil list | grep -E '^\s*\/dev\/' | while read -r line ; do
    disk=`echo $line | awk '{print $1}'`
    echo "Partition Information for $disk:"
    diskutil info $disk | grep -E 'Device\ / Media\ Name:|Total\ Size:|Volume\ Free\ Space:|Disk\ Name:|Media\ Name:|File\ System:'
    echo "---------------------------------------"
done
echo "a script to get hw info from a mac, written by mat :)"


