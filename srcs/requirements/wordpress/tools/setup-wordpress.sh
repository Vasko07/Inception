#!/bin/bash

# Wait for database to be ready
while ! mysql -h mariadb -u ${MYSQL_USER} -p${MYSQL_PASSWORD} -e "SELECT 1" >/dev/null 2>&1; do
    echo "Waiting for MariaDB to be ready..."
    sleep 5
done

# Check if WordPress is already installed
if [ ! -f "wp-config.php" ]; then
    echo "WordPress not found, downloading..."
    # Download WordPress
    wp core download --allow-root
    
    # Create wp-config.php
    wp config create --allow-root \
        --dbname=${MYSQL_DATABASE} \
        --dbuser=${MYSQL_USER} \
        --dbpass=${MYSQL_PASSWORD} \
        --dbhost=mariadb \
        --path=/var/www/html
    
    # Install WordPress
    wp core install --allow-root \
        --url=${DOMAIN_NAME} \
        --title=${WP_TITLE} \
        --admin_user=${WP_ADMIN_USER} \
        --admin_password=${WP_ADMIN_PASSWORD} \
        --admin_email=${WP_ADMIN_EMAIL}
    
    # Create additional user
    wp user create --allow-root \
        ${WP_USER} \
        ${WP_USER_EMAIL} \
        --user_pass=${WP_USER_PASSWORD} \
        --role=author
        
    echo "WordPress installed successfully!"
else
    echo "WordPress already installed"
fi

# Make sure permissions are correct
chown -R www-data:www-data /var/www/html

# Start PHP-FPM
exec php-fpm7.4 -F
