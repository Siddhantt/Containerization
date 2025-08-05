import React, { useEffect, useState } from 'react';

function App() {
  const [products, setProducts] = useState([]);

  useEffect(() => {
    fetch("/products")
      .then(res => res.json())
      .then(data => setProducts(data));
  }, []);

  return (
    <div>
      <h1>Product Catalog</h1>
      <ul>
        {products.map((prod, i) => (
          <li key={i}>{prod.name} - ${prod.price}</li>
        ))}
      </ul>
    </div>
  );
}

export default App;
