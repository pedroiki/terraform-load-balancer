#!/bin/bash


# Instala o Apache (httpd)
sudo yum install httpd -y

# Inicia o Apache
sudo systemctl start httpd

# Obtém o ID da instância
instance_id=$(curl -s http://169.254.169.254/latest/meta-data/instance-id)

# Cria o arquivo index.html com o ID da instância
echo "ID da Instância: $instance_id" | sudo tee /var/www/html/index.html

# Reinicia o Apache para aplicar as alterações
sudo systemctl restart httpd
