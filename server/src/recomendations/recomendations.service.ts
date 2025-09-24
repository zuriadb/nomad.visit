import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { RecommendationEntity } from './entity/recomendations.entity';
import { GoogleGenerativeAI } from '@google/generative-ai';
import { Recommendation } from './interface/recomendations.interface';

@Injectable()
export class RecomendationsService {
  private genAI: GoogleGenerativeAI;

  constructor(
    @InjectRepository(RecommendationEntity)
    private readonly recommendationRepo: Repository<RecommendationEntity>,
  ) {}

  async findAll(): Promise<Recommendation[]> {
    return this.recommendationRepo.find();
  }

  async findOne(id: string): Promise<Recommendation | null> {
    return this.recommendationRepo.findOneBy({ id });
  }

  async createMany(data: Partial<RecommendationEntity>[]) {
  const entities = this.recommendationRepo.create(data);
  return this.recommendationRepo.save(entities);
}

  async update(id: string, data: Partial<Recommendation>) {
    await this.recommendationRepo.update(id, data);
    return this.findOne(id);
  }

  async remove(id: string) {
    await this.recommendationRepo.delete(id);
    return { deleted: true };
  }
}


