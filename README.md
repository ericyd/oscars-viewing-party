# Oscars® Viewing Party

## Prerequisites

- [NodeJS](https://nodejs.org/en) ([asdf](https://asdf-vm.com/) recommended)
- [Docker](https://www.docker.com/) (and docker-compose)

## Development

```shell
git clone https://github.com/ericyd/oscars-viewing-party.git
cd oscars-viewing-party
git checkout debugging
cp .env.sample .env
docker-compose up -d
docker exec db psql -U postgres -d local -f "/migrations/db_dump.sql"
npm ci
npm run dev
npm run client:dev
```
