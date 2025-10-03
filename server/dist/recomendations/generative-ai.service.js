"use strict";
var __decorate = (this && this.__decorate) || function (decorators, target, key, desc) {
    var c = arguments.length, r = c < 3 ? target : desc === null ? desc = Object.getOwnPropertyDescriptor(target, key) : desc, d;
    if (typeof Reflect === "object" && typeof Reflect.decorate === "function") r = Reflect.decorate(decorators, target, key, desc);
    else for (var i = decorators.length - 1; i >= 0; i--) if (d = decorators[i]) r = (c < 3 ? d(r) : c > 3 ? d(target, key, r) : d(target, key)) || r;
    return c > 3 && r && Object.defineProperty(target, key, r), r;
};
var __metadata = (this && this.__metadata) || function (k, v) {
    if (typeof Reflect === "object" && typeof Reflect.metadata === "function") return Reflect.metadata(k, v);
};
var GenerativeAiService_1;
Object.defineProperty(exports, "__esModule", { value: true });
exports.GenerativeAiService = void 0;
const common_1 = require("@nestjs/common");
const generative_ai_1 = require("@google/generative-ai");
const recomendations_promt_1 = require("./promt/recomendations.promt");
const common_2 = require("@nestjs/common");
const recomendations_service_1 = require("./recomendations.service");
let GenerativeAiService = GenerativeAiService_1 = class GenerativeAiService {
    recomendationsService;
    genAI;
    logger = new common_1.Logger(GenerativeAiService_1.name);
    requestCount = 0;
    lastResetTime = Date.now();
    RATE_LIMIT_PER_MINUTE = 20;
    constructor(recomendationsService) {
        this.recomendationsService = recomendationsService;
        this.genAI = new generative_ai_1.GoogleGenerativeAI(process.env.GEMINI_API_KEY || '');
    }
    async generateAndSave(dto) {
        this.checkRateLimit();
        const prompt = (0, recomendations_promt_1.recomendationsPromt)(dto.cityName, dto.userPreferences, dto.currentWeather, dto.timeOfDay, dto.season);
        try {
            this.logger.log(`Отправка запроса к Gemini. Текущее количество запросов: ${this.requestCount}`);
            const model = this.genAI.getGenerativeModel({ model: "gemini-1.5-flash" });
            const result = await model.generateContent(prompt);
            const text = result.response.text();
            const jsonMatch = text.match(/\{[\s\S]*\}/);
            if (!jsonMatch) {
                throw new Error("Не удалось найти JSON-структуру в ответе.");
            }
            const parsed = JSON.parse(jsonMatch[0]);
            const tokenCount = result.response.usageMetadata?.totalTokenCount ?? 'unknown';
            this.logger.log(`Успешно получен и обработан ответ от Gemini. Всего токенов: ${tokenCount}`);
            const recommendationsToSave = parsed.recommendations.map((rec) => ({
                placeName: rec.placeName,
                description: rec.description,
                reason: rec.reason,
                estimatedPrice: rec.estimatedPrice,
                timeToVisit: rec.timeToVisit,
                cityName: dto.cityName,
            }));
            await this.recomendationsService.createMany(recommendationsToSave);
            this.logger.log(`Рекомендации успешно сохранены в базе данных.`);
            return {
                recommendations: parsed.recommendations,
                summary: parsed.summary,
            };
        }
        catch (err) {
            this.logger.error(`Ошибка при запросе к Gemini: ${err.message}`, err.stack);
            throw new common_2.HttpException(`Ошибка при генерации и сохранении рекомендаций: ${err.message}`, common_2.HttpStatus.BAD_REQUEST);
        }
    }
    checkRateLimit() {
        const now = Date.now();
        const oneMinute = 60 * 1000;
        if (now - this.lastResetTime > oneMinute) {
            this.requestCount = 0;
            this.lastResetTime = now;
            this.logger.log('Счетчик запросов сброшен.');
        }
        this.requestCount++;
        if (this.requestCount > this.RATE_LIMIT_PER_MINUTE) {
            this.logger.warn(`Превышен локальный лимит запросов (${this.RATE_LIMIT_PER_MINUTE} запросов/мин).`);
            throw new common_2.HttpException('Превышен лимит запросов. Попробуйте снова через минуту.', common_2.HttpStatus.TOO_MANY_REQUESTS);
        }
    }
};
exports.GenerativeAiService = GenerativeAiService;
exports.GenerativeAiService = GenerativeAiService = GenerativeAiService_1 = __decorate([
    (0, common_1.Injectable)(),
    __metadata("design:paramtypes", [recomendations_service_1.RecomendationsService])
], GenerativeAiService);
//# sourceMappingURL=generative-ai.service.js.map