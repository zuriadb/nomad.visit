import { UsersService } from '../../users/users.service';
import { JwtPayload } from '../interfaces/jwt-payload.interface';
declare const AccessTokenJwtStrategy_base: new (...args: any) => any;
export declare class AccessTokenJwtStrategy extends AccessTokenJwtStrategy_base {
    private readonly usersService;
    private readonly logger;
    constructor(usersService: UsersService);
    validate(payload: JwtPayload): Promise<import("../../users/entities/user.entity").UserEntity>;
}
export {};
