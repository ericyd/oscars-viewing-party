# Oscars® Viewing Party

A quick/easy app to store Oscars predictions.

This app is all about "good enough". It is not secure and that's fine. The whole point is just to make predictions for a silly awards ceremony and compare with your friends.

Hosted at https://oscars-pool.pages.dev

## Prerequisites

- [NodeJS](https://nodejs.org/en) ([asdf](https://asdf-vm.com/) recommended)
- [Docker](https://www.docker.com/) (and docker-compose)
- [Atlas](https://atlasgo.io/) (optional)
- [Just](https://github.com/casey/just/blob/master/README.md#packages) (optional)

## Development

With `just`, `atlas`, `docker` and `node`

```shell
just setup migrate worker
# start the Vue frontend in a separate terminal tab
just frontend
```

With only `atlas`, `docker` and `node`

```shell
cp .env.sample .env
cp .dev.vars.example .dev.vars
cp atlas.hcl.sample atlas.hcl
# start DB
docker-compose up -d
# apply DB migration
# If you don't want to use Atlas, just run the SQL files from the migrations directory
atlas migrate apply --env local
# install node dependencies
npm ci
# Start the Cloudflare worker backend
npm run dev
# Start the Vite server for the Vue frontend
npm run client:dev
```

With `docker` and `node`

```shell
cp .env.sample .env
cp .dev.vars.sample .dev.vars
docker-compose up -d
# run migrations manually
for filename in migrations/*.sql; do docker exec db psql -U postgres -d local -f "/$filename"; done
# or if that loop syntax doesn't work:
# docker exec db psql -U postgres -d local -f migrations/20240208014006_full_schema.sql
# docker exec db psql -U postgres -d local -f migrations/20240208024216_insert_categories.sql
# docker exec db psql -U postgres -d local -f migrations/20240211233622_drop_rooms.sql
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
- Dump a remote database: `docker exec -it db pg_dump -d dbname -h host -p port -U user -f migrations/prod.sql`
   - this works because `/migrations` is already bound to the container

<!-- 
Notes to self:

1. Create a new cloudflare workers project:

```shell
npm create cloudflare -- oscars-pool-frontend
```

2. Restore production database: production dump file stored in google drive, then run

```
docker exec -it db psql -U postgres -d local restore.sql
```
 -->


Current goal 2025-01-22: re-write this stupid app so that it only requires one thing: either a Pages project with "Pages Functions" (i.e.Workers) which are located in `/functions`, or a single Worker which renders HTML on the server.

Unfortunately both are absurdly challenging with Workers. Trying to use common JS templating libraries in Workers causes all sorts of problems. I don't know why, the runtime just hates the way they are written. And ditto if you try to include common Node packages in your Pages functions. When your root project is a Pages project, it doesn't seem like there is a way to enable node compatibility node, which means a ton of libraries are broken because they don't use the newer `node:package` namespace for imports.

It's pretty annoying actually, and I'm tempted to just leave it alone since it "works". It's just a bad system IMO because it's goddamn simple as hell and yet somehow it's broken.