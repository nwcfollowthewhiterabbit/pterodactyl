#!/bin/bash
echo "deb http://nginx.org/packages/debian `lsb_release -cs` nginx" | tee /etc/apt/sources.list.d/nginx.list
curl -fsSL https://nginx.org/keys/nginx_signing.key | apt-key add -

wget https://repo.percona.com/apt/percona-release_latest.$(lsb_release -sc)_all.deb
dpkg -i percona-release_latest.$(lsb_release -sc)_all.deb
percona-release setup ps80


mkdir -p /etc/pterodactyl
curl -L -o /usr/local/bin/wings "https://github.com/pterodactyl/wings/releases/latest/download/wings_linux_$([[ "$(uname -m)" == "x86_64" ]] && echo "amd64" || echo "arm64")"
chmod u+x /usr/local/bin/wings

apt install mysql-server


Прописываем параметры по пути /etc/mysql/conf.d/z_custom.cnf

[mysqld]
thread_pool_size = 24
sql_mode=''
skip_ssl
disable_ssl
default_authentication_plugin=mysql_native_password

wget https://repo.zabbix.com/zabbix/6.2/debian/pool/main/z/zabbix-release/zabbix-release_6.2-4+debian11_all.deb
dpkg -i zabbix-release_6.2-4+debian11_all.deb

curl -sSL https://get.docker.com/ | CHANNEL=stable bash
systemctl enable --now docker

curl -fsSL https://deb.nodesource.com/setup_16.x | sudo -E bash -
apt update && apt upgrade -y

curl https://get.acme.sh | sh

apt install -y percona-server-server percona-server-common percona-xtrabackup-80 nginx nodejs borgbackup unzip zabbix-agent2 nfs-common
npm -g i pm2
