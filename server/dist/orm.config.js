"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.dataSource = exports.migrationConfig = exports.databaseConfig = exports.baseConfig = void 0;
const typeorm_1 = require("typeorm");
const dotenv_1 = require("dotenv");
(0, dotenv_1.config)();
exports.baseConfig = {
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
exports.databaseConfig = {
    ...exports.baseConfig,
    host: process.env.DB_HOST || 'postgres',
};
exports.migrationConfig = {
    ...exports.baseConfig,
    host: 'postgres',
};
const isRunningMigrations = process.argv.includes('migration:generate') ||
    process.argv.includes('migration:run');
exports.dataSource = new typeorm_1.DataSource(isRunningMigrations ? exports.migrationConfig : exports.databaseConfig);
//# sourceMappingURL=orm.config.js.map