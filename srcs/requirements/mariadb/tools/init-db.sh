#!/bin/bash

# Check if database is already initialized
if [ -d "/var/lib/mysql/$MYSQL_DATABASE" ]; then
    echo "Database already initialized, starting MariaDB..."
else
    echo "Initializing MariaDB database..."
    
    # Initialize MySQL data directory
    mysql_install_db --user=mysql --datadir=/var/lib/mysql
    
    # Start the MySQL service
    service mariadb start
    
    # Wait for MySQL to start
    while ! mysqladmin ping -h localhost --silent; do
        sleep 1
    done
    
    # Configure MySQL
    mysql -e "CREATE DATABASE IF NOT EXISTS $MYSQL_DATABASE;"
    mysql -e "CREATE USER IF NOT EXISTS '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_PASSWORD';"
    mysql -e "GRANT ALL PRIVILEGES ON $MYSQL_DATABASE.* TO '$MYSQL_USER'@'%';"
    
    # Set root password and secure the installation
    mysql -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '$MYSQL_ROOT_PASSWORD';"
    mysql -e "FLUSH PRIVILEGES;"
    
    # Stop the service so we can start it properly
    service mariadb stop
    
    echo "MariaDB initialized successfully!"
fi

# Start MariaDB in the foreground
exec mysqld_safe
