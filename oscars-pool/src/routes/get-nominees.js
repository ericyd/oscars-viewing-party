import { dbQuery } from '../db.js';
import { groupNominees } from '../util/group-nominees.js';

export async function getNominees({ params, query }, env, ctx) {
  try {
    const sql = `
      select
        category,
        meta_category,
        nominees.id as nominee_id,
        categories.id as category_id,
        nominee,
        artwork,
        year,
        predictions.nominee_id as prediction_nominee_id
      from categories
      join nominees on nominees.category_id = categories.id
      left join predictions on (
        predictions.nominee_id = nominees.id
        and (
          predictions.user_id = $1
          or predictions.user_id = null
        )
      )
      where nominees.year = $2
      and nominees.category_id not in (
        select category_id
        from nominees
        where winner = true
        and year = $2
      )
`;
    const { rows: nominees } = await dbQuery(env, ctx, sql, [query.userId ?? null, params.year]);
    return Response.json({ nominees: groupNominees(nominees) }, { headers: { 'Access-Control-Allow-Origin': '*' } });
  } catch (e) {
    console.error(e);
    return Response.json(
      {
        code: 'unknown',
        message: e.message,
      },
      { status: 500, headers: { 'Access-Control-Allow-Origin': '*' } },
    );
  }
}
