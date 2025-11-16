import { DataSource, DataSourceOptions } from 'typeorm';
import * as dotenv from 'dotenv';

// Load environment variables
dotenv.config();

// Database configurations
export const databaseConfigs = {
  NORTH: {
    type: 'postgres' as const,
    host: process.env.DB_NORTH_HOST || 'localhost',
    port: parseInt(process.env.DB_NORTH_PORT || '5432'),
    username: process.env.DB_NORTH_USER || 'dbuser',
    password: process.env.DB_NORTH_PASSWORD || 'dbpass',
    database: process.env.DB_NORTH_NAME || 'ecommerce_north',
    synchronize: false,
    logging: false,
  } as DataSourceOptions,

  SOUTH: {
    type: 'postgres' as const,
    host: process.env.DB_SOUTH_HOST || 'localhost',
    port: parseInt(process.env.DB_SOUTH_PORT || '5433'),
    username: process.env.DB_SOUTH_USER || 'dbuser',
    password: process.env.DB_SOUTH_PASSWORD || 'dbpass',
    database: process.env.DB_SOUTH_NAME || 'ecommerce_south',
    synchronize: false,
    logging: false,
  } as DataSourceOptions,

  EAST: {
    type: 'postgres' as const,
    host: process.env.DB_EAST_HOST || 'localhost',
    port: parseInt(process.env.DB_EAST_PORT || '5434'),
    username: process.env.DB_EAST_USER || 'dbuser',
    password: process.env.DB_EAST_PASSWORD || 'dbpass',
    database: process.env.DB_EAST_NAME || 'ecommerce_east',
    synchronize: false,
    logging: false,
  } as DataSourceOptions,
};

export type DatabaseName = keyof typeof databaseConfigs;

// Create DataSource instances
export const dataSources: Record<DatabaseName, DataSource> = {
  NORTH: new DataSource(databaseConfigs.NORTH),
  SOUTH: new DataSource(databaseConfigs.SOUTH),
  EAST: new DataSource(databaseConfigs.EAST),
};
