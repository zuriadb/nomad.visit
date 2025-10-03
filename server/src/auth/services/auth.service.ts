import {
  ConflictException,
  Injectable,
  NotFoundException,
  UnauthorizedException,
} from '@nestjs/common';
import { TokenService } from './token.service';
import { PasswordService } from './password.service';
import { AuthRegisterDto } from '../dto/register.dto';
import { AuthLoginDto } from '../dto/login.dto';
import { Response } from 'express';
import { UsersService } from 'src/users/users.service';
import { Role } from '../roles/roles.enum';
import { IUser } from 'src/users/interfaces/user.interface';
import { UserEntity } from 'src/users/entities/user.entity';


@Injectable()
export class AuthService {
  constructor(
    private readonly userService: UsersService,
    private readonly tokenService: TokenService,
    private readonly passwordService: PasswordService,
  ) {}

  async login(dto: AuthLoginDto, response: Response) {
    const user = await this.userService.findByEmailWithPassword(dto.email);
    if (!user) {
      throw new NotFoundException('User with this email does not exist');
    }

    const isPasswordValid = await this.passwordService.comparePasswords(
      dto.password,
      user.passwordHash,
    );

    if (!isPasswordValid) {
      throw new UnauthorizedException('Invalid password');
    }

    const { accessToken, refreshToken } = this.generateTokenPairs(user);

    await this.userService.update(user.id, {
      lastLogin: new Date(),
      refresh_token: refreshToken,
    });

    this.setRefreshTokenCookie(response, refreshToken);

    return { access_token: accessToken };
  }

  async register(dto: AuthRegisterDto, response: Response) {
    if (await this.userService.existsByEmail(dto.email)) {
      throw new ConflictException('User with this email already exists');
    }

    const hashedPassword = await this.passwordService.hashPassword(
      dto.password,
    );
    const createdUser = await this.userService.create({
      email: dto.email,
      passwordHash: hashedPassword,
      username: dto.username,
      role: dto.role || Role.User,
    });

    if (!createdUser) {
      throw new ConflictException('Something went wrong while creating user');
    }

    const { accessToken, refreshToken } = this.generateTokenPairs(createdUser);

    this.setRefreshTokenCookie(response, refreshToken);

    return { access_token: accessToken };
  }

  async logout(userId: string, response: Response) {
    const user = await this.userService.findById(userId);

    if (!user) {
      throw new NotFoundException('User not found');
    }

    response.clearCookie('Refresh');

    await this.userService.update(userId, { refresh_token: undefined });
    return;
  }

  async refreshToken(userId: string, response: Response) {
    const user = await this.userService.findByIdWithRefreshToken(userId);
    if (!user) {
      throw new UnauthorizedException('Invalid token or user not found');
    }

    const { accessToken, refreshToken } = this.generateTokenPairs(user);

    await this.userService.update(user.id, {
      refresh_token: await this.passwordService.hashPassword(refreshToken),
    });

    this.setRefreshTokenCookie(response, refreshToken);

    return { access_token: accessToken };
  }

  private setRefreshTokenCookie(response: Response, token: string) {
    response.cookie('Refresh', token, {
      httpOnly: true,
      secure: process.env.NODE_ENV === 'production',
      sameSite: 'strict',
      maxAge: 7 * 24 * 60 * 60 * 1000,
      path: '/api/v1/auth',
    });
  }

  private generateTokenPairs(user: Partial<IUser | UserEntity>): {
    accessToken: string;
    refreshToken: string;
  } {
    return {
      accessToken: this.tokenService.generateAccessToken({
        userId: user.id,
        email: user.email,
        role: user.role,
      }),
      refreshToken: this.tokenService.generateRefreshToken({
        userId: user.id,
      }),
    };
  }
}
