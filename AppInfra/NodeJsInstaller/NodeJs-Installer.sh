#!/bin/bash

sudo apt update -y


curl -fsSL https://deb.nodesource.com/setup_22.x | sudo -E bash -
sudo apt install -y nodejs

sudo apt install -y mysql-client

sudo npm install -g pm2

pm2 startup systemd -u ubuntu --hp /home/ubuntu

echo "Node.js version:"
node -v

echo "npm version:"
npm -v
  
echo "PM2 version:"
pm2 -v

echo "Node.js + PM2 installed successfully."


 cd /home/ubuntu

git clone https://github.com/zainkhan101345-ai/UsersApp

cd UsersApp

cat > .env <<EOF
DB_NAME=${DBNAME}
DB_USER=${DBUSER}
DB_PASS=${DBPASS}
DB_HOST=${rds_address}
EOF


source .env


npm install

sleep 20

mysql -h "${rds_address}" \
      -P 3306 \
      -u "$${DB_USER}" \
      -p"$${DB_PASS}" <<EOF

USE $${DB_NAME};

CREATE TABLE IF NOT EXISTS users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255),
    email VARCHAR(255)
);

EOF

pm2 start server.js --name UsersApp

pm2 save