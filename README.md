<div align="center">

# 🛒 TechShop E-commerce Platform

### Modern Full-Stack E-commerce with DevOps Best Practices

[![Docker](https://img.shields.io/badge/docker-ready-blue?logo=docker)](https://www.docker.com/)
[![License](https://img.shields.io/badge/license-MIT-green)](LICENSE)
[![Live Demo](https://img.shields.io/badge/demo-live-success)](https://e-commerce-9rcc.onrender.com)

[Features](#-features) • [Quick Start](#-quick-start) • [Documentation](#-documentation) • [API](#-api-reference) • [Monitoring](#-monitoring)


</div>

---

## 📖 Содержание

- [Обзор](#-обзор)
- [Уровни проекта](#-уровни-проекта)
- [Архитектура](#-архитектура)
- [Tech Stack](#-tech-stack)
- [Что реализовано](#-что-реализовано)
- [Быстрый старт](#-быстрый-старт)
- [API Reference](#-api-reference)
- [Мониторинг](#-мониторинг)
- [Скрипты](#-скрипты)
- [Локальная разработка](#-локальная-разработка)
- [Деплой](#-деплой)
- [Troubleshooting](#-troubleshooting)
- [Roadmap](#-roadmap)
- [Автор](#-автор)
---

## 🎯 Обзор

**TechStore** — учебный e-commerce проект, созданный для изучения **современных DevOps практик** на реальном стеке. Проект охватывает полный цикл: от локальной разработки до продакшен деплоя с мониторингом.

### 🎓 Чему учит этот проект

- **Контейнеризация** — Docker и Docker Compose
- **Мониторинг и observability** — Prometheus и Grafana
- **Infrastructure as Code** — весь стек описан в коде
- **Разработка REST API** — Flask
- **Работа с базами данных** — PostgreSQL
- **Кэширование** — Redis с TTL и логированием HIT/MISS
- **Reverse proxy** — Nginx
- **DevOps скрипты** — bash автоматизация
- **Продакшен деплой** — Render

---

## 📊 Project Levels

<table>
<tr>
<td><strong>Level 1</strong><br/>Beginner</td>
<td>✅ Завершён</td>
<td>Полный стек: Flask API, PostgreSQL, Redis, Nginx, мониторинг</td>
<td>Docker Compose, PostgreSQL, Redis, Nginx, Prometheus, Grafana</td>
</tr>
</table>

---

## 🏗️ Архитектура

```
                    ┌─────────────────────────┐
                    │      Пользователь       │
                    └───────────┬─────────────┘
                                │
                   ┌────────────▼─────────────┐
                   │      Nginx :80           │
                   │  Reverse Proxy           │
                   └────────────┬─────────────┘
                                │
                   ┌────────────▼─────────────┐
                   │    Flask API :5000       │
                   └──────┬─────────┬─────────┘
                          │         │
             ┌────────────▼──┐  ┌───▼────────────┐
             │ PostgreSQL    │  │  Redis :6379   │
             │ :5432         │  │  Cache         │
             └───────────────┘  └────────────────┘

Мониторинг:
┌─────────────────┐     ┌─────────────────┐
│  Prometheus     │────▶│    Grafana      │
│  :9090          │     │    :3000        │
└────────┬────────┘     └─────────────────┘
         │
         ├── backend:5000/metrics
         ├── node_exporter:9100
         ├── postgres_exporter:9187
         └── nginx_exporter:9113
```
```

### 🔧 Компоненты

| Компонент          | Технология              | Порт | Назначение                    |
|--------------------|-------------------------|------|-------------------------------|
| **Nginx**          | nginx:alpine            | 80   | Reverse proxy                 |
| **Backend**        | Flask + Gunicorn        | 5000 | REST API                      |
| **Database**       | PostgreSQL 16           | 5432 | Хранение данных               |
| **Cache**          | Redis 7                 | 6379 | Кэширование запросов          |
| **Monitoring**     | Prometheus              | 9090 | Сбор метрик                   |
| **Visualization**  | Grafana                 | 3000 | Дашборды                      |
| **System Metrics** | Node Exporter           | 9100 | Метрики хоста                 |
| **DB Metrics**     | Postgres Exporter       | 9187 | Метрики PostgreSQL            |
| **Nginx Metrics**  | Nginx Exporter          | 9113 | Метрики Nginx                 |

---
```

## 🛠️ Tech Stack

<div align="center">

### Backend

![Python](https://img.shields.io/badge/Python-3.11-3776AB?logo=python&logoColor=white)
![Flask](https://img.shields.io/badge/Flask-3.0-000000?logo=flask&logoColor=white)
![PostgreSQL](https://img.shields.io/badge/PostgreSQL-16-4169E1?logo=postgresql&logoColor=white)
![Redis](https://img.shields.io/badge/Redis-7-DC382D?logo=redis&logoColor=white)

### Infrastructure

![Docker](https://img.shields.io/badge/Docker-2496ED?logo=docker&logoColor=white)
![Nginx](https://img.shields.io/badge/Nginx-009639?logo=nginx&logoColor=white)
![Prometheus](https://img.shields.io/badge/Prometheus-E6522C?logo=prometheus&logoColor=white)
![Grafana](https://img.shields.io/badge/Grafana-F46800?logo=grafana&logoColor=white)
![Bash](https://img.shields.io/badge/Bash-4EAA25?logo=gnubash&logoColor=white)

</div>

---

## ✨ Что реализовано

### 🛍️ E-commerce
- ✅ Каталог товаров по категориям
- ✅ REST API (products, categories, health, metrics)
- ✅ Схема БД с orders и order_items (готова к расширению)

### 🚀 DevOps
- ✅ **Docker Compose** — весь стек одной командой
- ✅ **Мониторинг** — Prometheus + Grafana с 4 дашбордами
- ✅ **Redis кэширование** — TTL 60s, логирование HIT/MISS
- ✅ **Автобэкап** — скрипт резервного копирования PostgreSQL
- ✅ **Health checks** — для всех сервисов с depends_on
- ✅ **Безопасность** — non-root контейнеры, секреты через .env
- ✅ **Продакшен деплой** — Render с PostgreSQL и Redis

---

## 🚀 Быстрый старт

### Требования

| Инструмент       | Версия      |
|------------------|-------------|
| Docker           | 20.10+      |
| Docker Compose   | 2.0+        |
| Git              | любая       |

### 🎬 Установка

```
# 1. Клонировать репозиторий
git clone https://github.com/DavyRoy/E-commerce.git
cd E-commerce

# 2. Настроить переменные окружения
cp .env.example .env
# Отредактируй .env под свои значения

# 3. Запустить все сервисы
docker compose up -d

# 4. Проверить что всё работает
docker compose ps

# 5. Открыть в браузере
# API:        http://localhost/products
# Prometheus: http://localhost:9090
# Grafana:    http://localhost:3000 (admin/admin)
```
---

## 📚 API Reference

### Base URL
```
http://localhost
```

### Endpoints

| Method | Endpoint      | Description          |
|--------|---------------|----------------------|
| `GET`  | `/health`     | Health check         |
| `GET`  | `/products`   | Список всех товаров  |
| `GET`  | `/categories` | Список категорий     |
| `GET`  | `/metrics`    | Prometheus метрики   |

### Примеры

```
curl http://localhost/health
# {"service": "techstore-backend", "status": "ok"}

curl http://localhost/products
# [{"id": 1, "name": "MacBook Pro 13\"", "price": 1299.99, "stock": 100}, ...]

curl http://localhost/categories
# [{"id": 1, "name": "Notebooks"}, ...]
```

## 📊 Мониторинг

### Prometheus
Доступ: **http://localhost:9090**

**Метрики backend:**
- `http_requests_total` — счётчик запросов по endpoint и статусу
- `http_request_duration_seconds` — гистограмма времени ответа
- `redis_cache_hits_total` — попадания в кэш
- `redis_cache_misses_total` — промахи кэша

### Grafana
Доступ: **http://localhost:3000** (admin/admin)

**Дашборд TechStore:**
- HTTP Requests Rate
- Request Duration p99
- Cache Hit Rate (%)
- Active Connections

### PromQL примеры
```promql
# Запросов в секунду
rate(http_requests_total[5m])

# p99 время ответа
histogram_quantile(0.99, rate(http_request_duration_seconds_bucket[5m]))

# Cache hit rate
rate(redis_cache_hits_total[5m]) / (rate(redis_cache_hits_total[5m]) + rate(redis_cache_misses_total[5m])) * 100
```

---

## 🔧 Automation Scripts

All automation scripts are located in `scripts/` directory.

| Script | Purpose | Usage |
|--------|---------|-------|
| **backup.sh** | Create PostgreSQL backup | `./scripts/backup.sh` |
| **deploy.sh** | Deploy entire stack | `./scripts/deploy.sh` |
| **health-check.sh** | Check service health | `./scripts/health-check.sh` |
| **logs.sh** | View container logs | `./scripts/logs.sh [service]` |
| **cleanup.sh** | Clean Docker resources | `./scripts/cleanup.sh` |

## 🔧 Скрипты автоматизации

| Скрипт | Назначение | Использование |
|--------|------------|---------------|
| **setup.sh** | Проверка зависимостей | `./scripts/setup.sh` |
| **backup.sh** | Бэкап PostgreSQL | `./scripts/backup.sh` |

### Примеры
```bash
# Проверить зависимости
./scripts/setup.sh

# Создать бэкап базы данных
./scripts/backup.sh
# Output: ./backups/techstore_db-2026-04-24.sql
```
## 💻 Локальная разработка

```bash
# 1. Создать виртуальное окружение
cd backend
python3 -m venv venv
source venv/bin/activate

# 2. Установить зависимости
pip install -r requirements.txt

# 3. Установить переменные окружения
export DATABASE_URL=postgresql://techstore_user:secret@localhost:5432/techstore_db
export REDIS_URL=redis://localhost:6379
export SECRET_KEY=dev-secret-key

# 4. Запустить сервер разработки
python run.py
```

### Структура проекта

```
E-commerce/
├── backend/                    # Flask REST API
│   ├── app/
│   │   ├── __init__.py        # App factory
│   │   ├── config.py          # Конфигурация
│   │   ├── models.py          # Схема данных
│   │   └── main.py            # API endpoints
│   ├── run.py                 # Точка входа
│   ├── Dockerfile
│   ├── .dockerignore
│   └── requirements.txt
│
├── nginx/                      # Reverse proxy
│   ├── nginx.conf
│   └── Dockerfile
│
├── db/
│   └── init/
│       └── init.sql           # Схема и тестовые данные
│
├── monitoring/
│   ├── prometheus/
│   │   └── prometheus.yml
│   └── grafana/
│       ├── provisioning/
│       │   ├── datasources/
│       │   └── dashboards/
│       └── dashboards/
│           └── techstore.json
│
├── scripts/
│   ├── setup.sh               # Проверка зависимостей
│   └── backup.sh              # Бэкап PostgreSQL
│
├── docs/
│   ├── architecture.md
│   └── project-structure.md
│
├── docker-compose.yml
├── .env.example
└── README.md
```
---

## 🚢 Деплой

### Локальный запуск
```bash
cp .env.example .env
# Заполни .env своими значениями
docker compose up -d
docker compose ps
```

### Продакшен (Render)
Live demo: https://e-commerce-9rcc.onrender.com

### Бэкап
```bash
./scripts/backup.sh
# Сохраняет: ./backups/techstore_db-YYYY-MM-DD.sql
# Автоудаление бэкапов старше 7 дней
```

### Переменные окружения

```env
# Database
POSTGRES_USER=techstore_user
POSTGRES_PASSWORD=your_password
POSTGRES_DB=techstore_db

# Application
SECRET_KEY=your-secret-key

# Grafana
GRAFANA_ADMIN_USER=admin
GRAFANA_ADMIN_PASSWORD=your_password
```
---

## 🐛 Troubleshooting

### Сервисы не запускаются
```bash
docker compose ps
docker compose logs backend
docker compose down && docker compose up --build -d
```

### Ошибки подключения к БД
```bash
docker compose exec postgres pg_isready -U techstore_user
docker compose logs postgres
docker compose exec backend env | grep POSTGRES
```

### Порт уже занят
```bash
# Найти процесс на порту 80
lsof -i :80
kill -9 <PID>
```

### Очистка Docker ресурсов
```bash
docker system prune -f
docker volume ls
docker compose down -v  # ⚠️ удалит все данные
```

## 🗺️ Roadmap

### ✅ Завершено (Beginner)
- [x] Структура проекта и Git workflow
- [x] PostgreSQL схема с индексами и constraints
- [x] Docker Compose полный стек
- [x] Nginx reverse proxy
- [x] Redis кэширование
- [x] Prometheus метрики
- [x] Grafana дашборды
- [x] Bash скрипты автоматизации
- [x] Продакшен деплой на Render
---

## 📄 License

MIT License — см. [LICENSE](LICENSE)

## 👤 Автор

**DavyRoy** — DevOps Engineer in Training

- GitHub: [@DavyRoy](https://github.com/DavyRoy)
- Репозиторий: [E-commerce](https://github.com/DavyRoy/E-commerce)

---

<div align="center">

**Made with ❤️ by DavyRoy**

[⬆ Наверх](#-techstore--e-commerce-platform)

</div>