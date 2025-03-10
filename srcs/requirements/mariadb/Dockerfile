FROM debian:bullseye

# Instalar MariaDB
RUN apt-get update && apt-get install -y mariadb-server && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# Crear el directorio del socket y darle permisos correctos
RUN mkdir -p /run/mysqld && chown -R mysql:mysql /run/mysqld && chmod 777 /run/mysqld

# Copiar la configuración personalizada de MariaDB
COPY conf/mariadb.cnf /etc/mysql/mariadb.conf.d/99-custom.cnf
COPY conf/init.sql /docker-entrypoint-initdb.d/

# Exponer puerto
EXPOSE 3306

# Ejecutar MariaDB y forzar la ejecución del script de inicialización
CMD ["bash", "-c", "mysqld --init-file=/docker-entrypoint-initdb.d/init.sql"]

