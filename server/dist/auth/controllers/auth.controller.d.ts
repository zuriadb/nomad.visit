import { AuthLoginDto } from '../dto/login.dto';
import { AuthRegisterDto } from '../dto/register.dto';
import { AuthService } from '../services/auth.service';
import { Response } from 'express';
import { IUser } from 'src/users/interfaces/user.interface';
export declare class AuthController {
    private readonly authService;
    constructor(authService: AuthService);
    login(dto: AuthLoginDto, response: Response): Promise<{
        access_token: string;
    }>;
    register(dto: AuthRegisterDto, response: Response): Promise<{
        access_token: string;
    }>;
    logout(user: IUser, response: Response): Promise<void>;
    refreshToken(user: IUser, response: Response): Promise<{
        access_token: string;
    }>;
}
