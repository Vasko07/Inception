FROM debian:bullseye

# Install nginx and openssl
RUN apt-get update && apt-get install -y nginx openssl && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Create directories for SSL certificate and nginx configuration
RUN mkdir -p /etc/nginx/ssl

# Generate self-signed SSL certificate
RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
    -keyout /etc/nginx/ssl/nginx.key \
    -out /etc/nginx/ssl/nginx.crt \
    -subj "/C=ES/ST=Madrid/L=Madrid/O=42/OU=42/CN=gpinilla.42.fr"

# Copy nginx configuration
COPY ./conf/nginx.conf /etc/nginx/conf.d/default.conf

# Create directory for web files
RUN mkdir -p /var/www/html

# Expose port 443
EXPOSE 443

# Start nginx in foreground
CMD ["nginx", "-g", "daemon off;"]
