import { Repository } from 'typeorm';
import { RecommendationEntity } from './entity/recomendations.entity';
import { Recommendation } from './interface/recomendations.interface';
export declare class RecomendationsService {
    private readonly recommendationRepo;
    private genAI;
    constructor(recommendationRepo: Repository<RecommendationEntity>);
    findAll(): Promise<Recommendation[]>;
    findOne(id: string): Promise<Recommendation | null>;
    createMany(data: Partial<RecommendationEntity>[]): Promise<RecommendationEntity[]>;
    update(id: string, data: Partial<Recommendation>): Promise<Recommendation | null>;
    remove(id: string): Promise<{
        deleted: boolean;
    }>;
}
