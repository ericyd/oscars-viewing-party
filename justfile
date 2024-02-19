express:
  node ./express/bin/www.js

up:
  docker-compose up -d

down:
  docker-compose down

psql:
  docker exec -it db psql -U postgres -d local

migrate:
  just up
  atlas migrate apply --env local

migrate-diff +args:
  atlas migrate diff {{ args }} --env local

schema-apply:
  atlas schema apply --env local

schema-inspect:
  atlas schema inspect --env local > schema.hcl

setup:
  cp oscars-pool/.dev.vars.example oscars-pool/.dev.vars
  cp .env.sample .env
  cp atlas.hcl.sample atlas.hcl
  npm ci
