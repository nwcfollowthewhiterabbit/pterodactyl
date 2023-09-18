#/bin/bash
APP_URL=127.0.0.1
DB_PASS=kozanostra
ENV_FILE=".env"

sed -i "s/^APP_URL=.*/APP_URL=$APP_URL/" "$ENV_FILE"
sed -i "s/^DB_PASSWORD=.*/DB_PASSWORD=$DB_PASS/" "$ENV_FILE"

if [ $? -eq 0 ]; then
  echo "Замена значений в файле $ENV_FILE выполнена успешно."
else
  echo "Ошибка: Замена значений в файле $ENV_FILE не удалась."
