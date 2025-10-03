import { LlmContextDto } from './dto/recomendations.dto';
import { GenerativeAiService } from './generative-ai.service';
import { RecomendationsService } from './recomendations.service';
export declare class RecomendationsController {
    private readonly generativeAiService;
    private readonly recomendationsService;
    constructor(generativeAiService: GenerativeAiService, recomendationsService: RecomendationsService);
    generateRecomendations(dto: LlmContextDto): Promise<{
        recommendations: any;
        summary: any;
    }>;
    getAllRecomendations(): Promise<import("./interface/recomendations.interface").Recommendation[]>;
    getRecomendationById(id: string): Promise<import("./interface/recomendations.interface").Recommendation | null>;
}
