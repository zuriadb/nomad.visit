import { TokenService } from './token.service';
import { PasswordService } from './password.service';
import { AuthRegisterDto } from '../dto/register.dto';
import { AuthLoginDto } from '../dto/login.dto';
import { Response } from 'express';
import { UsersService } from 'src/users/users.service';
export declare class AuthService {
    private readonly userService;
    private readonly tokenService;
    private readonly passwordService;
    constructor(userService: UsersService, tokenService: TokenService, passwordService: PasswordService);
    login(dto: AuthLoginDto, response: Response): Promise<{
        access_token: string;
    }>;
    register(dto: AuthRegisterDto, response: Response): Promise<{
        access_token: string;
    }>;
    logout(userId: string, response: Response): Promise<void>;
    refreshToken(userId: string, response: Response): Promise<{
        access_token: string;
    }>;
    private setRefreshTokenCookie;
    private generateTokenPairs;
}
