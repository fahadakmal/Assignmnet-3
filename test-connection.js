const { Client } = require('pg');

const client = new Client({
  host: 'localhost',
  port: 5432,
  user: 'dbuser',
  password: 'dbpass',
  database: 'ecommerce_north'
});

client.connect()
  .then(() => {
    console.log('✅ Connected successfully!');
    return client.query('SELECT COUNT(*) FROM categories');
  })
  .then(result => {
    console.log('Categories count:', result.rows[0].count);
    return client.end();
  })
  .catch(err => {
    console.error('❌ Connection error:', err.message);
    console.error('Error code:', err.code);
  });
