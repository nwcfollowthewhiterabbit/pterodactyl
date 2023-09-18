#/bin/bash
sh grub-swap-enable.sh
curl -Lo panel.tar.gz https://github.com/pterodactyl/panel/releases/latest/download/panel.tar.gz
tar -xzvf panel.tar.gz
chmod -R 755 storage/* bootstrap/cache/
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
cp pterodactyl.conf /etc/nginx/sites-available/
sh edit-pterodactyl.conf.sh
ln -s /etc/nginx/sites-available/pterodactyl.conf /etc/nginx/sites-enabled/pterodactyl.conf
systemctl restart nginx
curl -sSL https://get.docker.com/ | CHANNEL=stable bash
systemctl enable --now docker


