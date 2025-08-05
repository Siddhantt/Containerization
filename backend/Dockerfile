# Set build-time variable
ARG MODE=dev

# Use official Python image
FROM python:3.10-slim AS base

# Set working directory
WORKDIR /app

# Install dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy source code
COPY . .

# Dev mode
FROM base AS dev
ARG MODE
ENV FLASK_ENV=development
CMD ["python", "app.py"]

# Prod mode
FROM base AS prod
ARG MODE
ENV FLASK_ENV=production
CMD ["gunicorn", "-b", "0.0.0.0:5000", "app:app"]

# Final stage selector
FROM ${MODE} AS final
