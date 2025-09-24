import { DataSource, DataSourceOptions } from 'typeorm';
import { config } from 'dotenv';

config();

export const baseConfig: DataSourceOptions = {
  type: 'postgres',
  port: +(process.env.DB_PORT || '5432'),
  username: process.env.DB_USER,
  password: process.env.DB_PASSWORD,
  database: process.env.DB_NAME,
  entities: ['dist/**/*.entity.{ts,js}'],
  migrations: ['dist/migrations/*.js'],
  synchronize: false,
  logging: false,
};

export const databaseConfig: DataSourceOptions = {
  ...baseConfig,
  host: process.env.DB_HOST || 'postgres',
};

export const migrationConfig: DataSourceOptions = {
  ...baseConfig,
  host: 'postgres',
};

const isRunningMigrations =
  process.argv.includes('migration:generate') ||
  process.argv.includes('migration:run');

export const dataSource = new DataSource(
  isRunningMigrations ? migrationConfig : databaseConfig,
);