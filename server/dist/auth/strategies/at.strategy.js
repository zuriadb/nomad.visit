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
var AccessTokenJwtStrategy_1;
Object.defineProperty(exports, "__esModule", { value: true });
exports.AccessTokenJwtStrategy = void 0;
const passport_jwt_1 = require("passport-jwt");
const passport_1 = require("@nestjs/passport");
const users_service_1 = require("../../users/users.service");
const common_1 = require("@nestjs/common");
let AccessTokenJwtStrategy = AccessTokenJwtStrategy_1 = class AccessTokenJwtStrategy extends (0, passport_1.PassportStrategy)(passport_jwt_1.Strategy) {
    usersService;
    logger = new common_1.Logger(AccessTokenJwtStrategy_1.name);
    constructor(usersService) {
        super({
            jwtFromRequest: passport_jwt_1.ExtractJwt.fromAuthHeaderAsBearerToken(),
            ignoreExpiration: false,
            secretOrKey: process.env.JWT_SECRET,
        });
        this.usersService = usersService;
    }
    async validate(payload) {
        try {
            const user = await this.usersService.findById(payload.userId);
            if (!user || payload.email !== user.email) {
                this.logger.warn(`User not found for id: ${payload.userId}`);
                throw new common_1.UnauthorizedException('User not found');
            }
            this.logger.debug(`User authenticatedd: ${user.email}`);
            return user;
        }
        catch (error) {
            this.logger.error(`Authentication failed: ${error.message}`);
            throw new common_1.UnauthorizedException('Authentication failed');
        }
    }
};
exports.AccessTokenJwtStrategy = AccessTokenJwtStrategy;
exports.AccessTokenJwtStrategy = AccessTokenJwtStrategy = AccessTokenJwtStrategy_1 = __decorate([
    (0, common_1.Injectable)(),
    __metadata("design:paramtypes", [users_service_1.UsersService])
], AccessTokenJwtStrategy);
//# sourceMappingURL=at.strategy.js.map