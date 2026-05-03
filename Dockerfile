# Full stack: Flask API + static frontend (paths match backend/app.py expectations).
FROM python:3.12-slim

WORKDIR /app

ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1 \
    PIP_NO_CACHE_DIR=1

COPY backend/requirements.txt ./backend/
RUN pip install -r backend/requirements.txt

COPY backend/app.py ./backend/
COPY frontend ./frontend

# Serve on PORT (Fly.io, Render, Railway, etc. inject this).
ENV PORT=8080
EXPOSE 8080

WORKDIR /app/backend

# shell form so $PORT from the platform is picked up at runtime
CMD sh -c 'exec gunicorn --bind "0.0.0.0:${PORT:-8080}" --workers 2 --threads 4 --timeout 120 app:app'
