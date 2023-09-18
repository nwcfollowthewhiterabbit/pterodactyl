#!/bin/bash

# Команда cron, которую вы хотите добавить
CRON_COMMAND="* * * * * php /var/www/pterodactyl/artisan schedule:run >> /dev/null 2>&1"

# Получить текущий список задач cron
current_cron=$(crontab -l 2>/dev/null)

# Проверить, был ли уже добавлен этот cron-команд
if echo "$current_cron" | grep -qF "$CRON_COMMAND"; then
  echo "Задача уже добавлена в cron."
else
  # Добавить новую задачу cron
  (echo "$current_cron"; echo "$CRON_COMMAND") | crontab -
  if [ $? -eq 0 ]; then
    echo "Задача успешно добавлена в cron."
  else
    echo "Ошибка: Не удалось добавить задачу в cron."
  fi
fi
