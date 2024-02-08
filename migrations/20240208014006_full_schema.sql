-- Create "categories" table
CREATE TABLE "categories" ("id" bigserial NOT NULL, "name" text NOT NULL, PRIMARY KEY ("id"));
-- Create "nominees" table
CREATE TABLE "nominees" ("id" bigserial NOT NULL, "name" text NOT NULL, "category_id" bigint NOT NULL, "winner" boolean NOT NULL DEFAULT false, "year" integer NOT NULL DEFAULT 2024, PRIMARY KEY ("id"), CONSTRAINT "category_id" FOREIGN KEY ("category_id") REFERENCES "categories" ("id") ON UPDATE NO ACTION ON DELETE CASCADE);
-- Create index "index_unique_winner_year_category_id" to table: "nominees"
CREATE UNIQUE INDEX "index_unique_winner_year_category_id" ON "nominees" ("winner", "year", "category_id") NULLS NOT DISTINCT;
-- Create "rooms" table
CREATE TABLE "rooms" ("id" bigserial NOT NULL, PRIMARY KEY ("id"));
-- Create "users" table
CREATE TABLE "users" ("id" bigserial NOT NULL, "name" text NOT NULL, "username" text NOT NULL, "room_id" bigint NOT NULL, "admin" boolean NOT NULL DEFAULT false, "year" integer NOT NULL DEFAULT 2024, PRIMARY KEY ("id"), CONSTRAINT "room_id" FOREIGN KEY ("room_id") REFERENCES "rooms" ("id") ON UPDATE NO ACTION ON DELETE CASCADE);
-- Create index "index_unique_room_id_name" to table: "users"
CREATE UNIQUE INDEX "index_unique_room_id_name" ON "users" ("name", "room_id") NULLS NOT DISTINCT;
-- Create "votes" table
CREATE TABLE "votes" ("id" bigserial NOT NULL, "user_id" bigint NOT NULL, "nominee_id" bigint NOT NULL, "category_id" bigint NOT NULL, PRIMARY KEY ("id"), CONSTRAINT "category_id" FOREIGN KEY ("category_id") REFERENCES "categories" ("id") ON UPDATE NO ACTION ON DELETE CASCADE, CONSTRAINT "nominee_id" FOREIGN KEY ("nominee_id") REFERENCES "nominees" ("id") ON UPDATE NO ACTION ON DELETE CASCADE, CONSTRAINT "user_id" FOREIGN KEY ("user_id") REFERENCES "users" ("id") ON UPDATE NO ACTION ON DELETE CASCADE);
-- Create index "index_unique_user_id_category_id" to table: "votes"
CREATE UNIQUE INDEX "index_unique_user_id_category_id" ON "votes" ("user_id", "category_id") NULLS NOT DISTINCT;
