import { dbQuery } from '../db.js';
import { groupCategories } from '../util/group-categories.js';

export async function getCategories(_request, env, ctx) {
  try {
    const { rows: categories } = await dbQuery(env, ctx, 'select * from categories');
    return Response.json({ categories: groupCategories(categories) }, { headers: { 'Access-Control-Allow-Origin': '*' } });
  } catch (e) {
    console.error(e);
    return Response.json({ code: 'unknown', message: e.message }, { status: 500, headers: { 'Access-Control-Allow-Origin': '*' } });
  }
}
