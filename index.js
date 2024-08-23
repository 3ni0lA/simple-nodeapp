
const express = require('express');
const app = express();
const port = 3000;

// Define a route for the root URL
app.get('/', (req, res) => {
  res.send('Welcome to the Node.js app!');
});

app.get('/api/greeting', (req, res) => {
  res.json({ message: 'Hello from Node.js API!' });
});

app.listen(port, () => {
  console.log(`Node.js app listening at http://localhost:${port}`);
});
