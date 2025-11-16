import { Injectable, NotFoundException, BadRequestException } from '@nestjs/common';
import { DatabaseService } from '../../database/database.service';

@Injectable()
export class TablesService {
  constructor(private readonly databaseService: DatabaseService) {}

  /**
   * Get all records from a table
   */
  async getTableData(tableName: string): Promise<any[]> {
    try {
      const query = `SELECT * FROM "${tableName}" ORDER BY id`;
      const data = await this.databaseService.query(query);
      return data;
    } catch (error) {
      if (error.code === '42P01') {
        throw new NotFoundException(`Table "${tableName}" does not exist`);
      }
      throw error;
    }
  }

  /**
   * Get a single record by ID
   */
  async getRecordById(tableName: string, id: number): Promise<any> {
    try {
      const query = `SELECT * FROM "${tableName}" WHERE id = $1`;
      const data = await this.databaseService.query(query, [id]);

      if (!data || data.length === 0) {
        throw new NotFoundException(
          `Record with ID ${id} not found in table "${tableName}"`
        );
      }

      return data[0];
    } catch (error) {
      if (error.code === '42P01') {
        throw new NotFoundException(`Table "${tableName}" does not exist`);
      }
      throw error;
    }
  }

  /**
   * Update a record by ID
   */
  async updateRecord(
    tableName: string,
    id: number,
    updateData: Record<string, any>,
  ): Promise<any> {
    // Remove id and created_at from update data
    const { id: _, created_at, order_date, ...cleanData } = updateData;

    if (Object.keys(cleanData).length === 0) {
      throw new BadRequestException('No valid fields to update');
    }

    // Build SET clause
    const setClause = Object.keys(cleanData)
      .map((key, index) => `"${key}" = $${index + 2}`)
      .join(', ');

    const values = [id, ...Object.values(cleanData)];

    try {
      // Update the record
      const updateQuery = `
        UPDATE "${tableName}"
        SET ${setClause}
        WHERE id = $1
        RETURNING *
      `;

      const result = await this.databaseService.query(updateQuery, values);

      if (!result || result.length === 0) {
        throw new NotFoundException(
          `Record with ID ${id} not found in table "${tableName}"`
        );
      }

      return result[0];
    } catch (error) {
      if (error.code === '42P01') {
        throw new NotFoundException(`Table "${tableName}" does not exist`);
      }
      if (error.code === '42703') {
        throw new BadRequestException(`Invalid column in update data`);
      }
      throw error;
    }
  }

  /**
   * Get table schema/columns
   */
  async getTableSchema(tableName: string): Promise<any[]> {
    const query = `
      SELECT column_name, data_type, is_nullable
      FROM information_schema.columns
      WHERE table_name = $1
      ORDER BY ordinal_position
    `;

    const result = await this.databaseService.query(query, [tableName]);
    return result;
  }
}
