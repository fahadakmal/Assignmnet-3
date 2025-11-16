import { Injectable, OnModuleInit, BadRequestException } from '@nestjs/common';
import { DataSource } from 'typeorm';
import { dataSources, DatabaseName, databaseConfigs } from './database.config';

@Injectable()
export class DatabaseService implements OnModuleInit {
  private activeDatabase: DatabaseName = 'NORTH';
  private connections: Map<DatabaseName, DataSource> = new Map();

  async onModuleInit() {
    // Initialize all database connections
    console.log('🔌 Connecting to all databases...');

    for (const [name, dataSource] of Object.entries(dataSources)) {
      try {
        if (!dataSource.isInitialized) {
          await dataSource.initialize();
        }
        this.connections.set(name as DatabaseName, dataSource);
        console.log(`✅ Connected to ${name} database`);
      } catch (error) {
        console.error(`❌ Failed to connect to ${name} database:`, error.message);
        throw error;
      }
    }

    console.log('✅ All databases connected successfully\n');
  }

  /**
   * Get the currently active database connection
   */
  getActiveConnection(): DataSource {
    const connection = this.connections.get(this.activeDatabase);
    if (!connection) {
      throw new BadRequestException(`Database ${this.activeDatabase} is not connected`);
    }
    return connection;
  }

  /**
   * Get the name of the currently active database
   */
  getActiveDatabaseName(): DatabaseName {
    return this.activeDatabase;
  }

  /**
   * Switch to a different database
   */
  selectDatabase(dbName: string): void {
    const upperDbName = dbName.toUpperCase() as DatabaseName;

    if (!this.connections.has(upperDbName)) {
      throw new BadRequestException(
        `Invalid database name: ${dbName}. Valid options: NORTH, SOUTH, EAST`
      );
    }

    this.activeDatabase = upperDbName;
    console.log(`📊 Switched to ${upperDbName} database`);
  }

  /**
   * Get all available database names
   */
  getAllDatabases(): Array<{ name: DatabaseName; config: any; active: boolean }> {
    return Array.from(this.connections.keys()).map(name => {
      const config = databaseConfigs[name] as any;
      return {
        name,
        config: {
          host: config.host,
          port: config.port,
          database: config.database,
        },
        active: name === this.activeDatabase,
      };
    });
  }

  /**
   * Get a specific database connection (for direct access)
   */
  getConnection(dbName: DatabaseName): DataSource {
    const connection = this.connections.get(dbName);
    if (!connection) {
      throw new BadRequestException(`Database ${dbName} is not connected`);
    }
    return connection;
  }

  /**
   * Execute a raw SQL query on the active database
   */
  async query<T = any>(sql: string, parameters?: any[]): Promise<T> {
    const connection = this.getActiveConnection();
    return connection.query(sql, parameters);
  }

  /**
   * Get all table names from the active database
   */
  async getTables(): Promise<string[]> {
    const result = await this.query<Array<{ tablename: string }>>(
      `SELECT tablename FROM pg_catalog.pg_tables
       WHERE schemaname = 'public'
       ORDER BY tablename`
    );
    return result.map(row => row.tablename);
  }
}
