#!/bin/bash
# Попросить пользователя ввести пароль MySQL
read -s -p "Введите пароль MySQL: " MYSQL_PASSWORD
echo
# Проверить, был ли введен пароль
if [ -z "$MYSQL_PASSWORD" ]; then
  echo "Пароль не был введен. Выход из скрипта."
  exit 1
fi
# MySQL пользователь и хост
MYSQL_USER="root"
MYSQL_HOST="127.0.0.1"
# SQL команды для создания пользователей, базы данных и назначения прав
SQL_COMMANDS="CREATE USER 'pterodactyl'@'$MYSQL_HOST' IDENTIFIED BY 'kozanostra';
CREATE USER 'wroot'@'$MYSQL_HOST' IDENTIFIED BY 'kozanostra';
CREATE DATABASE panel;
GRANT ALL PRIVILEGES ON panel.* TO 'pterodactyl'@'$MYSQL_HOST' WITH GRANT OPTION;
GRANT ALL PRIVILEGES ON *.* TO 'wroot'@'$MYSQL_HOST';
FLUSH PRIVILEGES;
exit"
# Выполнить SQL команды
mysql -u"$MYSQL_USER" -p"$MYSQL_PASSWORD" -h"$MYSQL_HOST" -e "$SQL_COMMANDS"
# Проверить код завершения команды mysql
if [ $? -eq 0 ]; then
  echo "Конфигурация MySQL выполнена успешно."
else
  echo "Ошибка: Конфигурация MySQL не удалась."
fi
