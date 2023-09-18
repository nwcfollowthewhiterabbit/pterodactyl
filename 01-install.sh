#/bin/bash
apt update
apt -y install software-properties-common curl apt-transport-https ca-certificates gnupg lsb-release gnupg2 nginx certbot python3-certbot-nginx

echo "deb https://packages.sury.org/php/ $(lsb_release -sc) main" | sudo tee /etc/apt/sources.list.d/sury-php.list
curl -fsSL  https://packages.sury.org/php/apt.gpg| sudo gpg --dearmor -o /etc/apt/trusted.gpg.d/sury-keyring.gpg

apt update
apt -y install php8.1 php8.1-{common,cli,gd,mysql,mbstring,bcmath,xml,fpm,curl,zip} mariadb-server  tar unzip git redis-server

curl -sS https://getcomposer.org/installer | sudo php -- --install-dir=/usr/local/bin --filename=composer
