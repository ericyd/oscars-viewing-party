start-express:
  node ./bin/www.js

up:
  docker-compose up -d

down:
  docker-compose down

psql:
  docker exec -it db psql -U postgres -d local

migrate:
  atlas migrate apply --env local

migrate-diff +args:
  atlas migrate diff {{ args }} --env local

schema-apply:
  atlas schema apply --env local

schema-inspect:
  atlas schema inspect --env local > schema.hcl
