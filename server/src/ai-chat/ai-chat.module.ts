import { Module } from '@nestjs/common';
import { ChatService } from './ai-chat.service';
import { ChatController } from './ai-chat.controller';

@Module({

  providers: [ChatService],
  controllers: [ChatController],
  exports: [ChatService],
})
export class AiChatModule {}
