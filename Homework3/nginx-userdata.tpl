#! /bin/bash
sudo hostnamectl set-hostname server-${server_id}
sudo apt-get update
sudo apt-get install -y nginx
sudo apt-get install -y awscli
echo "<h1>Welcome to Grandpa's Whiskey-$HOSTNAME</h1>" | sudo tee /var/www/html/index.html
sudo systemctl start nginx
sudo systemctl enable nginx
sudo echo -e '#!/bin/bash\nsudo aws s3 cp /var/log/nginx/access.log  s3://zbeda-state/logs' >> /etc/cron.hourly/copy-log-to-s3.sh
sudo chmod 777 /etc/cron.hourly/copy-log-to-s3.sh