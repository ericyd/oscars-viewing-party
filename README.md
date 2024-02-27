# Oscars® Viewing Party

## Prerequisites

- [NodeJS](https://nodejs.org/en) ([asdf](https://asdf-vm.com/) recommended)
- [Docker](https://www.docker.com/) (and docker-compose)

## Development

```shell
cp .env.sample .env
docker-compose up -d
docker exec db psql -U postgres -d local -f "/migrations/db_dump.sql"
npm ci
npm run dev
npm run client:dev
```

## Database

Use Atlas to manage the DB.

- Exec into the DB container: `just psql`
- Inspect schema: `just schema-inspect`
- Apply schema changes: `just schema-apply`
- Generate SQL: `just migrate-diff`
- Apply "insert" migrations: `atlas migrate apply --env local --baseline 20240208024216`
- Add new migration file: `atlas migrate new` (after adding SQL, run `atlas migrate hash` to rehash)
- Drop the DB and restart: `just down`
