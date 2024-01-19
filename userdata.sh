#!/bin/bash
yum update -y
yum install -y nginx

# Create a directory to store the HTML file
mkdir /usr/share/nginx/html

# Create a simple index.html file
echo "<html><head><title>Welcome to My Website</title></head><body><h1>Hello from EC2 on Amazon Linux!</h1></body></html>" > /usr/share/nginx/html/index.html

# Configure Nginx to serve the HTML file
cat > /etc/nginx/nginx.conf <<EOF
user nginx;
worker_processes auto;
error_log /var/log/nginx/error.log;
pid /var/run/nginx.pid;

events {
    worker_connections 1024;
}

http {
    log_format main '$remote_addr - $remote_user [$time_local] "$request" '
                      '$status $body_bytes_sent "$http_referer" '
                      '"$http_user_agent" "$http_x_forwarded_for"';

    access_log /var/log/nginx/access.log main;

    sendfile on;
    tcp_nopush on;
    tcp_nodelay on;
    keepalive_timeout 65;
    types_hash_max_size 2048;

    include /etc/nginx/mime.types;
    default_type application/octet-stream;

    server {
        listen 80 default_server;
        server_name _;
        root /usr/share/nginx/html;
        index index.html;

        location / {
            try_files \$uri \$uri/ =404;
        }
    }
}
EOF

# Start Nginx and enable it to start on boot
systemctl start nginx
systemctl enable nginx
