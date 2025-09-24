import { Injectable , Logger } from "@nestjs/common";
import { LlmContextDto } from "./dto/recomendations.dto";
import { GoogleGenerativeAI } from "@google/generative-ai";
import { recomendationsPromt } from "./promt/recomendations.promt";
import { HttpException, HttpStatus } from "@nestjs/common";
import { RecomendationsService } from "./recomendations.service";

@Injectable()
export class GenerativeAiService {
  private readonly genAI: GoogleGenerativeAI;
  private readonly logger = new Logger(GenerativeAiService.name);
  private requestCount = 0;
  private lastResetTime = Date.now();
  private readonly RATE_LIMIT_PER_MINUTE = 20;

  constructor(
    private readonly recomendationsService: RecomendationsService,
  ) {
    this.genAI = new GoogleGenerativeAI(process.env.GEMINI_API_KEY || '');
  }

  async generateAndSave(dto: LlmContextDto) {
    this.checkRateLimit();

    const prompt = recomendationsPromt(
      dto.cityName,
      dto.userPreferences,
      dto.currentWeather,
      dto.timeOfDay,
      dto.season,
    );

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

      const recommendationsToSave = parsed.recommendations.map((rec: any) => ({
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
    } catch (err) {
      this.logger.error(`Ошибка при запросе к Gemini: ${err.message}`, err.stack);
      throw new HttpException(
        `Ошибка при генерации и сохранении рекомендаций: ${err.message}`,
        HttpStatus.BAD_REQUEST,
      );
    }
  }

  private checkRateLimit() {
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
      throw new HttpException(
        'Превышен лимит запросов. Попробуйте снова через минуту.',
        HttpStatus.TOO_MANY_REQUESTS,
      );
    }
  }
}