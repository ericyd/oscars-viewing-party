import { dbQuery } from '../db.js';

export async function getRoom({ params, url }, env, ctx) {
  const sql = `
    with winners as (
      select
        winners.category_id,
        winners.winning_nominee_id
      from categories
      left join (
        select id as winning_nominee_id, category_id
        from nominees
        where nominees.winner = true
      ) as winners on winners.category_id = categories.id
    )

    select
      users.id,
      users.name,
      count(predictions.*) as total_predictions,
      count(*) filter (
        where exists (select * from winners where winning_nominee_id = predictions.nominee_id)
      ) as correct,
      count(*) filter (
        where predictions.category_id is not null
        and not exists (select * from winners where category_id = predictions.category_id)
      ) as undecided,
      count(*) filter (
        where exists (select * from winners where category_id = predictions.category_id)
        and not exists (select * from winners where winning_nominee_id = predictions.nominee_id)
      ) as wrong

      from users
      left join predictions on predictions.user_id = users.id
      where room_id = $1
      group by users.id, users.name;
  `;

  const { rows: people } = await dbQuery(env, ctx, sql, [params.roomId]);
  return Response.json({ people }, { headers: { 'Access-Control-Allow-Origin': '*' } });
}
