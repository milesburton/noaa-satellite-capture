FROM debian:bullseye

ENV DEBIAN_FRONTEND=noninteractive

# 1️⃣ Install dependencies
RUN apt-get update && apt-get install -y \
    rtl-sdr \
    sox \
    git \
    python3 \
    python3-pip \
    wget \
    build-essential \
    nginx \
    noaa-apt \
    cron \
    predict \
    tree \
    vim \
    && apt-get clean

# 2️⃣ Create working directories
RUN mkdir -p /workspace/scripts /website /workspace/recordings /workspace/images \
    && chown -R www-data:www-data /website

# 3️⃣ Copy scripts before setting up cron (for better caching)
COPY ./scripts /workspace/scripts
RUN chmod +x /workspace/scripts/*.sh

# 4️⃣ Set up cron jobs (runs tle_update + schedule_passes every 6h)
RUN bash /workspace/scripts/setup_cron.sh

# 5️⃣ Serve website via Nginx
RUN ln -s /website /var/www/html/noaa

# 6️⃣ Optional: Run cron and nginx at startup
CMD service cron start && service nginx start && tail -f /dev/null

WORKDIR /workspace

# Copy startup script
COPY ./scripts/start_services.sh /start_services.sh
RUN chmod +x /start_services.sh

# CMD to start services and tail logs
CMD ["/start_services.sh"]

