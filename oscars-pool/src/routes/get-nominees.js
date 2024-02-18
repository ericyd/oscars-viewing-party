import { query } from '../db.js'

export async function getNominees(_request, env, _context, _data) {
  const { rows: nominees } = await query(env, "SELECT * FROM nominees;");
  return Response.json({ nominees })
}
