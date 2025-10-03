import { UsersService } from './users.service';
export declare class UsersController {
    private readonly usersService;
    constructor(usersService: UsersService);
    findAll(): Promise<import("./entities/user.entity").UserEntity[]>;
    findById(id: string): Promise<import("./entities/user.entity").UserEntity | null>;
}
