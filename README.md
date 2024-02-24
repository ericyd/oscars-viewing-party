# Oscars® Viewing Party

An experiment to see if I can make a quick/easy app to store Oscars predictions. (Spoiler alert, I succeeded: https://oscars-viewing-party.onrender.com/). The express code is in the `/express` directory.

This app is all about "good enough". It is not secure and that's fine. The whole point is just to make predictions for a silly awards ceremony and compare with your friends.

_Update 2024-02-19_: I succeeded in writing a Cloudflare Workers-compatible API, found in the `/oscars-pool` directory. The Vue frontend for this worker is in `/oscars-pool-frontend`

Hosted versions:

- Best: Vue frontend with Cloudflare workers backend: https://oscars-pool.pages.dev
- API: Cloudflare worker: https://oscars-pool.eric-13c.workers.dev/
- Express server: https://oscars-viewing-party.onrender.com/


```shell
npm create cloudflare -- oscars-pool-frontend
```

## Prerequisites

- [Docker](https://www.docker.com/) (and docker-compose)
- [Atlas](https://atlasgo.io/)
- [NodeJS](https://nodejs.org/en) ([asdf](https://asdf-vm.com/) recommended)
- [Just](https://github.com/casey/just/blob/master/README.md#packages) (optional, but recommended)

## Development

With `just`

```shell
just setup
just up
just migrate
just worker
just frontend # start the Vue frontend in a separate terminal tab
```

Without `just`

```shell
cp .env.sample .env
cp atlas.hcl.sample atlas.hcl
# start DB
docker-compose up -d
# apply DB migration
# If you don't want to use Atlas, just run the SQL files from the migrations directory
atlas migrate apply --env local
# install node dependencies
npm ci
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
