const express = require('express');
const router = express.Router();
const db = require('../db/oracleDB'); // Import the oracleDB module

/* GET home page. */
router.get('/', async (req, res) => {
  try {
    const connection = await db.getConnection(); // Use the connection from oracleDB module
    const result = await connection.execute('SELECT * FROM SS_Advertisement');
    const advertisements = result.rows;

    await connection.close();

    res.render('index', { advertisements });
  } catch (err) {
    console.error('Error executing query:', err);
    res.status(500).send('Internal Server Error');
  }
});

/* GET home page. */
router.get('/home', function(req, res, next) {
  res.render('index', { title: 'Home' });
});

/* GET cart page. */
router.get('/cart', function(req, res, next) {
  res.render('cart', { title: 'Cart' });
});

module.exports = router;
