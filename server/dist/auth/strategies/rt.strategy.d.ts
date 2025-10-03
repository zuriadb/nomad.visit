import { Request } from 'express';
import { UsersService } from 'src/users/users.service';
declare const RefreshTokenJwtStrategy_base: new (...args: any) => any;
export declare class RefreshTokenJwtStrategy extends RefreshTokenJwtStrategy_base {
    private readonly usersService;
    constructor(usersService: UsersService);
    validate(request: Request, payload: any): Promise<import("../../users/entities/user.entity").UserEntity>;
}
export {};
