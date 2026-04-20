import os

class Config:
    DATABASE_URL = os.getenv('DATABASE_URL', 'postgresql://techstore_user:secret@localhost:5432/techstore_db')
    REDIS_URL = os.getenv('REDIS_URL', 'redis://localhost:6379')
    SECRET_KEY = os.getenv('SECRET_KEY', 'dev-secret-key')
    DEBUG = os.getenv('DEBUG', 'false').lower() == 'true'