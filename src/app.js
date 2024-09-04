const express = require('express');
const app = express();

app.get('/', (req, res) => {
  res.send('DEVAVRAT SINGH updating chnages');
});

module.exports = app;
