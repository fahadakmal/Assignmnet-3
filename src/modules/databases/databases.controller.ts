import { Controller, Get, Post, Body } from '@nestjs/common';
import { DatabaseService } from '../../database/database.service';

@Controller('databases')
export class DatabasesController {
  constructor(private readonly databaseService: DatabaseService) {}

  @Get()
  getAllDatabases() {
    return {
      databases: this.databaseService.getAllDatabases(),
      active: this.databaseService.getActiveDatabaseName(),
    };
  }

  @Post('select')
  selectDatabase(@Body('database') database: string) {
    this.databaseService.selectDatabase(database);
    return {
      message: `Successfully switched to ${database.toUpperCase()} database`,
      active: this.databaseService.getActiveDatabaseName(),
    };
  }
}
