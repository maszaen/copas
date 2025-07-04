#!/bin/bash

LOG_FILE="/var/log/portscan_detection.log"
ALERT_THRESHOLD=10

echo "Starting port scan monitoring..."

while true; do
    netstat -an | grep SYN_RECV | awk '{print $5}' | cut -d: -f1 | sort | uniq -c | sort -n | tail -5 | while read count ip; do
        if [ $count -gt $ALERT_THRESHOLD ]; then
            echo "$(date): ALERT - Possible port scan detected from $ip ($count connections)" >> $LOG_FILE
            echo "$(date): ALERT - Possible port scan detected from $ip ($count connections)"
            
            sudo iptables -A INPUT -s $ip -j DROP
            echo "$(date): IP $ip blocked" >> $LOG_FILE
        fi
    done
    
    sleep 5
done
