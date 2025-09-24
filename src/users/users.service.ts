import { InjectRepository } from '@nestjs/typeorm';
import { UserEntity } from './entities/user.entity';
import { Repository } from 'typeorm';

export class UsersService {
  constructor(
    @InjectRepository(UserEntity)
    private readonly repo: Repository<UserEntity>,
  ) {}

  async findById(id: string): Promise<UserEntity | null> {
    return this.repo.findOne({
      where: { id },
    });
  }

  async findAll(): Promise<UserEntity[]> {
    return this.repo.find();
  }

  async findByEmail(email: string): Promise<UserEntity | null> {
    return this.repo.findOne({ where: { email } });
  }

  async create(userData: Partial<UserEntity>): Promise<UserEntity> {
    const user = this.repo.create(userData);
    return this.repo.save(user);
  }

  async existsByEmail(email: string): Promise<boolean> {
    return (await this.repo.count({ where: { email } })) > 0;
  }

  async update(
    id: string,
    updateData: Partial<UserEntity>,
  ): Promise<UserEntity | null > {
    await this.repo.update(id, updateData);
    return this.findById(id);
  }

  async delete(id: string): Promise<void> {
    await this.repo.delete(id);
  }

  async findByEmailWithPassword(email: string): Promise<UserEntity | null> {
    return this.repo.findOne({
      where: { email },
      select: ['id', 'email', 'username', 'passwordHash', 'role'],
    });
  }

  async findByIdWithRefreshToken(id: string): Promise<UserEntity | null> {
    return this.repo.findOne({
      where: { id },
      select: ['id', 'email', 'username', 'refresh_token'],
    });
  }
}
