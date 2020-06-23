'use strict';

const express = require('express');

// Constants
const PORT = 80;
const HOST = '0.0.0.0';

// App
const app = express();
app.get('/', (req, res) => {
    res.send('Hello World');
});
app.get('/airasia', (req, res) => {
    res.send('Hi AirAsia');
});
app.get('/v2', (req, res) => {
    res.send('Hello World v2');
});

app.listen(PORT, HOST);
console.log(`Running on http://${HOST}:${PORT}`);
