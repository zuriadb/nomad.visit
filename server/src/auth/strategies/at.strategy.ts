import { Strategy, ExtractJwt } from 'passport-jwt';
import { PassportStrategy } from '@nestjs/passport';
import { UsersService } from '../../users/users.service';
import { Injectable, Logger, UnauthorizedException } from '@nestjs/common';
import { JwtPayload } from '../interfaces/jwt-payload.interface';

@Injectable()
export class AccessTokenJwtStrategy extends PassportStrategy(Strategy) {
  private readonly logger = new Logger(AccessTokenJwtStrategy.name);
  constructor(private readonly usersService: UsersService) {
    super({
      jwtFromRequest: ExtractJwt.fromAuthHeaderAsBearerToken(),
      ignoreExpiration: false,
      secretOrKey: process.env.JWT_SECRET,
    });
  }

  async validate(payload: JwtPayload) {
    try {
      const user = await this.usersService.findById(payload.userId);

      if (!user || payload.email !== user.email) {
        this.logger.warn(`User not found for id: ${payload.userId}`);
        throw new UnauthorizedException('User not found');
      }

      this.logger.debug(`User authenticatedd: ${user.email}`);

      return user;
    } catch (error) {
      this.logger.error(`Authentication failed: ${error.message}`);
      throw new UnauthorizedException('Authentication failed');
    }
  }
}
