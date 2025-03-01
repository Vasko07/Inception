# Usar Debian Bullseye como imagen base
FROM debian:bullseye

# Instalar dependencias necesarias: PHP, extensiones y herramientas de WordPress
RUN apt update && apt install -y php-fpm php-mysql curl && \
    mkdir -p /var/www/html

# Descargar y configurar WordPress
RUN curl -O https://wordpress.org/latest.tar.gz && \
    tar -xzf latest.tar.gz && \
    rm latest.tar.gz && \
    mv wordpress/* /var/www/html && \
    chown -R www-data:www-data /var/www/html

# Configurar variables de entorno (tomadas desde el archivo .env en docker-compose)
ENV WORDPRESS_DB_HOST=mariadb:3306 \
    WORDPRESS_DB_USER=${MYSQL_USER} \
    WORDPRESS_DB_PASSWORD=${MYSQL_PASSWORD} \
    WORDPRESS_DB_NAME=${MYSQL_DATABASE}

# Exponer el puerto 9000, que es el puerto de PHP-FPM para la comunicación con NGINX
EXPOSE 9000

# Iniciar PHP-FPM en modo de primer plano para que el contenedor se mantenga en ejecución
CMD ["php-fpm7.4", "-F"]

