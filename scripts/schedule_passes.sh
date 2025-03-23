#!/bin/bash

TLE_FILE="/workspace/scripts/noaa.tle"
SATELLITES=("NOAA 15" "NOAA 18" "NOAA 19")
LAT="51.5"  # Set your latitude (e.g., London)
LON="-0.1"  # Set your longitude
ELEVATION="15"  # Minimum elevation in degrees for a valid pass
DURATION_BUFFER=2  # Buffer time (minutes) before and after pass

echo "📅 Scheduling satellite passes..."

# Clear previous jobs
crontab -l | grep -v "capture_noaa.sh" | crontab -

for SAT in "${SATELLITES[@]}"; do
    # Use 'predict' to find passes in next 12 hours
    PREDICT_OUTPUT=$(predict -t $TLE_FILE -p "$SAT" -l $LAT,$LON,0 | head -n 10)
    echo "$PREDICT_OUTPUT" | while read LINE; do
        # Extract pass start time (epoch)
        PASS_TIME=$(echo "$LINE" | awk '{print $1}')
        if [[ "$PASS_TIME" =~ ^[0-9]+$ ]]; then
            # Convert epoch to minute & hour for cron
            CRON_MIN=$(date -d @$PASS_TIME +%M)
            CRON_HOUR=$(date -d @$PASS_TIME +%H)
            CMD="bash /workspace/scripts/capture_noaa.sh \"$SAT\""
            (crontab -l ; echo "$CRON_MIN $CRON_HOUR * * * $CMD") | crontab -
            echo "🕒 Scheduled $SAT at $CRON_HOUR:$CRON_MIN"
        fi
    done
done

