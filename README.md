# Oscars® Viewing Party

An experiment to see if I can make a quick/easy voting app.

## Prerequisites

* [Docker](https://www.docker.com/) (and docker-compose)
* [Atlas](https://atlasgo.io/)

## Development

```shell
# start DB
docker-compose up -d
# apply DB migration
# If you don't want to use Atlas, just run the SQL file from the migrations directory
atlas schema apply --env local
```

## Database

Use Atlas to manage the DB.

If you don't want to use Atlas, just exec into the DB container and run SQL commands:

```shell
docker exec -it db psql -U postgres -d local
```

### Inspect schema

```
atlas schema inspect --env local > schema.hcl
```

### Apply schema changes

```
atlas schema apply --env local
```

### Generate SQL

```
atlas migrate diff full_schema --env local
```
