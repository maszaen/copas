#!/bin/bash

LOGFILE="/var/log/portscan_detection.log"
MAIL_RECIPIENT="admin@localhost"

tail -f $LOGFILE | while read line; do
    if echo "$line" | grep -q "ALERT"; then
        echo "$line" | mail -s "Security Alert" $MAIL_RECIPIENT
        echo "Alert sent: $line"
    fi
done
