schema "public" {
  comment = "standard public schema"
}

table "categories" {
  schema = schema.public
  column "id" {
    null = false
    # https://atlasgo.io/guides/postgres/serial-columns
    # Seems weird that Atlas doesn't support standard auto-incrementing integers in postgres, but whatevs, this works.
    type = bigserial
  }
  column "name" {
    null = false
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
    type = bigserial
  }
  column "name" {
    null = false
    type = text
  }
  column "category_id" {
    null = false
    type = bigint
  }
  # normally wouldn't codify a foreign key but doing so to try to use PostgREST
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
  }
  primary_key {
    columns = [column.id]
  }
}

table "rooms" {
  schema = schema.public
  column "id" {
    null = false
    type = bigserial
  }
  primary_key {
    columns = [column.id]
  }
}

table "users" {
  schema = schema.public
  column "id" {
    null = false
    type = bigserial
  }
  column "name" {
    null = false
    type = text
  }
  # this can be set by the user to whatever they want.
  # It is never displayed, it is kind of like a password, but obviously not secure.
  column "username" {
    null = false
    type = text
  }
  column "room_id" {
    null = false
    type = bigint
  }
  foreign_key "room_id" {
    columns     = [column.room_id]
    ref_columns = [table.rooms.column.id]
    on_update   = NO_ACTION
    on_delete   = CASCADE
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
  primary_key {
    columns = [column.id]
  }
}

table "votes" {
  schema = schema.public
  column "id" {
    null = false
    type = bigserial
  }
  
  column "user_id" {
    null = false
    type = bigint
  }
  foreign_key "user_id" {
    columns     = [column.user_id]
    ref_columns = [table.users.column.id]
    on_update   = NO_ACTION
    on_delete   = CASCADE
  }
  
  column "nominee_id" {
    null = false
    type = bigint
  }
  foreign_key "nominee_id" {
    columns     = [column.nominee_id]
    ref_columns = [table.nominees.column.id]
    on_update   = NO_ACTION
    on_delete   = CASCADE
  }

  column "category_id" {
    null = false
    type = bigint
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
