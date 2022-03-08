#! /bin/bash
sudo hostnamectl set-hostname server-${server_id}
sudo apt-get update
sudo apt-get install -y nginx
echo "<h1>Welcome to Grandpa's Whiskey-$HOSTNAME</h1>" | sudo tee /var/www/html/index.html
sudo systemctl start nginx
sudo systemctl enable nginx
