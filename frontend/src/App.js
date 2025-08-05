import React, { useEffect, useState } from 'react';

function App() {
  const [products, setProducts] = useState([]);

  useEffect(() => {
    fetch("http://localhost:5000/products")
      .then(res => res.json())
      .then(data => setProducts(data));
  }, []);

  return (
    <div>
      <h1>Product Catalog</h1>
      <ul>
        {products.map((prod, i) => (
          <li key={i}>{prod[1]} - ${prod[2]}</li>
        ))}
      </ul>
    </div>
  );
}

export default App;
