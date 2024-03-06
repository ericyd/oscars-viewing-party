express:
  node ./express/bin/www.js

worker:
  npm run dev

frontend: 
  npm run client:dev

up:
  docker-compose up -d

down:
  docker-compose down

psql:
  docker exec -it db psql -U postgres -d local

migrate: up
  atlas migrate apply --env local

migrate-diff +args:
  atlas migrate diff {{ args }} --env local

schema-apply:
  atlas schema apply --env local

schema-inspect:
  atlas schema inspect --env local > schema.hcl

setup:
  cp .dev.vars.sample .dev.vars
  cp .env.sample .env
  cp atlas.hcl.sample atlas.hcl
  npm ci
