import {
  ExceptionFilter,
  Catch,
  ArgumentsHost,
  HttpException,
  HttpStatus,
  Logger,
  OnModuleInit,
} from '@nestjs/common';
import { ConfigService } from '@nestjs/config';
import { Request, Response } from 'express';
import { ApiResponse } from './interfaces/api-response.interface';

@Catch()
export class HttpExceptionFilter implements ExceptionFilter, OnModuleInit {
  private readonly logger = new Logger(HttpExceptionFilter.name);
  private readonly isDevelopment: boolean;

  constructor(private readonly configService: ConfigService) {
    this.isDevelopment = this.configService.get('NODE_ENV') === 'development';
  }

  onModuleInit() {
    if (this.isDevelopment) {
      this.logger.warn('HttpExceptionFilter initialized in development mode');
    }
    this.logger.warn('HttpExceptionFilter initialized');
  }

  catch(exception: unknown, host: ArgumentsHost): void {
    const ctx = host.switchToHttp();
    const response = ctx.getResponse<Response>();
    const request = ctx.getRequest<Request>();

    const { status, message, error } = this.getErrorInfo(exception);

    const errorResponse: ApiResponse = {
      statusCode: status,
      success: false,
      message: 'Request failed',
      error: this.isDevelopment ? error : message,
      timestamp: new Date().toISOString(),
      path: request.url,
    };

    // Логирование ошибок только в development режиме
    if (this.isDevelopment) {
      this.logger.error(
        `${request.method} ${request.url} - ${status} ${message}, ip: ${request.ip}`,
        exception instanceof Error ? exception.stack : String(exception),
      );
    }

    response.status(status).json(errorResponse);
  }

  private getErrorInfo(exception: unknown): {
    status: number;
    message: string;
    error: string;
  } {
    if (exception instanceof HttpException) {
      const status = exception.getStatus();
      const response = exception.getResponse();

      if (typeof response === 'object' && response !== null) {
        const responseObj = response as any;
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

    // Для неизвестных ошибок
    return {
      status: HttpStatus.INTERNAL_SERVER_ERROR,
      message: 'Internal server error',
      error:
        exception instanceof Error
          ? exception.message
          : 'Unknown error occurred',
    };
  }
}
