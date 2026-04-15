#!/bin/bash
set -e

GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

echo -e "${YELLOW}🚀 Setup Script${NC}"
echo "======================="

if [ "$1" == "--help" ]; then
    echo "Run all setup steps for the TechShop application."
    echo "Usage: ./scripts/setup.sh"
    exit 0
fi

# 1. docker command -v
echo -e "\n${YELLOW}Step 1:${NC} Checking Docker installation..."
if ! command -v docker &> /dev/null; then
    echo -e "   ${RED}Docker is not installed. Please install Docker and try again.${NC}"
    exit 1
fi
echo -e "   ${GREEN}Docker is installed.${NC}"

# 2. docker-compose command -v
echo -e "\n${YELLOW}Step 2:${NC} Checking Docker Compose installation..."
if ! command -v docker-compose &> /dev/null; then
    echo -e "   ${RED}Docker Compose is not installed. Please install Docker Compose and try again.${NC}"
    exit 1
fi
echo -e "   ${GREEN}Docker Compose is installed.${NC}"

#3. psql command -v
echo -e "\n${YELLOW}Step 3:${NC} Checking Postgres installation..."
if ! command -v psql &> /dev/null; then
    echo -e "   ${RED}Postgres is not installed. Please install Postgres and try again.${NC}"
    exit 1
else
    echo -e "   ${GREEN}Postgres is installed.${NC}"
fi

#4. git command -v
echo -e "\n${YELLOW}Step 4:${NC} Checking Git installation..."
if ! command -v git &> /dev/null; then
    cp .env.example .env
    echo -e "   ${RED}Git is not installed. Please install Git and try again.${NC}"
    exit 1
else
    echo -e "   ${GREEN}Git is installed.${NC}"
fi

echo -e "\n${GREEN}Setup complete.${NC}"