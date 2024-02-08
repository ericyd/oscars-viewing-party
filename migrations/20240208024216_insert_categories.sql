with best_actor as (
  insert into categories (name, meta_category) values ('Actor in a Leading Role', 'Acting')
  returning id
)

insert into nominees (human, piece, category_id, year) values 
  ('test actor 4', 'film 1', (select id from best_actor), 2024),
  ('test actor 5', 'film 2', (select id from best_actor), 2024),
  ('test actor 6', 'film 3', (select id from best_actor), 2024)
;
