const express = require('express');
const app = express();
const bodyParser = require('body-parser');
const mysql = require('mysql2');

app.use(bodyParser.json());

// DB connection (replace with actual RDS values or env vars)
const db = mysql.createConnection({
  host: 'your-db-host',
  user: 'admin',
  password: 'change_this_password',
  database: 'flowerdb'
});

db.connect(err => {
  if (err) {
    console.error('DB connection failed:', err.stack);
    return;
  }
  console.log('Connected to DB.');
});

// Routes
app.get('/flowers', (req, res) => {
  res.json([
    { id: 1, name: 'Rose', price: 10 },
    { id: 2, name: 'Tulip', price: 7 },
    { id: 3, name: 'Daisy', price: 5 }
  ]);
});

app.post('/order', (req, res) => {
  const { flowerId, quantity } = req.body;
  res.json({ message: `Order placed for flower ID ${flowerId} qty ${quantity}` });
});

app.listen(3000, () => console.log('Flower shop API running on port 3000'));
