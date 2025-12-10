import { Controller, Post, Body, Logger } from '@nestjs/common';
import { ChatService } from './ai-chat.service';

@Controller('api/chat')
export class ChatController {
  private readonly logger = new Logger(ChatController.name);

  constructor(private readonly chatService: ChatService) {}

  @Post('message')
  async sendMessage(@Body() body: { message: string }) {
    this.logger.log(`Получено сообщение: ${body.message}`);
    
    try {
      const response = await this.chatService.generateResponse(body.message);
      return {
        success: true,
        response,
      };
    } catch (error) {
      this.logger.error(`Ошибка при обработке сообщения: ${error.message}`);
      return {
        success: false,
        error: 'Не удалось получить ответ от AI',
      };
    }
  }
}
