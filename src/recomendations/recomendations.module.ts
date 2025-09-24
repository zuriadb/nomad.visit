import { Module } from '@nestjs/common';
import { RecomendationsService } from './recomendations.service';
import { RecomendationsController } from './recomendations.controller';
import { TypeOrmModule } from '@nestjs/typeorm';
import { RecommendationEntity } from './entity/recomendations.entity';
import { GenerativeAiService } from './generative-ai.service';

@Module({
  imports: [
    TypeOrmModule.forFeature([RecommendationEntity])
  ],
  providers: [
    RecomendationsService , 
    GenerativeAiService 
  ],
  controllers: [
    RecomendationsController
  ],
  exports: [
    RecomendationsService , 
    GenerativeAiService 
  ],
})
export class RecomendationsModule {}
