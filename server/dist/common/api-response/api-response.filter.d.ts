import { ExceptionFilter, ArgumentsHost, OnModuleInit } from '@nestjs/common';
import { ConfigService } from '@nestjs/config';
export declare class HttpExceptionFilter implements ExceptionFilter, OnModuleInit {
    private readonly configService;
    private readonly logger;
    private readonly isDevelopment;
    constructor(configService: ConfigService);
    onModuleInit(): void;
    catch(exception: unknown, host: ArgumentsHost): void;
    private getErrorInfo;
}
