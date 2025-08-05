CREATE TABLE IF NOT EXISTS products (
  id SERIAL PRIMARY KEY,
  name TEXT NOT NULL,
  price NUMERIC NOT NULL
);

INSERT INTO products (name, price) VALUES
('T-shirt', 19.99),
('Sneakers', 49.99),
('Backpack', 29.99);
