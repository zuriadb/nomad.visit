import { JwtService } from '@nestjs/jwt';
export declare class TokenService {
    private readonly jwtService;
    constructor(jwtService: JwtService);
    generateAccessToken(payload: any): string;
    decodeToken(token: string): any;
    generateRefreshToken(payload: any): string;
}
