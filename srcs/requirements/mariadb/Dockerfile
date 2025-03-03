FROM debian:bullseye

# Install MariaDB
RUN apt-get update && apt-get install -y mariadb-server && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Create directory for custom configuration
RUN mkdir -p /etc/mysql/conf.d

# Copy custom configuration
COPY ./conf/mariadb.cnf /etc/mysql/conf.d/

# Copy initialization script
COPY ./tools/init-db.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/init-db.sh

# Create directory for database files
RUN mkdir -p /var/lib/mysql

# Expose MySQL port
EXPOSE 3306

# Set entrypoint
ENTRYPOINT ["/usr/local/bin/init-db.sh"]
