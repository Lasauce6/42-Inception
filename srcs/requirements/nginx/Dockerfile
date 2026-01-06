FROM debian:bookworm

# Update system
RUN apt update && apt upgrade -y

# Install nginx and openssl
RUN apt install nginx openssl -y

# Setup TLS
RUN mkdir -p /etc/nginx/ssl/
RUN openssl req -x509 -nodes -days 365 \
	-out /etc/nginx/ssl/inception.crt \
	-keyout /etc/nginx/ssl/inception.key \
	-subj "/C=FR/ST=IDF/L=Paris/O=42/OU=42/CN=rbaticle.42.fr/UID=rbaticle"

# Create necessary directories
RUN mkdir -p /var/run/nginx/

# Copy nginx configuration
COPY conf/default.conf /etc/nginx/sites-available/default

# Remove default nginx config if exists
RUN rm -f /etc/nginx/sites-enabled/default
RUN ln -s /etc/nginx/sites-available/default /etc/nginx/sites-enabled/

# Run nginx
CMD ["nginx", "-g", "daemon off;"]
