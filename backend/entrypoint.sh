#!/bin/bash

echo "Waiting for postgres..."

while ! nc -z "$POSTGRES_HOST" "$POSTGRES_PORT"; do
  sleep 0.1
done

echo "Postgres started"

gunicorn --bind 0.0.0.0:9000 kittygram_backend.wsgi
python manage.py migrate
python manage.py collectstatic
cp -r /app/collected_static/. /static/static/


exec "$@"