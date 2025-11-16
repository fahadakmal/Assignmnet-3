import { Controller, Get, Put, Param, Body, Post, BadRequestException } from '@nestjs/common';
import { DatabaseService } from '../../database/database.service';
import { TablesService } from './tables.service';

@Controller('tables')
export class TablesController {
  constructor(
    private readonly databaseService: DatabaseService,
    private readonly tablesService: TablesService,
  ) {}

  @Get()
  async getTables() {
    const tables = await this.databaseService.getTables();
    return {
      database: this.databaseService.getActiveDatabaseName(),
      tables,
    };
  }

  @Get(':tableName')
  async getTableData(@Param('tableName') tableName: string) {
    const data = await this.tablesService.getTableData(tableName);
    return {
      database: this.databaseService.getActiveDatabaseName(),
      table: tableName,
      count: data.length,
      data,
    };
  }

  @Get(':tableName/:id')
  async getRecordById(
    @Param('tableName') tableName: string,
    @Param('id') id: string,
  ) {
    const data = await this.tablesService.getRecordById(tableName, parseInt(id));
    return {
      database: this.databaseService.getActiveDatabaseName(),
      table: tableName,
      data,
    };
  }

  @Put(':tableName/:id')
  async updateRecord(
    @Param('tableName') tableName: string,
    @Param('id') id: string,
    @Body() updateData: Record<string, any>,
  ) {
    const updated = await this.tablesService.updateRecord(
      tableName,
      parseInt(id),
      updateData,
    );
    return {
      database: this.databaseService.getActiveDatabaseName(),
      table: tableName,
      message: 'Record updated successfully',
      data: updated,
    };
  }

  @Post('restore')
  async restoreAllDatabases() {
    // This will be handled by a restoration script
    return {
      message: 'Please use "npm run restore" command to restore all databases',
      command: 'npm run restore',
    };
  }
}
