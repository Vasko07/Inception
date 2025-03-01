# Usar Debian Bullseye como imagen base
FROM debian:bullseye

# Instalar NGINX y OpenSSL para generar el certificado TLS
RUN apt update && apt install -y nginx openssl

# Crear un directorio para almacenar el certificado SSL
RUN mkdir -p /etc/nginx/ssl

# Generar un certificado autofirmado para TLS
RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
    -keyout /etc/nginx/ssl/nginx.key \
    -out /etc/nginx/ssl/nginx.crt \
    -subj "/C=US/ST=CA/L=SanFrancisco/O=42/OU=42/CN=${DOMAIN_NAME}"

# Copiar el archivo de configuración de NGINX
COPY ./conf/default.conf /etc/nginx/conf.d/default.conf

# Exponer el puerto 443 para HTTPS
EXPOSE 443

# Iniciar NGINX en modo de primer plano
CMD ["nginx", "-g", "daemon off;"]

