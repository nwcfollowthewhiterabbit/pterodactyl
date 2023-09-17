#!/bin/bash
# Попросить пользователя ввести новое значение для server_dns_name
read -p "Введите новое значение для server_dns_name: " server_dns_name
# Проверить, было ли введено значение для server_dns_name
if [ -z "$server_dns_name" ]; then
  echo "Значение для server_dns_name не было введено. Выход из скрипта."
  exit 1
fi
# Файл конфигурации nginx (Pterodactyl.conf), который нужно отредактировать
NGINX_CONF_FILE="/etc/nginx/sites-available/pterodactyl-without-ssl.conf"
# Выполнить замену значения в файле конфигурации nginx
sed -i "s/server_name <domain>;$/server_name $server_dns_name;/" "$NGINX_CONF_FILE"
# Проверить, была ли замена успешной
if [ $? -eq 0 ]; then
  echo "Замена значения в файле $NGINX_CONF_FILE выполнена успешно."
else
  echo "Ошибка: Замена значения в файле $NGINX_CONF_FILE не удалась."
fi
