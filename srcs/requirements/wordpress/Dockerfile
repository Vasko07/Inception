FROM debian:bullseye

# Install dependencies
RUN apt-get update && apt-get install -y \
    php7.4 \
    php7.4-fpm \
    php7.4-mysql \
    php7.4-curl \
    php7.4-gd \
    php7.4-intl \
    php7.4-mbstring \
    php7.4-soap \
    php7.4-xml \
    php7.4-xmlrpc \
    php7.4-zip \
    wget \
    unzip \
    curl \
    mariadb-client \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Download WP-CLI
RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar -O /usr/local/bin/wp \
    && chmod +x /usr/local/bin/wp

# Configure PHP-FPM
RUN mkdir -p /run/php \
    && sed -i 's/listen = \/run\/php\/php7.4-fpm.sock/listen = 9000/g' /etc/php/7.4/fpm/pool.d/www.conf

# Create web directory
RUN mkdir -p /var/www/html

# Download and Install WordPress in Spanish
RUN wget https://es.wordpress.org/latest-es_ES.tar.gz -O /tmp/latest-es_ES.tar.gz \
    && tar -xvzf /tmp/latest-es_ES.tar.gz --strip-components=1 -C /var/www/html \
    && rm /tmp/latest-es_ES.tar.gz

# Set correct permissions
RUN chown -R www-data:www-data /var/www/html \
    && chmod -R 755 /var/www/html

# Set working directory
WORKDIR /var/www/html

# Copy WordPress setup script
COPY ./tools/setup-wordpress.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/setup-wordpress.sh

# Expose port for PHP-FPM
EXPOSE 9000

# Start PHP-FPM and WordPress setup
ENTRYPOINT ["/usr/local/bin/setup-wordpress.sh"]

