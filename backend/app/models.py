# Модели данных (используется для документации схемы)
# ORM не используется — работаем напрямую через psycopg2

TABLES = {
    'users': ['id', 'name', 'email', 'password_hash', 'created_at', 'updated_at'],
    'categories': ['id', 'name', 'description'],
    'products': ['id', 'name', 'price', 'category_id', 'stock', 'information', 'created_at', 'updated_at'],
    'orders': ['id', 'user_id', 'total_amount', 'created_at', 'updated_at'],
    'order_items': ['id', 'order_id', 'product_id', 'quantity', 'price'],
}