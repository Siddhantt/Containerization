from flask import Flask, jsonify
from flask_cors import CORS
import psycopg2
import os

app = Flask(__name__)
CORS(app)

@app.route("/products")
def get_products():
    conn = psycopg2.connect(
        host=os.environ.get("DB_HOST", "localhost"),
        database=os.environ.get("DB_NAME", "productdb"),
        user=os.environ.get("DB_USER", "postgres"),
        password=os.environ.get("DB_PASSWORD", "postgres")
    )
    cur = conn.cursor()
    cur.execute("SELECT * FROM products")
    products = cur.fetchall()
    cur.close()
    conn.close()

    return jsonify([
        {"id": row[0], "name": row[1], "price": row[2]}
        for row in products
    ])

@app.route("/")
def index():
    return "Backend is working!"

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)
