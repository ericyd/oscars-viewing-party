import { dbQuery } from '../db.js';

// upsertPrediction
export async function onRequest(req) {
  try {
    const year = req.params.year;
    const json = await req.json();
    // this data structure doesn't make sense, but it was taken from the original "upsertPredictons" (plural)
    // and it works fine for now
    const predictions = [
      {
        user_id: json.userId,
        category_id: json.categoryId,
        nominee_id: json.nomineeId,
      },
    ];

    const { rows: alreadyDecided } = await dbQuery(`select category_id from nominees where winner = true and year = $1`, [year]);
    const filteredPredctions = predictions.filter((p) => !alreadyDecided.some((a) => a.category_id === p.category_id));
    const error = filteredPredctions.length !== predictions.length ? 'updating_after_decided' : null;
    if (filteredPredctions.length > 0) {
      let valuesSql = [];
      let values = [];
      for (const p of filteredPredctions) {
        valuesSql.push(`($${values.length + 1}, $${values.length + 2}, $${values.length + 3})`);
        values.push(p.user_id, p.category_id, p.nominee_id);
      }
      const sql = `
        insert into predictions (user_id, category_id, nominee_id)
        values ${valuesSql.join(',')}
        on conflict (user_id, category_id)
        do update set
          nominee_id = EXCLUDED.nominee_id
      `;
      await dbQuery(sql, values);
    }
    return Response.json({ success: true, error }, { headers: { 'Access-Control-Allow-Origin': '*' } });
  } catch (e) {
    console.error(e);
    return Response.json({ code: 'unknown', message: e.message }, { status: 500, headers: { 'Access-Control-Allow-Origin': '*' } });
  }
}
