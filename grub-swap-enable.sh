#!/bin/bash

# Путь к файлу конфигурации GRUB
GRUB_CONFIG_FILE="/etc/default/grub"

# Строка, которую нужно добавить к GRUB_CMDLINE_LINUX_DEFAULT
APPEND_STRING="swapaccount=1"

# Проверить, существует ли файл конфигурации GRUB
if [ -f "$GRUB_CONFIG_FILE" ]; then
  # Найти текущее значение GRUB_CMDLINE_LINUX_DEFAULT
  CURRENT_LINE=$(grep -oP 'GRUB_CMDLINE_LINUX_DEFAULT="\K[^"]*' "$GRUB_CONFIG_FILE")

  # Добавить APPEND_STRING к текущему значению
  NEW_LINE="GRUB_CMDLINE_LINUX_DEFAULT=\"$CURRENT_LINE $APPEND_STRING\""

  # Заменить строку в файле конфигурации
  sed -i "s|GRUB_CMDLINE_LINUX_DEFAULT=.*|$NEW_LINE|" "$GRUB_CONFIG_FILE"

  echo "Настройки GRUB обновлены: $NEW_LINE"
else
  echo "Файл конфигурации GRUB ($GRUB_CONFIG_FILE) не найден."
  exit 1
fi
