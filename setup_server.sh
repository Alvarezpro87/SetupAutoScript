#!/bin/bash

# Espera 10 segundos para a inicialização completa da rede
sleep 10

# Captura o primeiro IP da máquina
IP_ADDRESS=$(hostname -I | awk '{print $1}')

# Captura o hostname
HOSTNAME=$(hostname)

# Atualizar o sistema

sudo yum -y update

# Verifica se o httpd está mascarado. Se estiver, desmascara.

if systemctl --quiet is-masked httpd; then

    sudo systemctl unmask httpd

    echo "httpd estava mascarado,mas agora não está mais."

fi

# Instala o httpd e o PHP
sudo yum -y install httpd php



# Habilita e inicia o httpd
sudo systemctl enable httpd

sudo systemctl start httpd



# Cria diretório para as páginas html/php
dir="/var/www/html/${HOSTNAME}.com"

sudo mkdir -p "$dir"

sudo chown -R apache:apache "$dir"

sudo chmod -R 755 "$dir"



# Copiar conteúdo para o diretório do site
if [ "$(ls -A /etc/content)" ]; then

    echo "Copiando conteúdo para o diretório do site..."

    sudo cp -r /etc/content/* "$dir/"

else

    echo "/etc/content está vazio. Nenhum conteúdo copiado."

fi

# Configuração do vHost
vhost_file="/etc/httpd/conf.d/${HOSTNAME}.com.conf"

echo "<VirtualHost *:80>

    ServerName ${HOSTNAME}.com

    DocumentRoot $dir

    <Directory $dir>

        AllowOverride All

        Require all granted

    </Directory>

</VirtualHost>" | sudo tee $vhost_file

# Configura o firewall
sudo firewall-cmd --permanent --add-service=http

sudo firewall-cmd --reload



# Atualiza /etc/hosts - Verifica se a entrada já existe
if ! grep -q "${HOSTNAME}.com" /etc/hosts; then

    echo "Adicionando ${IP_ADDRESS} ${HOSTNAME}.com ao /etc/hosts."

    echo "$IP_ADDRESS ${HOSTNAME}.com" | sudo tee -a /etc/hosts

else

    echo "A entrada para ${HOSTNAME}.com já existe no /etc/hosts."

fi

# Reinicia o httpd e verifica o status
sudo systemctl restart httpd



if systemctl --quiet is-active httpd; then

    echo "httpd ativo "

else

    echo "Falha na inicialização do httpd service.Verificando status..."

    sudo systemctl status httpd

fi

