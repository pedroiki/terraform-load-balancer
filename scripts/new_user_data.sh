#!/bin/bash

# Instala o Apache (httpd)
sudo yum update -y
sudo yum install httpd -y
sudo yum install git -y
sudo yum install python3 -y

# Instala as bibliotecas Python
sudo pip3 install flask
sudo pip3 install pymysql

# Clona o repo
git clone https://github.com/dallisonlima/tf_simple_architecture

# Inicia o Apache
sudo systemctl start httpd

# Reinicia o Apache para aplicar as alterações
sudo systemctl restart httpd

# Navega para o diretório do aplicativo
cd tf_simple_architecture/application

# Inicia o programa Python
python3 app.py
