import { UserEntity } from './entities/user.entity';
import { Repository } from 'typeorm';
export declare class UsersService {
    private readonly repo;
    constructor(repo: Repository<UserEntity>);
    findById(id: string): Promise<UserEntity | null>;
    findAll(): Promise<UserEntity[]>;
    findByEmail(email: string): Promise<UserEntity | null>;
    create(userData: Partial<UserEntity>): Promise<UserEntity>;
    existsByEmail(email: string): Promise<boolean>;
    update(id: string, updateData: Partial<UserEntity>): Promise<UserEntity | null>;
    delete(id: string): Promise<void>;
    findByEmailWithPassword(email: string): Promise<UserEntity | null>;
    findByIdWithRefreshToken(id: string): Promise<UserEntity | null>;
}
