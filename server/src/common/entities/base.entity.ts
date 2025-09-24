import { UpdateDateColumn } from "typeorm";
import { CreateDateColumn } from "typeorm";
import { PrimaryGeneratedColumn } from "typeorm";


export class BaseEntity {
  @PrimaryGeneratedColumn('uuid')
  id: string;

  @CreateDateColumn({ type: 'timestamptz' })
  createdAt: Date;

  @UpdateDateColumn({ type: 'timestamptz' })
  updatedAt: Date;
}
