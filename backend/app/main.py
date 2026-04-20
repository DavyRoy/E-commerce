from flask import Blueprint, jsonify
import psycopg2
import os

bp = Blueprint('main', __name__)

def get_db():
    return psycopg2.connect(os.getenv('DATABASE_URL'))

@bp.route('/health')
def health():
    return jsonify({'status': 'ok', 'service': 'techstore-backend'})

@bp.route('/api/products')
def get_products():
    try:
        conn = get_db()
        cur = conn.cursor()
        cur.execute("SELECT id, name, price, stock FROM products ORDER BY id")
        rows = cur.fetchall()
        products = [{'id': r[0], 'name': r[1], 'price': float(r[2]), 'stock': r[3]} for r in rows]
        cur.close()
        conn.close()
        return jsonify(products)
    except Exception as e:
        return jsonify({'error': str(e)}), 500

@bp.route('/api/categories')
def get_categories():
    try:
        conn = get_db()
        cur = conn.cursor()
        cur.execute("SELECT id, name FROM categories ORDER BY id")
        rows = cur.fetchall()
        categories = [{'id': r[0], 'name': r[1]} for r in rows]
        cur.close()
        conn.close()
        return jsonify(categories)
    except Exception as e:
        return jsonify({'error': str(e)}), 500