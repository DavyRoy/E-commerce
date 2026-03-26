FROM python:3.11-slim
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    libpq-dev \
    && rm -rf /var/lib/apt/lists/*
WORKDIR /app
COPY requirements.txt /app/
RUN pip install --no-cache-dir -r requirements.txt
COPY app/ /app/app/
EXPOSE 5000
RUN groupadd -r dev && useradd -r -g dev -u 1000 -m dev
RUN chown -R dev:dev /app
USER dev
CMD ["python", "app/main.py"]
