# Oscars® Viewing Party

An experiment to see if I can make a quick/easy voting app.

## Prerequisites

* [Docker](https://www.docker.com/) (and docker-compose)
* [Atlas](https://atlasgo.io/)
* [NodeJS](https://nodejs.org/en) ([asdf](https://asdf-vm.com/) recommended)

## Development

```shell
cp .env.sample .env
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

- Exec into the DB container: `docker exec -it db psql -U postgres -d local`
- Inspect schema: `atlas schema inspect --env local > schema.hcl`
- Apply schema changes: `atlas schema apply --env local`
- Generate SQL: `atlas migrate diff full_schema --env local`
- Apply "insert" migrations: `atlas migrate apply --env local --baseline 20240208014006`
- Add new migration file: `atlas migrate new` (after adding SQL, run `atlas migrate hash` to rehash)
- Drop the DB and restart: `docker-compose down -v`

---

TODO

1. write insert script for all this shit: https://abc.com/shows/oscars/news/nominations/oscar-nominations-2024-list