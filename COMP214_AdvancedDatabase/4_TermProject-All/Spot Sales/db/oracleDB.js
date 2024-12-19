// db/oracleDB.js
const oracledb = require('oracledb');

// Define your database configuration
const dbConfig = {
  user: 'COMP214_M23_zo_49',
  password: 'password',
  connectString: 'oracle1.centennialcollege.ca:1512/SQLD'
};

// Create and manage the database connection pool
async function createPool() {
  try {
    await oracledb.createPool(dbConfig);
    console.log('Connected to Oracle');
  } catch (err) {
    console.error('Error creating database pool:', err);
  }
}

async function getConnection() {
  try {
    return await oracledb.getConnection();
  } catch (err) {
    console.error('Error getting database connection:', err);
    throw err; // Rethrow the error for the calling code to handle
  }
}

module.exports = { createPool, getConnection };
