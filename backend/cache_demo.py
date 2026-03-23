import psycopg2
import psycopg2.extras
import redis
import json
import time
from decimal import Decimal

# Redis подключение
r = redis.Redis(host="localhost", port=6379, db=0, decode_responses=True)

CACHE_KEY = "cache:products"
CACHE_TTL = 60


# Решение проблемы Decimal — PostgreSQL NUMERIC → Python Decimal → JSON
class DecimalEncoder(json.JSONEncoder):
    def default(self, obj):
        if isinstance(obj, Decimal):
            return float(obj)
        return super().default(obj)


def get_products():
    # 1. Проверяем кэш
    cached = r.get(CACHE_KEY)
    if cached:
        print("Cache HIT — данные из Redis")
        return json.loads(cached)

    print("Cache MISS — запрос к PostgreSQL")

    # 2. Идём в PostgreSQL
    conn = psycopg2.connect(
        host="localhost", port=5432,
        database="techstore_db",
        user="techstore_user",
        password="postrges"
    )
    cursor = conn.cursor(cursor_factory=psycopg2.extras.RealDictCursor)
    cursor.execute("SELECT id, name, price, stock FROM products")
    rows = cursor.fetchall()
    cursor.close()
    conn.close()

    products = [dict(row) for row in rows]

    # 3. Кладём в Redis с TTL
    r.setex(CACHE_KEY, CACHE_TTL, json.dumps(products, cls=DecimalEncoder))

    return products


def invalidate_cache():
    r.delete(CACHE_KEY)
    print("Кэш инвалидирован")


# --- Запуск ---
print("=== Первый запрос ===")
start = time.time()
products = get_products()
print(f"Товаров: {len(products)}, Время: {time.time() - start:.4f}s")

print("\n=== Второй запрос ===")
start = time.time()
products = get_products()
print(f"Товаров: {len(products)}, Время: {time.time() - start:.4f}s")

print("\n=== Инвалидация кэша ===")
invalidate_cache()

print("\n=== Третий запрос (после инвалидации) ===")
start = time.time()
products = get_products()
print(f"Товаров: {len(products)}, Время: {time.time() - start:.4f}s")