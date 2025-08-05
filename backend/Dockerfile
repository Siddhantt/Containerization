FROM python:3.11-slim
WORKDIR /app

RUN apt-get update && \
    apt-get install -y --no-install-recommends build-essential libpq-dev && \
    rm -rf /var/lib/apt/lists/*

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY . .

EXPOSE 5000

# Default mode: production
ENV MODE=prod

# Use shell form CMD (not exec form)
CMD sh -c 'if [ "$MODE" = "dev" ]; then python app.py; else gunicorn -b 0.0.0.0:5000 app:app; fi'
