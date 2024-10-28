#!/bin/bash

# Verifica si Docker está instalado
if ! command -v docker &> /dev/null; then
    echo "Docker no está instalado. Procediendo con la instalación..."
    
    # Actualiza los paquetes e instala las dependencias necesarias
    sudo apt update
    sudo apt install -y apt-transport-https ca-certificates curl software-properties-common

    # Agrega la clave GPG oficial de Docker
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

    # Agrega el repositorio de Docker
    echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

    # Instala Docker
    sudo apt update
    sudo apt install -y docker-ce docker-ce-cli containerd.io
    echo "Docker se ha instalado correctamente."
else
    echo "Docker ya está instalado."
fi

# Verifica si Docker Compose está instalado
if ! command -v docker-compose &> /dev/null; then
    echo "Docker Compose no está instalado. Procediendo con la instalación..."
    
    # Define la versión de Docker Compose
    DOCKER_COMPOSE_VERSION="1.29.2"
    
    # Descarga y configura Docker Compose
    sudo curl -L "https://github.com/docker/compose/releases/download/${DOCKER_COMPOSE_VERSION}/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
    sudo chmod +x /usr/local/bin/docker-compose
    echo "Docker Compose se ha instalado correctamente."
else
    echo "Docker Compose ya está instalado."
fi

# Agrega el usuario actual al grupo de Docker para evitar el uso de 'sudo'
if ! groups $USER | grep -q '\bdocker\b'; then
    echo "Agregando al usuario actual al grupo de Docker..."
    sudo usermod -aG docker $USER
    echo "El usuario ha sido agregado al grupo Docker. Reinicia la sesión para aplicar los cambios."
else
    echo "El usuario ya pertenece al grupo Docker."
fi

# Finalización
echo "Instalación y configuración de Docker y Docker Compose completa."

