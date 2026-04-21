# TechStore Architecture

## Stack Overview

User → Nginx (80) → Backend (5000) → PostgreSQL (5432)
                        ↓
                    Redis (6379)

Prometheus (9090) ← scrape ← Backend /metrics
        ↓
Grafana (3000)

## Services

| Service    | Port | Image / Build        | Purpose                  |
|------------|------|----------------------|--------------------------|
| nginx      | 80   | build: ./nginx       | Reverse proxy            |
| backend    | 5000 | build: ./backend     | Flask API                |
| postgres   | 5432 | postgres:16-alpine   | Primary database         |
| redis      | 6379 | redis:7-alpine       | Cache                    |
| prometheus | 9090 | prom/prometheus      | Metrics collection       |
| grafana    | 3000 | grafana/grafana      | Metrics visualization    |

## Data Flow
Запрос начинается на стороне клиента (браузер, мобильное приложение или curl). Пользователь обращается к сервису по HTTP на порт 80, где точкой входа выступает Nginx.

Nginx выполняет роль reverse proxy и маршрутизатора. Он принимает входящий запрос, добавляет служебные заголовки (например, X-Forwarded-For, Host) и проксирует его в backend-сервис на порт 5000. На этом этапе Nginx не обрабатывает бизнес-логику — только маршрутизацию и, при необходимости, отдачу статики.

Backend (Flask API) принимает запрос и определяет, какой endpoint должен его обработать. Дальше возможны несколько сценариев:
•	Если данные уже есть в кэше, backend обращается к Redis (6379), извлекает их и сразу формирует ответ.
•	Если данных в кэше нет, backend выполняет запрос к PostgreSQL (5432), получает актуальные данные, при необходимости сохраняет их в Redis для ускорения будущих запросов, и затем формирует ответ.

После обработки backend возвращает HTTP-ответ обратно в Nginx, который, в свою очередь, отправляет его клиенту.

Параллельно с обработкой пользовательских запросов backend экспонирует метрики по endpoint /metrics. Prometheus (9090) периодически обращается к этому endpoint (pull-модель), собирает метрики (например, количество запросов, latency, ошибки) и сохраняет их во временное хранилище.

Grafana (3000) подключается к Prometheus как к источнику данных и использует эти метрики для построения дашбордов и визуализации состояния системы (нагрузка, производительность, ошибки и т.д.).

Таким образом, в системе есть два независимых потока данных:
1.	Основной (request/response) — пользователь → Nginx → Backend → (Redis/PostgreSQL) → обратно пользователю
2.	Мониторинг (metrics pipeline) — Backend → Prometheus → Grafana