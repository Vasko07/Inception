# Usar Debian Bullseye como imagen base
FROM debian:bullseye

# Actualizar el sistema e instalar MariaDB
RUN apt update && apt install -y mariadb-server mariadb-client && \
    mkdir -p /var/lib/mysql /var/run/mysqld && \
    chown -R mysql:mysql /var/lib/mysql /var/run/mysqld

# Definir variables de entorno para MariaDB (serán sobreescritas por el .env en docker-compose)
ENV MYSQL_DATABASE=wordpress_db \
    MYSQL_USER=wp_user \
    MYSQL_PASSWORD=wp_password \
    MYSQL_ROOT_PASSWORD=root_password

# Exponer el puerto de MariaDB
EXPOSE 3306

# Comando de inicio de MariaDB
CMD ["mysqld"]

