import { MigrationInterface, QueryRunner } from "typeorm";

export class AddUser1757575309018 implements MigrationInterface {
    name = 'AddUser1757575309018'

    public async up(queryRunner: QueryRunner): Promise<void> {
        await queryRunner.query(`CREATE TABLE "users" ("id" uuid NOT NULL DEFAULT uuid_generate_v4(), "createdAt" TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT now(), "updatedAt" TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT now(), "username" character varying NOT NULL, "email" character varying NOT NULL, "role" character varying NOT NULL DEFAULT 'teacher', "avatarUrl" character varying, "refresh_token" character varying, "passwordHash" character varying NOT NULL, "lastLogin" TIMESTAMP, CONSTRAINT "UQ_e12875dfb3b1d92d7d7c5377e22" UNIQUE ("email"), CONSTRAINT "PK_cace4a159ff9f2512dd42373760" PRIMARY KEY ("id"))`);
        await queryRunner.query(`CREATE INDEX "IDX_e12875dfb3b1d92d7d7c5377e2" ON "users" ("email") `);
        await queryRunner.query(`CREATE TABLE "recommendation_entity" ("id" uuid NOT NULL DEFAULT uuid_generate_v4(), "placeName" character varying NOT NULL, "description" character varying NOT NULL, "reason" character varying NOT NULL, "estimatedPrice" character varying NOT NULL, "timeToVisit" character varying NOT NULL, CONSTRAINT "PK_8f06d0559e5d46c49621af18fd5" PRIMARY KEY ("id"))`);
    }

    public async down(queryRunner: QueryRunner): Promise<void> {
        await queryRunner.query(`DROP TABLE "recommendation_entity"`);
        await queryRunner.query(`DROP INDEX "public"."IDX_e12875dfb3b1d92d7d7c5377e2"`);
        await queryRunner.query(`DROP TABLE "users"`);
    }

}
