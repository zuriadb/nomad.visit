import { Body, Controller, Get, Param, Post } from '@nestjs/common';
import { LlmContextDto } from './dto/recomendations.dto';
import { GenerativeAiService } from './generative-ai.service';
import { RecomendationsService } from './recomendations.service';
import { ApiBearerAuth } from '@nestjs/swagger';
import { UseGuards } from '@nestjs/common';
import { JwtAuthGuard } from 'src/auth /guards/jwt-auth.guard';
import { RolesGuard } from 'src/auth /roles/roles.guard';
import { Roles } from 'src/auth /roles/roles.decorator';
import { Role } from 'src/auth /roles/roles.enum';

@ApiBearerAuth()
@UseGuards(JwtAuthGuard, RolesGuard)
@Controller('recomendations')
export class RecomendationsController {
    constructor(
        private readonly generativeAiService: GenerativeAiService,
        private readonly recomendationsService: RecomendationsService,
    ) {}        

    @Post('generate')
    async generateRecomendations(
        @Body() dto:LlmContextDto ) {
        return this.generativeAiService.generateAndSave(dto);
    }

    @Get()
    async getAllRecomendations() {
        return this.recomendationsService.findAll();
    }

    @Get(':id')
    @Roles(Role.User)
    async getRecomendationById(
        @Param('id') id: string) {
        return this.recomendationsService.findOne(id);
    }
}
