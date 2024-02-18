export async function upsertPredictions(req, env, ctx) {
  try {
    const year = req.params.year;
    const json = await req.json();
    const predictions = Object.entries(json.predictions).map(([category_id, nominee_id]) => ({
      user_id: json.userId,
      category_id,
      nominee_id,
    }));

    const { rows: alreadyDecided } = await dbQuery(env, ctx, `select category_id from nominees where winner = true and year = $1`, [year]);
    const filteredPredctions = predictions.filter((p) => !alreadyDecided.some((a) => String(a.category_id) === String(p.category_id)));
    const error = filteredPredctions.length !== predictions.length ? '?error=updating_after_decided' : '';
    if (filteredPredctions.length > 0) {
      let valuesSql = ``;
      let values = [];
      for (const p of predictions) {
        valuesSql += `($${values.length + 1}, $${values.length + 2}, $${values.length + 3})`;
        values.push(p.user_id, p.category_id, p.nominee_id);
      }
      await dbQuery(
        env,
        `insert into predictions (user_id, category_id, nominee_id) values ${valuesSql} on conflict user_id, category_id do update`,
        values,
      );
    }
    return Response.json({ success: true });
  } catch (e) {
    return Response.json({ code: 'unknown', message: e.message }, { status: 500 });
  }
}
