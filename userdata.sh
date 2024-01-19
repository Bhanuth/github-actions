#!/bin/bash
apt-get update
apt-get install -y nginx

# Create a directory to store the HTML file
mkdir /var/www/html

# Create a simple index.html file
echo "<html><head><title>Welcome to My Website</title></head><body><h1>Hello from EC2!</h1></body></html>" > /var/www/html/index.html

# Configure Nginx to serve the HTML file
cat > /etc/nginx/sites-available/default <<EOF
server {
    listen 80 default_server;
    server_name _;
    root /var/www/html;
    index index.html;

    location / {
        try_files \$uri \$uri/ =404;
    }
}
EOF

# Restart Nginx to apply changes
systemctl restart nginx
