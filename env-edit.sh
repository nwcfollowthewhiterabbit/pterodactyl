#/bin/bash
# Попросить пользователя ввести новое значение для APP_URL
read -p "Введите новое значение для APP_URL: " APP_URL
# Проверить, было ли введено значение для APP_URL
if [ -z "$APP_URL" ]; then
  echo "Значение для APP_URL не было введено. Выход из скрипта."
  exit 1
fi
# Попросить пользователя ввести новое значение для DB_PASS
read -s -p "Введите новое значение для DB_PASS: " DB_PASS
echo
# Проверить, было ли введено значение для DB_PASS
if [ -z "$DB_PASS" ]; then
  echo "Значение для DB_PASS не было введено. Выход из скрипта."
  exit 1
fi
# Файл .env, который нужно отредактировать
ENV_FILE=".env"
# Выполнить замену значений в файле .env
sed -i "s/^APP_URL=.*/APP_URL=$APP_URL/" "$ENV_FILE"
sed -i "s/^DB_PASSWORD=.*/DB_PASSWORD=$DB_PASS/" "$ENV_FILE"
# Проверить, была ли замена успешной
if [ $? -eq 0 ]; then
  echo "Замена значений в файле $ENV_FILE выполнена успешно."
else
  echo "Ошибка: Замена значений в файле $ENV_FILE не удалась."
fi
