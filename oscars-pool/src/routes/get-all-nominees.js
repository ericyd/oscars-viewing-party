import { dbQuery } from '../db.js';
import { groupNominees } from '../util/group-nominees.js';

export async function getAllNominees({ params }, env, _context, _data) {
  const { rows: nominees } = await dbQuery(env, 'SELECT * FROM nominees;');

  try {
    const sql = `
      select
        category,
        meta_category,
        nominees.id as nominee_id,
        categories.id as category_id,
        nominee,
        artwork,
        year
      from categories
      join nominees on nominees.category_id = categories.id
      where nominees.year = $1
    `;
    const { rows: nominees } = await dbQuery(env, sql, [params.year]);
    return Response.json({ nominees: groupNominees(nominees) });
  } catch (e) {
    console.error(e);
    return Response.json(
      {
        message: e.message,
        code: 'unknown',
      },
      { status: 500 },
    );
  }
}
