#!/bin/bash

# Download latest TLE data
TLE_FILE="/workspace/scripts/noaa.tle"
curl -s https://www.celestrak.com/NORAD/elements/noaa.txt -o $TLE_FILE

echo "✅ TLE data updated at $(date)"

