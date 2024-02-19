import { dbQuery } from '../db.js';

export async function getUserPredictions({ params }, env, ctx) {
  try {
    const sql = `
      select
        *,
        nominees.id as nominee_id,
        predictions.id as prediction_id,
        predictions.nominee_id as prediction_nominee_id
      from nominees
      join categories on categories.id = nominees.category_id
      left join (
        select id as winning_nominee_id, category_id
        from nominees
        where nominees.winner = true
      ) as winners on winners.category_id = categories.id
      left join predictions on (
        predictions.nominee_id = nominees.id
        and (
          predictions.user_id = $1
          or predictions.user_id is null
        )
      )
    `;
    const { rows: predictions } = await dbQuery(env, ctx, sql, [params.userId]);
    return Response.json({ predictions })
  } catch (e) {
    return Response.json(
      {
        code: 'unknown',
        message: e.message,
      },
      { status: 500 },
    );
  }
}
