#!/bin/bash
yum update -y
yum install -y httpd.x86_64
systemctl start httpd.x86_64
systemctl enable httpd.service
echo "Hello World from $(hostname -f)" > /var/www/html/index.html