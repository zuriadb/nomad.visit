import { Column, Entity, Index } from 'typeorm';
import { BaseEntity } from 'src/common/entities/base.entity';
import { Role } from 'src/auth /roles/roles.enum';


@Entity({ name: 'users' })
export class UserEntity extends BaseEntity {
  @Column()
  username: string;

  @Index()
  @Column({ unique: true })
  email: string;

  @Column({ enum: Role, default: 'teacher' })
  role: Role;

  @Column({ select: false, nullable: true, default: null })
  avatarUrl?: string;

  @Column({ select: false, nullable: true, default: null })
  refresh_token?: string;

  @Column({ select: false })
  passwordHash: string;

  @Column({ type: 'timestamp', nullable: true })
  lastLogin?: Date;
}
