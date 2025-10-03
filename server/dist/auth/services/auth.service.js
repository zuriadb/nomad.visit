"use strict";
var __decorate = (this && this.__decorate) || function (decorators, target, key, desc) {
    var c = arguments.length, r = c < 3 ? target : desc === null ? desc = Object.getOwnPropertyDescriptor(target, key) : desc, d;
    if (typeof Reflect === "object" && typeof Reflect.decorate === "function") r = Reflect.decorate(decorators, target, key, desc);
    else for (var i = decorators.length - 1; i >= 0; i--) if (d = decorators[i]) r = (c < 3 ? d(r) : c > 3 ? d(target, key, r) : d(target, key)) || r;
    return c > 3 && r && Object.defineProperty(target, key, r), r;
};
var __metadata = (this && this.__metadata) || function (k, v) {
    if (typeof Reflect === "object" && typeof Reflect.metadata === "function") return Reflect.metadata(k, v);
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.AuthService = void 0;
const common_1 = require("@nestjs/common");
const token_service_1 = require("./token.service");
const password_service_1 = require("./password.service");
const users_service_1 = require("../../users/users.service");
const roles_enum_1 = require("../roles/roles.enum");
let AuthService = class AuthService {
    userService;
    tokenService;
    passwordService;
    constructor(userService, tokenService, passwordService) {
        this.userService = userService;
        this.tokenService = tokenService;
        this.passwordService = passwordService;
    }
    async login(dto, response) {
        const user = await this.userService.findByEmailWithPassword(dto.email);
        if (!user) {
            throw new common_1.NotFoundException('User with this email does not exist');
        }
        const isPasswordValid = await this.passwordService.comparePasswords(dto.password, user.passwordHash);
        if (!isPasswordValid) {
            throw new common_1.UnauthorizedException('Invalid password');
        }
        const { accessToken, refreshToken } = this.generateTokenPairs(user);
        await this.userService.update(user.id, {
            lastLogin: new Date(),
            refresh_token: refreshToken,
        });
        this.setRefreshTokenCookie(response, refreshToken);
        return { access_token: accessToken };
    }
    async register(dto, response) {
        if (await this.userService.existsByEmail(dto.email)) {
            throw new common_1.ConflictException('User with this email already exists');
        }
        const hashedPassword = await this.passwordService.hashPassword(dto.password);
        const createdUser = await this.userService.create({
            email: dto.email,
            passwordHash: hashedPassword,
            username: dto.username,
            role: dto.role || roles_enum_1.Role.User,
        });
        if (!createdUser) {
            throw new common_1.ConflictException('Something went wrong while creating user');
        }
        const { accessToken, refreshToken } = this.generateTokenPairs(createdUser);
        this.setRefreshTokenCookie(response, refreshToken);
        return { access_token: accessToken };
    }
    async logout(userId, response) {
        const user = await this.userService.findById(userId);
        if (!user) {
            throw new common_1.NotFoundException('User not found');
        }
        response.clearCookie('Refresh');
        await this.userService.update(userId, { refresh_token: undefined });
        return;
    }
    async refreshToken(userId, response) {
        const user = await this.userService.findByIdWithRefreshToken(userId);
        if (!user) {
            throw new common_1.UnauthorizedException('Invalid token or user not found');
        }
        const { accessToken, refreshToken } = this.generateTokenPairs(user);
        await this.userService.update(user.id, {
            refresh_token: await this.passwordService.hashPassword(refreshToken),
        });
        this.setRefreshTokenCookie(response, refreshToken);
        return { access_token: accessToken };
    }
    setRefreshTokenCookie(response, token) {
        response.cookie('Refresh', token, {
            httpOnly: true,
            secure: process.env.NODE_ENV === 'production',
            sameSite: 'strict',
            maxAge: 7 * 24 * 60 * 60 * 1000,
            path: '/api/v1/auth',
        });
    }
    generateTokenPairs(user) {
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
};
exports.AuthService = AuthService;
exports.AuthService = AuthService = __decorate([
    (0, common_1.Injectable)(),
    __metadata("design:paramtypes", [users_service_1.UsersService,
        token_service_1.TokenService,
        password_service_1.PasswordService])
], AuthService);
//# sourceMappingURL=auth.service.js.map