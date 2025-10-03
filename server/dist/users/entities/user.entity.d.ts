import { BaseEntity } from 'src/common/entities/base.entity';
import { Role } from 'src/auth/roles/roles.enum';
export declare class UserEntity extends BaseEntity {
    username: string;
    email: string;
    role: Role;
    avatarUrl?: string;
    refresh_token?: string;
    passwordHash: string;
    lastLogin?: Date;
}
