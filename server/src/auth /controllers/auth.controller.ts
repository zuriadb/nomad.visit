import { Body, Controller, Post, Res, UseGuards } from '@nestjs/common';
import { AuthLoginDto } from '../dto/login.dto';
import { AuthRegisterDto } from '../dto/register.dto';
import { AuthService } from '../services/auth.service';
import { ApiBearerAuth, ApiCookieAuth, ApiOperation } from '@nestjs/swagger';
import { JwtAuthGuard } from '../guards/jwt-auth.guard';
import { Response } from 'express';
import { JwtRefreshAuthGuard } from '../guards/jwt-refresh.guard';
import { User } from 'src/users/decorators/user.decorator';
import { IUser } from 'src/users/interfaces/user.interface';

@ApiBearerAuth()
@Controller('auth')
export class AuthController {
  constructor(private readonly authService: AuthService) {}
  @Post('login')
  async login(
    @Body() dto: AuthLoginDto,
    @Res({ passthrough: true }) response: Response,
  ) {
    return this.authService.login(dto, response);
  }

  @Post('register')
  async register(
    @Body() dto: AuthRegisterDto,
    @Res({ passthrough: true }) response: Response,
  ) {
    return this.authService.register(dto, response);
  }

  @UseGuards(JwtAuthGuard)
  @Post('logout')
  async logout(
    @User() user: IUser,
    @Res({ passthrough: true }) response: Response,
  ) {
    response.clearCookie('Refresh', {
      httpOnly: true,
      secure: process.env.NODE_ENV === 'production',
      path: '/api/v1/auth',
    });
    return this.authService.logout(user.id, response);
  }

  @UseGuards(JwtRefreshAuthGuard)
  @Post('refresh-token')
  @ApiOperation({ summary: 'Refresh access token using refresh token' })
  @ApiCookieAuth()
  async refreshToken(
    @User() user: IUser,
    @Res({ passthrough: true }) response: Response,
  ) {
    return this.authService.refreshToken(user.id, response);
  }
}
