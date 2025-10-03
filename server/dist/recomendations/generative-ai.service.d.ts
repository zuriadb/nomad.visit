import { LlmContextDto } from "./dto/recomendations.dto";
import { RecomendationsService } from "./recomendations.service";
export declare class GenerativeAiService {
    private readonly recomendationsService;
    private readonly genAI;
    private readonly logger;
    private requestCount;
    private lastResetTime;
    private readonly RATE_LIMIT_PER_MINUTE;
    constructor(recomendationsService: RecomendationsService);
    generateAndSave(dto: LlmContextDto): Promise<{
        recommendations: any;
        summary: any;
    }>;
    private checkRateLimit;
}
