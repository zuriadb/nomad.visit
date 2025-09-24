import { Module } from '@nestjs/common';
import { AuthController } from './controllers/auth.controller';
import { AuthService } from './services/auth.service';
import { TokenService } from './services/token.service';
import { PasswordService } from './services/password.service';
import { JwtModule } from '@nestjs/jwt';
import { PassportModule } from '@nestjs/passport';
import { AccessTokenJwtStrategy } from './strategies/at.strategy';
import { RolesGuard } from './roles/roles.guard';
import { RefreshTokenJwtStrategy } from './strategies/rt.strategy';
import { UsersModule } from 'src/users/users.module';

@Module({
  imports: [
    UsersModule,
    JwtModule.register({
      secret: process.env.JWT_SECRET,
      signOptions: { expiresIn: process.env.JWT_EXPIRATION },
    }),
    PassportModule.register({
      defaultStrategy: 'jwt',
      useClass: AccessTokenJwtStrategy,
    }),
  ],
  providers: [
    AuthService,
    TokenService,
    PasswordService,
    RefreshTokenJwtStrategy,
    AccessTokenJwtStrategy,
    RolesGuard,
  ],
  controllers: [AuthController],
  exports: [RolesGuard],
})
export class AuthModule {}
