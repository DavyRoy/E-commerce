import uuid
import redis
from datetime import datetime
import time

# Подключение к Redis
r = redis.Redis(host="localhost", port=6379, db=0, decode_responses=True)

SESSION_PREFIX = "session:"
SESSION_TTL = 1800  # 30 минут


def create_session(user_id, user_name):
    token = str(uuid.uuid4())
    key = f"{SESSION_PREFIX}{token}"
    r.hset(key, mapping={
        "user_id": str(user_id),
        "user_name": user_name,
        "created_at": str(datetime.now())
    })
    r.expire(key, SESSION_TTL)
    return token


def get_session(token):
    key = f"{SESSION_PREFIX}{token}"
    data = r.hgetall(key)
    if not data:
        return None
    r.expire(key, SESSION_TTL)  # обновляем TTL при каждом обращении
    return data


def delete_session(token):
    key = f"{SESSION_PREFIX}{token}"
    r.delete(key)


# Запуск
token = create_session(1, "Sergey")
print(f"Сессия создана: {token}")

data = get_session(token)
print(f"Данные сессии: {data}")

#print("Пауза 10 секунд — проверь redis-cli...")
#time.sleep(20)  # ← добавь это

delete_session(token)
print(f"После удаления: {get_session(token)}")