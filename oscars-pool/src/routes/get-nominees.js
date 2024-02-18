import { dbQuery } from '../db.js';

export async function getNominees(_request, env, _context, _data) {
  const { rows: nominees } = await dbQuery(env, 'SELECT * FROM nominees;');
  return Response.json({ nominees });
}
