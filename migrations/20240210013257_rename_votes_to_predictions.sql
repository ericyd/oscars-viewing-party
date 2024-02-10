-- Create "predictions" table
CREATE TABLE "predictions" ("id" bigserial NOT NULL, "user_id" bigint NOT NULL, "nominee_id" bigint NOT NULL, "category_id" bigint NOT NULL, PRIMARY KEY ("id"), CONSTRAINT "category_id" FOREIGN KEY ("category_id") REFERENCES "categories" ("id") ON UPDATE NO ACTION ON DELETE CASCADE, CONSTRAINT "nominee_id" FOREIGN KEY ("nominee_id") REFERENCES "nominees" ("id") ON UPDATE NO ACTION ON DELETE CASCADE, CONSTRAINT "user_id" FOREIGN KEY ("user_id") REFERENCES "users" ("id") ON UPDATE NO ACTION ON DELETE CASCADE);
-- Create index "index_predictions_unique_user_id_category_id" to table: "predictions"
CREATE UNIQUE INDEX "index_predictions_unique_user_id_category_id" ON "predictions" ("user_id", "category_id") NULLS NOT DISTINCT;
-- Drop "votes" table
DROP TABLE "votes";
