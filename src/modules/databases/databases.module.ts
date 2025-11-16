import { Module } from '@nestjs/common';
import { DatabasesController } from './databases.controller';

@Module({
  controllers: [DatabasesController],
})
export class DatabasesModule {}
