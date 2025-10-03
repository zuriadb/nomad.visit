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
var HttpExceptionFilter_1;
Object.defineProperty(exports, "__esModule", { value: true });
exports.HttpExceptionFilter = void 0;
const common_1 = require("@nestjs/common");
const config_1 = require("@nestjs/config");
let HttpExceptionFilter = HttpExceptionFilter_1 = class HttpExceptionFilter {
    configService;
    logger = new common_1.Logger(HttpExceptionFilter_1.name);
    isDevelopment;
    constructor(configService) {
        this.configService = configService;
        this.isDevelopment = this.configService.get('NODE_ENV') === 'development';
    }
    onModuleInit() {
        if (this.isDevelopment) {
            this.logger.warn('HttpExceptionFilter initialized in development mode');
        }
        this.logger.warn('HttpExceptionFilter initialized');
    }
    catch(exception, host) {
        const ctx = host.switchToHttp();
        const response = ctx.getResponse();
        const request = ctx.getRequest();
        const { status, message, error } = this.getErrorInfo(exception);
        const errorResponse = {
            statusCode: status,
            success: false,
            message: 'Request failed',
            error: this.isDevelopment ? error : message,
            timestamp: new Date().toISOString(),
            path: request.url,
        };
        if (this.isDevelopment) {
            this.logger.error(`${request.method} ${request.url} - ${status} ${message}, ip: ${request.ip}`, exception instanceof Error ? exception.stack : String(exception));
        }
        response.status(status).json(errorResponse);
    }
    getErrorInfo(exception) {
        if (exception instanceof common_1.HttpException) {
            const status = exception.getStatus();
            const response = exception.getResponse();
            if (typeof response === 'object' && response !== null) {
                const responseObj = response;
                return {
                    status,
                    message: responseObj.message || exception.message,
                    error: Array.isArray(responseObj.message)
                        ? responseObj.message.join(', ')
                        : responseObj.message || exception.message,
                };
            }
            return {
                status,
                message: exception.message,
                error: exception.message,
            };
        }
        return {
            status: common_1.HttpStatus.INTERNAL_SERVER_ERROR,
            message: 'Internal server error',
            error: exception instanceof Error
                ? exception.message
                : 'Unknown error occurred',
        };
    }
};
exports.HttpExceptionFilter = HttpExceptionFilter;
exports.HttpExceptionFilter = HttpExceptionFilter = HttpExceptionFilter_1 = __decorate([
    (0, common_1.Catch)(),
    __metadata("design:paramtypes", [config_1.ConfigService])
], HttpExceptionFilter);
//# sourceMappingURL=api-response.filter.js.map