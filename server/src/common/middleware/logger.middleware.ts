import { Injectable, Logger, NestMiddleware } from '@nestjs/common';
import { Request, Response, NextFunction } from 'express';

@Injectable()
export class LoggerMiddleware implements NestMiddleware {
  private readonly logger = new Logger('HTTP');

  use(req: Request, res: Response, next: NextFunction) {
    const { method, originalUrl } = req;
    const start = Date.now();

    res.on('finish', () => {
      const { statusCode } = res;

      const contentLength = res.getHeader('content-length') || 0;
      const responseTime = Date.now() - start;

      this.logger.log(
        `${method} from: ${originalUrl}, status_code: ${statusCode}, ${contentLength} - ${responseTime}ms from ip: ${req.ip}`,
      );
    });

    next();
  }
}
