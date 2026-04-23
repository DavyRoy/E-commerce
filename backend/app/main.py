import time
import json
import logging
import psycopg2
import redis
import os

from flask import Blueprint, jsonify, Response
from prometheus_client import Counter, Histogram, generate_latest, CONTENT_TYPE_LATEST

logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)

bp = Blueprint('main', __name__)

CACHE_TTL = 60

# Метрики
http_requests_total = Counter(
    'http_requests_total',
    'Total HTTP requests',
    ['method', 'endpoint', 'status']
)

http_request_duration_seconds = Histogram(
    'http_request_duration_seconds',
    'HTTP request duration in seconds',
    ['method', 'endpoint']
)

redis_cache_hits_total = Counter(
    'redis_cache_hits_total',
    'Total Redis cache hits',
    ['endpoint']
)

redis_cache_misses_total = Counter(
    'redis_cache_misses_total',
    'Total Redis cache misses',
    ['endpoint']
)

def get_db():
    return psycopg2.connect(os.getenv('DATABASE_URL'))

def get_redis():
    return redis.from_url(os.getenv('REDIS_URL', 'redis://redis:6379'))

@bp.route('/health')
def health():
    return jsonify({'status': 'ok', 'service': 'techstore-backend'})

@bp.route('/metrics')
def metrics():
    return Response(generate_latest(), mimetype=CONTENT_TYPE_LATEST)

@bp.route('/products')
def get_redis():
    try:
        r = redis.from_url(os.getenv('REDIS_URL', 'redis://redis:6379'),
                           socket_connect_timeout=2)
        r.ping()
        return r
    except Exception:
        return None

@bp.route('/products')
def get_products():
    start = time.time()
    r = get_redis()
    cache_key = 'products'

    if r:
        cached = r.get(cache_key)
        if cached:
            redis_cache_hits_total.labels(endpoint='/products').inc()
            duration = time.time() - start
            http_request_duration_seconds.labels(method='GET', endpoint='/products').observe(duration)
            http_requests_total.labels(method='GET', endpoint='/products', status='200').inc()
            logger.info(f'GET /products - Cache HIT - served from Redis in {int(duration*1000)}ms')
            return jsonify(json.loads(cached))
        redis_cache_misses_total.labels(endpoint='/products').inc()

    try:
        conn = get_db()
        cur = conn.cursor()
        cur.execute("SELECT id, name, price, stock FROM products ORDER BY id")
        rows = cur.fetchall()
        products = [{'id': r[0], 'name': r[1], 'price': float(r[2]), 'stock': r[3]} for r in rows]
        cur.close()
        conn.close()
    except Exception as e:
        http_requests_total.labels(method='GET', endpoint='/products', status='500').inc()
        return jsonify({'error': str(e)}), 500

    if r:
        r.setex(cache_key, CACHE_TTL, json.dumps(products))

    duration = time.time() - start
    http_request_duration_seconds.labels(method='GET', endpoint='/products').observe(duration)
    http_requests_total.labels(method='GET', endpoint='/products', status='200').inc()
    logger.info(f'GET /products - Cache MISS - fetched from DB in {int(duration*1000)}ms')
    return jsonify(products)

@bp.route('/categories')
def get_categories():
    start = time.time()
    r = get_redis()
    cache_key = 'categories'

    cached = r.get(cache_key)
    if cached:
        redis_cache_hits_total.labels(endpoint='/categories').inc()
        duration = time.time() - start
        http_request_duration_seconds.labels(method='GET', endpoint='/categories').observe(duration)
        http_requests_total.labels(method='GET', endpoint='/categories', status='200').inc()
        logger.info('GET /categories - Cache HIT')
        return jsonify(json.loads(cached))

    redis_cache_misses_total.labels(endpoint='/categories').inc()
    try:
        conn = get_db()
        cur = conn.cursor()
        cur.execute("SELECT id, name FROM categories ORDER BY id")
        rows = cur.fetchall()
        categories = [{'id': r[0], 'name': r[1]} for r in rows]
        cur.close()
        conn.close()
    except Exception as e:
        http_requests_total.labels(method='GET', endpoint='/categories', status='500').inc()
        return jsonify({'error': str(e)}), 500

    r.setex(cache_key, CACHE_TTL, json.dumps(categories))
    duration = time.time() - start
    http_request_duration_seconds.labels(method='GET', endpoint='/categories').observe(duration)
    http_requests_total.labels(method='GET', endpoint='/categories', status='200').inc()
    logger.info('GET /categories - Cache MISS')
    return jsonify(categories)