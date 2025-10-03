import { NestInterceptor, ExecutionContext, CallHandler, OnModuleInit } from '@nestjs/common';
import { Observable } from 'rxjs';
import { ApiResponse } from '../interfaces/api-response.interface';
import { ConfigService } from '@nestjs/config';
export declare class ResponseInterceptor<T> implements NestInterceptor<T, ApiResponse<T>>, OnModuleInit {
    private readonly configService;
    private readonly logger;
    private readonly isDevelopment;
    constructor(configService: ConfigService);
    onModuleInit(): void;
    intercept(context: ExecutionContext, next: CallHandler): Observable<ApiResponse<T>>;
}
