## Запуск проекта на Docker

### 1. Клонируем репозиторий

```bash
git clone <URL_репозитория>
cd <название_проекта>
```

### 2. Настраиваем `.env`

Создай файл `.env` в корне проекта и добавь необходимые переменные окружения, например:

```
# App
APP_PORT=3006

# JWT
JWT_SECRET='10e921e3005d9f434877e29e240aa1b7a1609ee9839b7c6c20d5b3c322c5c1c4'
JWT_EXPIRATION=15m

REFRESH_TOKEN_SECRET='10e921e3005d9f434ffff877e29e240aa1b7a1609ee9839b7c6c20d5b3c322c5c1c4'
REFRESH_TOKEN_EXPIRATION=7d

NODE_ENV=development

# Database
DB_HOST=postgres
DB_PORT=5432
DB_USER=face_user
DB_PASSWORD=face_password
DB_NAME=face_db
GEMINI_API_KEY="Тут апи ключ к ии"
```

> Убедись, что данные совпадают с конфигурацией в `docker-compose.yml`.

---

### 3. Поднимаем контейнеры

```bash
docker-compose up -d
```

* `-d` — запускает контейнеры в фоне.

> Контейнеры должны включать: приложение (`app`) и базу данных (`db`).

---

### 4. Применяем миграции TypeORM

```bash
docker compose exec app npx typeorm-ts-node-commonjs -d src/orm.config.ts migration:run
```

* `exec app` — выполняем команду внутри контейнера приложения.
* `-d src/orm.config.ts` — путь к конфигу TypeORM.
* `migration:run` — применяем все миграции к базе данных.

---

### 5. Проверяем работу приложения

Открой браузер или сделай запрос к API:

```
http://http://localhost:3006/api/docs#
```

---

### 6. Остановка контейнеров

```bash
docker-compose down
```

* Удаляет контейнеры, но оставляет данные в volumes.
