#/bin/bash
apt update
apt -y install software-properties-common curl apt-transport-https ca-certificates gnupg lsb-release gnupg2 nginx certbot python3-certbot-nginx
echo "deb https://packages.sury.org/php/ $(lsb_release -sc) main" | sudo tee /etc/apt/sources.list.d/sury-php.list
curl -fsSL  https://packages.sury.org/php/apt.gpg| sudo gpg --dearmor -o /etc/apt/trusted.gpg.d/sury-keyring.gpg
apt update
apt -y install php8.1 php8.1-{common,cli,gd,mysql,mbstring,bcmath,xml,fpm,curl,zip} mariadb-server  tar unzip git redis-server
curl -sS https://getcomposer.org/installer | sudo php -- --install-dir=/usr/local/bin --filename=composer
mkdir -p /var/www/pterodactyl
mv create-db.sh /var/www/pterodactyl/
mv env-edit.sh /var/www/pterodactyl/
mv cron-add.sh /var/www/pterodactyl/
mv edit-pterodactyl.conf.sh /var/www/pterodactyl/
cd /var/www/pterodactyl
curl -Lo panel.tar.gz https://github.com/pterodactyl/panel/releases/latest/download/panel.tar.gz
tar -xzvf panel.tar.gz
chmod -R 755 storage/* bootstrap/cache/
chmod +x create-db.sh
chmod +x env-edit.sh
chmod +x cron-add.sh
chmod +x edit-pterodactyl.conf.sh
sh create-db.sh
cp .env.example .env
sh env-edit.sh
composer install --no-dev --optimize-autoloader
php artisan key:generate --force
php artisan p:environment:setup
php artisan p:environment:database
php artisan migrate --seed --force
php artisan p:user:make
chown -R www-data:www-data /var/www/pterodactyl/*
sh cron-add.sh
cp pteroq.service /etc/systemd/system/
systemctl enable --now redis-server
systemctl enable --now pteroq.service
rm /etc/nginx/sites-enabled/default
cp pterodactyl-without-ssl.conf /etc/nginx/sites-available/
sh edit-pterodactyl.conf.sh
sudo ln -s /etc/nginx/sites-available/pterodactyl.conf /etc/nginx/sites-enabled/pterodactyl.conf
systemctl restart nginx
