import React, { useEffect, useState } from 'react';

function App() {
  const [flowers, setFlowers] = useState([]);

  useEffect(() => {
    fetch('/api/flowers')  // Adjust path depending on your proxy setup or ingress
      .then(res => res.json())
      .then(data => setFlowers(data))
      .catch(err => console.error(err));
  }, []);

  return (
    <div>
      <h1>Flower Shop</h1>
      <ul>
        {flowers.map(flower => (
          <li key={flower.id}>
            {flower.name} - ${flower.price}
          </li>
        ))}
      </ul>
    </div>
  );
}

export default App;
