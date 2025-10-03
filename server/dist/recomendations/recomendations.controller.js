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
var __param = (this && this.__param) || function (paramIndex, decorator) {
    return function (target, key) { decorator(target, key, paramIndex); }
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.RecomendationsController = void 0;
const common_1 = require("@nestjs/common");
const recomendations_dto_1 = require("./dto/recomendations.dto");
const generative_ai_service_1 = require("./generative-ai.service");
const recomendations_service_1 = require("./recomendations.service");
const swagger_1 = require("@nestjs/swagger");
const common_2 = require("@nestjs/common");
const jwt_auth_guard_1 = require("../auth/guards/jwt-auth.guard");
const roles_guard_1 = require("../auth/roles/roles.guard");
const roles_decorator_1 = require("../auth/roles/roles.decorator");
const roles_enum_1 = require("../auth/roles/roles.enum");
let RecomendationsController = class RecomendationsController {
    generativeAiService;
    recomendationsService;
    constructor(generativeAiService, recomendationsService) {
        this.generativeAiService = generativeAiService;
        this.recomendationsService = recomendationsService;
    }
    async generateRecomendations(dto) {
        return this.generativeAiService.generateAndSave(dto);
    }
    async getAllRecomendations() {
        return this.recomendationsService.findAll();
    }
    async getRecomendationById(id) {
        return this.recomendationsService.findOne(id);
    }
};
exports.RecomendationsController = RecomendationsController;
__decorate([
    (0, common_1.Post)('generate'),
    __param(0, (0, common_1.Body)()),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [recomendations_dto_1.LlmContextDto]),
    __metadata("design:returntype", Promise)
], RecomendationsController.prototype, "generateRecomendations", null);
__decorate([
    (0, common_1.Get)(),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", []),
    __metadata("design:returntype", Promise)
], RecomendationsController.prototype, "getAllRecomendations", null);
__decorate([
    (0, common_1.Get)(':id'),
    (0, roles_decorator_1.Roles)(roles_enum_1.Role.User),
    __param(0, (0, common_1.Param)('id')),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [String]),
    __metadata("design:returntype", Promise)
], RecomendationsController.prototype, "getRecomendationById", null);
exports.RecomendationsController = RecomendationsController = __decorate([
    (0, swagger_1.ApiBearerAuth)(),
    (0, common_2.UseGuards)(jwt_auth_guard_1.JwtAuthGuard, roles_guard_1.RolesGuard),
    (0, common_1.Controller)('recomendations'),
    __metadata("design:paramtypes", [generative_ai_service_1.GenerativeAiService,
        recomendations_service_1.RecomendationsService])
], RecomendationsController);
//# sourceMappingURL=recomendations.controller.js.map