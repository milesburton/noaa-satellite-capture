#!/bin/bash
echo "🚀 Starting services inside Dev Container..."

# Start cron
service cron start
echo "✅ Cron started."

# Start nginx
service nginx start
echo "✅ Nginx started."

# Tail logs to keep container running
echo "📜 Tailing logs... (Press Ctrl+C to stop)"
tail -f /var/log/syslog /var/log/nginx/access.log /var/log/nginx/error.log

