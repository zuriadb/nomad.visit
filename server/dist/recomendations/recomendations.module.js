"use strict";
var __decorate = (this && this.__decorate) || function (decorators, target, key, desc) {
    var c = arguments.length, r = c < 3 ? target : desc === null ? desc = Object.getOwnPropertyDescriptor(target, key) : desc, d;
    if (typeof Reflect === "object" && typeof Reflect.decorate === "function") r = Reflect.decorate(decorators, target, key, desc);
    else for (var i = decorators.length - 1; i >= 0; i--) if (d = decorators[i]) r = (c < 3 ? d(r) : c > 3 ? d(target, key, r) : d(target, key)) || r;
    return c > 3 && r && Object.defineProperty(target, key, r), r;
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.RecomendationsModule = void 0;
const common_1 = require("@nestjs/common");
const recomendations_service_1 = require("./recomendations.service");
const recomendations_controller_1 = require("./recomendations.controller");
const typeorm_1 = require("@nestjs/typeorm");
const recomendations_entity_1 = require("./entity/recomendations.entity");
const generative_ai_service_1 = require("./generative-ai.service");
let RecomendationsModule = class RecomendationsModule {
};
exports.RecomendationsModule = RecomendationsModule;
exports.RecomendationsModule = RecomendationsModule = __decorate([
    (0, common_1.Module)({
        imports: [
            typeorm_1.TypeOrmModule.forFeature([recomendations_entity_1.RecommendationEntity])
        ],
        providers: [
            recomendations_service_1.RecomendationsService,
            generative_ai_service_1.GenerativeAiService
        ],
        controllers: [
            recomendations_controller_1.RecomendationsController
        ],
        exports: [
            recomendations_service_1.RecomendationsService,
            generative_ai_service_1.GenerativeAiService
        ],
    })
], RecomendationsModule);
//# sourceMappingURL=recomendations.module.js.map