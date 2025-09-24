import {
  Injectable,
  NestInterceptor,
  Logger,
  ExecutionContext,
  CallHandler,
  OnModuleInit,
} from '@nestjs/common';
import { Observable, map } from 'rxjs';
import { ApiResponse } from '../interfaces/api-response.interface';
import { ConfigService } from '@nestjs/config';

@Injectable()
export class ResponseInterceptor<T>
  implements NestInterceptor<T, ApiResponse<T>>, OnModuleInit
{
  private readonly logger = new Logger(ResponseInterceptor.name);
  private readonly isDevelopment: boolean;

  constructor(private readonly configService: ConfigService) {
    this.isDevelopment = this.configService.get('NODE_ENV') === 'development';
  }

  onModuleInit() {
    if (this.isDevelopment) {
      this.logger.warn('ResponseInterceptor initialized in development mode');
    }
    this.logger.warn('ResponseInterceptor initialized');
  }

  intercept(
    context: ExecutionContext,
    next: CallHandler,
  ): Observable<ApiResponse<T>> {
    const request = context.switchToHttp().getRequest();
    const response = context.switchToHttp().getResponse();
    const { url } = request;

    return next.handle().pipe(
      map((data) => {
        const statusCode = response.statusCode;
        const apiResponse: ApiResponse<T> = {
          success: true,
          statusCode,
          message: 'Request processed successfully',
          data,
          timestamp: new Date().toISOString(),
          path: url,
        };

        return apiResponse;
      }),
    );
  }
}
