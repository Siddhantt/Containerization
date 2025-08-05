#!/bin/bash

# --- Configuration ---
BACKEND_DIR="backend"
FRONTEND_DIR="frontend"
DB_NAME="productdb"
DB_USER="postgres"
DB_PASSWORD="postgres"
INIT_SQL="db/init.sql"

# --- PostgreSQL Initialization ---
echo "🔧 Checking and initializing PostgreSQL database..."

# Run all DB commands as the postgres user (required due to peer authentication)
sudo -u postgres psql -tc "SELECT 1 FROM pg_database WHERE datname = '$DB_NAME'" | grep -q 1 || \
  sudo -u postgres createdb "$DB_NAME"

sudo -u postgres psql -d "$DB_NAME" -f "$INIT_SQL"

echo "✅ PostgreSQL is ready."

# --- Start Flask Backend ---
echo "🚀 Starting Flask backend..."
cd "$BACKEND_DIR"
if [ ! -d "venv" ]; then
    python3 -m venv venv
fi
source venv/bin/activate
pip install -r requirements.txt
pip install flask-cors

export DB_HOST=localhost
export DB_PORT=5432
export DB_USER="$DB_USER"
export DB_PASSWORD="$DB_PASSWORD"
export DB_NAME="$DB_NAME"

# Kill existing Flask process if running
pkill -f "python.*app.py" 2>/dev/null || true

nohup ./venv/bin/python app.py > flask.log 2>&1 &
BACKEND_PID=$!
echo "✅ Flask backend started in background (PID: $BACKEND_PID)"
cd ..

# --- Start React Frontend ---
echo "🌐 Starting React frontend..."
cd "$FRONTEND_DIR"
if [ ! -d "node_modules" ]; then
    npm install
fi

# Kill existing React process if running
pkill -f "react-scripts start" 2>/dev/null || true

nohup npm start > react.log 2>&1 &
FRONTEND_PID=$!
echo "✅ React frontend started in background (PID: $FRONTEND_PID)"
cd ..

# --- Summary ---
echo "🎉 All services started!"
echo "🌐 Frontend: http://localhost:3000"
echo "📡 Backend API: http://localhost:5000/products"
echo "📄 Logs: backend/flask.log, frontend/react.log"
