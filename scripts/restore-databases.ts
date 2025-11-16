import { Client } from 'pg';
import * as fs from 'fs';
import * as path from 'path';

// Database configurations
const databases = [
  {
    name: 'North',
    host: 'localhost',
    port: 5435,
    user: 'dbuser',
    password: 'dbpass',
    database: 'ecommerce_north',
    seedFile: 'seed-north.sql'
  },
  {
    name: 'South',
    host: 'localhost',
    port: 5436,
    user: 'dbuser',
    password: 'dbpass',
    database: 'ecommerce_south',
    seedFile: 'seed-south.sql'
  },
  {
    name: 'East',
    host: 'localhost',
    port: 5437,
    user: 'dbuser',
    password: 'dbpass',
    database: 'ecommerce_east',
    seedFile: 'seed-east.sql'
  }
];

async function restoreDatabase(config: any) {
  const client = new Client({
    host: config.host,
    port: config.port,
    user: config.user,
    password: config.password,
    database: config.database
  });

  try {
    await client.connect();
    console.log(`Connected to ${config.name} database`);

    // Drop all tables (in correct order to handle foreign keys)
    console.log(`Dropping tables in ${config.name}...`);
    await client.query('DROP TABLE IF EXISTS order_items CASCADE');
    await client.query('DROP TABLE IF EXISTS orders CASCADE');
    await client.query('DROP TABLE IF EXISTS customers CASCADE');
    await client.query('DROP TABLE IF EXISTS products CASCADE');
    await client.query('DROP TABLE IF EXISTS categories CASCADE');

    // Read and execute schema file
    console.log(`Creating schema in ${config.name}...`);
    const schemaPath = path.join(__dirname, '..', 'database', 'migrations', 'init-schema.sql');
    const schemaSQL = fs.readFileSync(schemaPath, 'utf8');
    await client.query(schemaSQL);

    // Read and execute seed file
    console.log(`Seeding data in ${config.name}...`);
    const seedPath = path.join(__dirname, '..', 'database', 'seeds', config.seedFile);
    const seedSQL = fs.readFileSync(seedPath, 'utf8');
    await client.query(seedSQL);

    console.log(`✅ ${config.name} database restored successfully\n`);
  } catch (error) {
    console.error(`❌ Error restoring ${config.name} database:`, error.message);
    throw error;
  } finally {
    await client.end();
  }
}

async function restoreAllDatabases() {
  console.log('🔄 Starting database restoration process...\n');

  try {
    for (const db of databases) {
      await restoreDatabase(db);
    }
    console.log('✅ All databases restored successfully!');
  } catch (error) {
    console.error('❌ Restoration process failed:', error.message);
    process.exit(1);
  }
}

// Run restoration
restoreAllDatabases();
