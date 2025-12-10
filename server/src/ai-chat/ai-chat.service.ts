import { Injectable, Logger } from '@nestjs/common';
import { GoogleGenerativeAI } from '@google/generative-ai';

@Injectable()
export class ChatService {
  private readonly logger = new Logger(ChatService.name);
  private genAI: GoogleGenerativeAI;
  private requestCount = 0;

  // Список моделей для текстовых ответов, начиная с основной
  private models = [
    'gemini-2.5-flash',
    'gemini-2.5-pro',
    'gemini-flash-latest',
    'gemini-flash-lite-latest'
  ];

  constructor() {
    this.genAI = new GoogleGenerativeAI(process.env.GEMINI_API_KEY || 'YOUR_API_KEY');
  }

  async generateResponse(userMessage: string): Promise<string> {
    this.requestCount++;
    this.logger.log(`Отправка запроса к Gemini. Текущее количество запросов: ${this.requestCount}`);

    const prompt = `Ты — дружелюбный AI-гид по городам Казахстана. 
Отвечай на русском или казахском языке в зависимости от языка вопроса.
Предоставляй полезную информацию о достопримечательностях, ресторанах, отелях, 
транспорте и культуре городов Казахстана. Будь кратким, но информативным.
Используй эмодзи для дружелюбности.

Вопрос пользователя: ${userMessage}`;

    // Пробуем каждую модель из списка до успешного запроса
    for (const modelName of this.models) {
      try {
        const model = this.genAI.getGenerativeModel({
          model: modelName,
          generationConfig: {
            temperature: 0.7,
            topP: 0.9,
            maxOutputTokens: 500,
          },
        });

        const result = await model.generateContent(prompt);
        const text = result.response.text();

        const tokenCount = result.response.usageMetadata?.totalTokenCount ?? 'unknown';
        const inputTokens = result.response.usageMetadata?.promptTokenCount ?? 'unknown';
        const outputTokens = result.response.usageMetadata?.candidatesTokenCount ?? 'unknown';

        this.logger.log(
          `Успешно получен ответ от модели ${modelName}. ` +
          `Входных токенов: ${inputTokens}, ` +
          `Выходных токенов: ${outputTokens}, ` +
          `Всего токенов: ${tokenCount}`
        );

        return text;
      } catch (error) {
        this.logger.warn(`Модель ${modelName} недоступна: ${error.message}`);
        // Если ошибка 503 (перегрузка), пробуем следующую модель
        if (!error.message.includes('503')) {
          // Для других ошибок — выбрасываем
          throw error;
        }
      }
    }

    throw new Error('Все модели перегружены или недоступны. Попробуйте позже.');
  }
}
