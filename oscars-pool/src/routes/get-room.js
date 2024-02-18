import { dbQuery } from '../db.js';

export async function getRoom({ params, query }, env) {
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

  const { rows: people } = await dbQuery(env, sql, [params.roomId]);
  // const errors = {
  //   unique_conflict: 'Looks like that name or username is already taken, please try again',
  //   updating_after_decided: "Looks like you might be trying to cheat, and submit predictions after a decision has already been made! Don't worry, you other predictions were saved."
  // }
  return Response.json({ people, params, query });
}