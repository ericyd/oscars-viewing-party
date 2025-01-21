import { dbQuery } from '../util/db';
import { groupCategories } from '../util/group-categories';

// getCategories
export async function onRequest(context) {
  const params = context.params
  console.log({params})
  try {
    const categories = await dbQuery('select * from categories');
    console.log({categories});
    return Response.json({ categories: groupCategories(categories) }, { headers: { 'Access-Control-Allow-Origin': '*' } });
  } catch (e) {
    console.error(e);
    return Response.json({ code: 'unknown', message: e.message }, { status: 500, headers: { 'Access-Control-Allow-Origin': '*' } });
  }
}
