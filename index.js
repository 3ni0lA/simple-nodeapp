
const express = require('express');
const app = express();
const port = 3000;

app.get('/api/greeting', (req, res) => {
  res.json({ message: 'Hello from Node.js API!' });
});


// New health check endpoint
app.get('/health', (req, res) => {
  res.status(200).json({ status: 'ok' }); // Returns a JSON object with status ok
});


app.listen(port, () => {
  console.log(`Node.js app listening at http://localhost:${port}`);
});
