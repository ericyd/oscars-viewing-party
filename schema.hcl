schema "public" {
  comment = "standard public schema"
}

table "categories" {
  schema = schema.public
  column "id" {
    null = false
    // https://atlasgo.io/guides/postgres/serial-columns
    // Seems weird that Atlas doesn't support standard auto-incrementing integers in postgres, but whatevs, this works.
    type = serial
  }
  column "category" {
    null = false
    type = text
  }
  // things like "Sound", "Writing", "Acting"
  column "meta_category" {
    null = true
    type = text
  }
  primary_key {
    columns = [column.id]
  }
}

table "nominees" {
  schema = schema.public
  column "id" {
    null = false
    type = serial
  }
  // the human name, e.g. "Eric"
  column "nominee" {
    null = false
    type = text
  }
  // typically the film, but sometimes the song, e.g. "Transformers"
  column "artwork" {
    null = false
    type = text
  }
  column "category_id" {
    null = false
    type = int
  }
  // normally wouldn't codify a foreign key but doing so to try to use PostgREST
  foreign_key "category_id" {
    columns     = [column.category_id]
    ref_columns = [table.categories.column.id]
    on_update   = NO_ACTION
    on_delete   = CASCADE
  }
  column "winner" {
    null = false
    type = boolean
    default = false
  }
  column "year" {
    null = false
    type = int
    default = 2024
  }
  index "index_unique_winner_year_category_id" {
    unique         = true
    columns        = [column.winner, column.year, column.category_id]
    nulls_distinct = false
    where   = "(winner = true)"
  }
  primary_key {
    columns = [column.id]
  }
}

table "users" {
  schema = schema.public
  column "id" {
    null = false
    type = serial
  }
  column "name" {
    null = false
    type = text
  }
  // this can be set by the user to whatever they want.
  // It is never displayed, it is kind of like a password, but obviously not secure.
  column "username" {
    null = false
    type = text
  }
  column "room_id" {
    null = false
    type = text
  }
  column "admin" {
    null = false
    type = boolean
    default = false
  }
  column "year" {
    null = false
    type = int
    default = 2024
  }
  index "index_unique_room_id_name" {
    unique         = true
    columns        = [column.name, column.room_id]
    nulls_distinct = false
  }
  index "index_unique_room_id_username" {
    unique         = true
    columns        = [column.username, column.room_id]
    nulls_distinct = false
  }
  primary_key {
    columns = [column.id]
  }
}

table "predictions" {
  schema = schema.public
  column "id" {
    null = false
    type = serial
  }
  
  column "user_id" {
    null = false
    type = int
  }
  foreign_key "user_id" {
    columns     = [column.user_id]
    ref_columns = [table.users.column.id]
    on_update   = NO_ACTION
    on_delete   = CASCADE
  }
  
  column "nominee_id" {
    null = false
    type = int
  }
  foreign_key "nominee_id" {
    columns     = [column.nominee_id]
    ref_columns = [table.nominees.column.id]
    on_update   = NO_ACTION
    on_delete   = CASCADE
  }

  column "category_id" {
    null = false
    type = int
  }
  foreign_key "category_id" {
    columns     = [column.category_id]
    ref_columns = [table.categories.column.id]
    on_update   = NO_ACTION
    on_delete   = CASCADE
  }

  index "index_unique_user_id_category_id" {
    unique         = true
    columns        = [column.user_id, column.category_id]
    nulls_distinct = false
  }
  primary_key {
    columns = [column.id]
  }
}
