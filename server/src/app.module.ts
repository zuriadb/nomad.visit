import { Module } from '@nestjs/common';
import { TypeOrmModule } from '@nestjs/typeorm';
import { ConfigModule } from '@nestjs/config';
import { databaseConfig } from './orm.config';
import { UsersModule } from './users/users.module';
import { RecomendationsModule } from './recomendations/recomendations.module';
import { AuthModule } from './auth/auth.module';
import { AiChatModule } from './ai-chat/ai-chat.module';

@Module({
  imports: [
    AuthModule,
    UsersModule,
    ConfigModule.forRoot({ isGlobal: true }),
    TypeOrmModule.forRoot(databaseConfig),
    RecomendationsModule,
    AiChatModule,
  ],
  controllers: [],
  providers: [],
})
export class AppModule {}
