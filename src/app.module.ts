import { Module } from '@nestjs/common';
import { ConfigModule } from '@nestjs/config';
import { DatabaseModule } from './database/database.module';
import { DatabasesModule } from './modules/databases/databases.module';
import { TablesModule } from './modules/tables/tables.module';
import { AppController } from './app.controller';

@Module({
  imports: [
    ConfigModule.forRoot({
      isGlobal: true,
      envFilePath: '.env',
    }),
    DatabaseModule,
    DatabasesModule,
    TablesModule,
  ],
  controllers: [AppController],
})
export class AppModule {}
