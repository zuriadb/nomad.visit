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
var ResponseInterceptor_1;
Object.defineProperty(exports, "__esModule", { value: true });
exports.ResponseInterceptor = void 0;
const common_1 = require("@nestjs/common");
const rxjs_1 = require("rxjs");
const config_1 = require("@nestjs/config");
let ResponseInterceptor = ResponseInterceptor_1 = class ResponseInterceptor {
    configService;
    logger = new common_1.Logger(ResponseInterceptor_1.name);
    isDevelopment;
    constructor(configService) {
        this.configService = configService;
        this.isDevelopment = this.configService.get('NODE_ENV') === 'development';
    }
    onModuleInit() {
        if (this.isDevelopment) {
            this.logger.warn('ResponseInterceptor initialized in development mode');
        }
        this.logger.warn('ResponseInterceptor initialized');
    }
    intercept(context, next) {
        const request = context.switchToHttp().getRequest();
        const response = context.switchToHttp().getResponse();
        const { url } = request;
        return next.handle().pipe((0, rxjs_1.map)((data) => {
            const statusCode = response.statusCode;
            const apiResponse = {
                success: true,
                statusCode,
                message: 'Request processed successfully',
                data,
                timestamp: new Date().toISOString(),
                path: url,
            };
            return apiResponse;
        }));
    }
};
exports.ResponseInterceptor = ResponseInterceptor;
exports.ResponseInterceptor = ResponseInterceptor = ResponseInterceptor_1 = __decorate([
    (0, common_1.Injectable)(),
    __metadata("design:paramtypes", [config_1.ConfigService])
], ResponseInterceptor);
//# sourceMappingURL=api-response.interceptor.js.map