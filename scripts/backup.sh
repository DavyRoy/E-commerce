#!/bin/bash
set -e  # Exit on error

# Цвета для вывода
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo -e "${YELLOW}🗄️  PostgreSQL Backup Script${NC}"
echo "=================================="

# Конфигурация с переменными окружения из .env
BACKUP_DIR="./backups"
# Загружаем переменные из .env
if [ -f .env ]; then
    export $(grep -v '^#' .env | xargs)
else
    echo -e "${RED}❌ .env file not found! Please create it with the necessary variables.${NC}"
    exit 1
fi
echo -e "${GREEN}Loaded configuration from .env${NC}"
echo "CONTAINER_NAME=$CONTAINER_NAME"
echo "DB_USER=$DB_USER"
echo "DB_NAME=$DB_NAME"

#1. Создать папку для бэкапов. 
echo -e "\n${YELLOW}Step 1:${NC} Checking Backup direct..."
if [ ! -d "$BACKUP_DIR" ]; then
    echo -e "${GREEN}Creating backup directory at $BACKUP_DIR${NC}"
    mkdir -p "$BACKUP_DIR"
else
    echo -e "${GREEN}Backup directory already exists at $BACKUP_DIR${NC}"
fi

#2. Сохраняем файл бэкапа с именем, включающим дату и время. Данные из .env используются для подключения к базе данных
echo -e "\n${YELLOW}Step 2:${NC} Saving backup file..."
BACKUP_FILE="$BACKUP_DIR/$DB_NAME-$(date +%Y-%m-%d_%H-%M-%S).sql"
docker exec -t "$CONTAINER_NAME" pg_dump -U "$DB_USER" -d "$DB_NAME" > "$BACKUP_FILE"
echo -e "${GREEN}Created backup of database $DB_NAME${NC}"
echo -e "${GREEN}Container: $CONTAINER_NAME${NC}"
echo -e "${GREEN}Backup file: $BACKUP_FILE${NC}"

#3. Проверяем, что бэкап был успешно создан
if [ -f "$BACKUP_FILE" ]; then
    BACKUP_SIZE=$(du -h "$BACKUP_FILE" | cut -f1)
    echo -e "${GREEN}✅ Backup created successfully!${NC}"
    echo "   File: $BACKUP_FILE"
    echo "   Size: $BACKUP_SIZE"
else
    echo -e "${RED}❌ Backup failed!${NC}"
    exit 1
fi

#4. Удаляем старые бекапы
echo -e "\n${YELLOW}Step 3:${NC} Cleaning up old backups..."
OLD_BACKUPS=$(find "$BACKUP_DIR" -name "$DB_NAME-*.sql" -mtime +7 -print)
if [ -n "$OLD_BACKUPS" ]; then
    echo -e "${GREEN}Deleting old backups...${NC}"
    rm -f $OLD_BACKUPS
else
    echo -e "${GREEN}No old backups to delete${NC}"
fi