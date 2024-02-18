import { dbQuery } from '../db';
import { groupCategories } from '../util/group-categories';

export async function getCategories(_request, env) {
  try {
    const { rows: categories } = await dbQuery(env, 'select * from categories');
    return Response.json({ categories: groupCategories(categories) });
  } catch (e) {
    console.error(e);
    return Response.json({ code: 'unknown', message: e.message }, { status: 500 });
  }
}
