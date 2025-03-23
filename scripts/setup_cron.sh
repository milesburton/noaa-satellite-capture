#!/bin/bash

# Add TLE update every day at 00:00
(crontab -l ; echo "0 0 * * * bash /workspace/scripts/tle_update.sh") | crontab -

# Add pass scheduling every 6 hours
(crontab -l ; echo "0 */6 * * * bash /workspace/scripts/schedule_passes.sh") | crontab -

echo "✅ Cron jobs for TLE update and pass scheduling set."

