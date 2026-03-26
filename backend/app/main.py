import os
import json
import logging
import psycopg2
import redis
from flask import Flask, jsonify
from prometheus_flask_exporter import PrometheusMetrics

# Настройка логирования
logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)

# Flask + Prometheus
app = Flask(__name__)
metrics = PrometheusMetrics(app)

# Redis клиент
redis_client = redis.Redis(
    host=os.getenv("REDIS_HOST", "redis"),
    port=int(os.getenv("REDIS_PORT", 6379)),
    password=os.getenv("REDIS_PASSWORD", None),
    decode_responses=True
)

CACHE_TTL = 60  # время жизни кеша в секундах

# Подключение к Postgres
def get_db_connection():
    return psycopg2.connect(
        host=os.getenv("DB_HOST", "postgres"),
        port=os.getenv("DB_PORT", 5432),
        database=os.getenv("DB_NAME", "techstore_db"),
        user=os.getenv("DB_USER", "techstore_user"),
        password=os.getenv("DB_PASSWORD", "")
    )

# Корневой endpoint
@app.route("/")
def index():
    return jsonify({
        "name": "TechStore API",
        "version": "1.0.0",
        "status": "running"
    })

# Health check
@app.route("/health")
def health():
    return jsonify({"status": "ok"})

# Список продуктов
@app.route("/api/products")
def products():
    cache_key = "products:all"

    cached = redis_client.get(cache_key)
    if cached:
        logger.info("Cache HIT for %s", cache_key)
        return jsonify(json.loads(cached))

    logger.info("Cache MISS for %s", cache_key)

    try:
        conn = get_db_connection()
        cur = conn.cursor()
        cur.execute("SELECT id, name, price, stock FROM products ORDER BY id LIMIT 20;")
        rows = cur.fetchall()
        cur.close()
        conn.close()

        result = [
            {"id": r[0], "name": r[1], "price": float(r[2]), "stock": r[3]}
            for r in rows
        ]

        redis_client.setex(cache_key, CACHE_TTL, json.dumps(result))
        return jsonify(result)

    except Exception as e:
        logger.error("DB error: %s", e)
        return jsonify({"error": str(e)}), 500

# Список категорий
@app.route("/api/categories")
def categories():
    cache_key = "categories:all"

    cached = redis_client.get(cache_key)
    if cached:
        logger.info("Cache HIT for %s", cache_key)
        return jsonify(json.loads(cached))

    logger.info("Cache MISS for %s", cache_key)

    try:
        conn = get_db_connection()
        cur = conn.cursor()
        cur.execute("SELECT id, name FROM categories ORDER BY id;")
        rows = cur.fetchall()
        cur.close()
        conn.close()

        result = [
            {"id": r[0], "name": r[1]}
            for r in rows
        ]

        redis_client.setex(cache_key, CACHE_TTL, json.dumps(result))
        return jsonify(result)

    except Exception as e:
        logger.error("DB error: %s", e)
        return jsonify({"error": str(e)}), 500

# Запуск приложения
if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000, debug=False)