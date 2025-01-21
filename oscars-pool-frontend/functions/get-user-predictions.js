import { dbQuery } from '../db.js';
import { groupNominees } from '../util/group-nominees.js';

// getUserPredictions
export async function getUserPredictions({ params }) {
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
    const { rows: predictions } = await dbQuery(sql, [params.userId]);
    const {
      rows: [user],
    } = await dbQuery(`select * from users where id = $1`, [params.userId]);
    return Response.json({ predictions: groupNominees(predictions), user }, { headers: { 'Access-Control-Allow-Origin': '*' } });
  } catch (e) {
    return Response.json(
      {
        code: 'unknown',
        message: e.message,
      },
      { status: 500, headers: { 'Access-Control-Allow-Origin': '*' } },
    );
  }
}
