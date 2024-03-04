import { dbQuery } from '../db.js';
import { groupNominees } from '../util/group-nominees.js';

export async function getAllNominees(_req, env, ctx, _data) {
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
        nominees.winner
      from categories
      join nominees on nominees.category_id = categories.id
      where nominees.year = 2024
    `;
    const { rows: nominees } = await dbQuery(env, ctx, sql, []);
    return Response.json({ nominees: groupNominees(nominees) }, { headers: { 'Access-Control-Allow-Origin': '*' } });
  } catch (e) {
    console.error(e);
    return Response.json(
      {
        message: e.message,
        code: 'unknown',
      },
      { status: 500, headers: { 'Access-Control-Allow-Origin': '*' } },
    );
  }
}
