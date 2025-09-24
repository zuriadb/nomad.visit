import { ApiProperty } from '@nestjs/swagger';
import {
  IsEmail,
  IsEnum,
  IsNotEmpty,
  IsStrongPassword,
  MinLength,
} from 'class-validator';
import { Role } from '../roles/roles.enum';

export class AuthRegisterDto {
  @ApiProperty()
  @IsEmail()
  @IsNotEmpty()
  email: string;

  @ApiProperty()
  @IsNotEmpty()
  @MinLength(6)
  username: string;

  @ApiProperty()
  @IsNotEmpty()
  @MinLength(8)
  @IsStrongPassword()
  password: string;

  @ApiProperty({ enum: ['user', 'admin'], required: true })
  @IsEnum(['user', 'admin'])
  @IsNotEmpty()
  role: Role;
}
