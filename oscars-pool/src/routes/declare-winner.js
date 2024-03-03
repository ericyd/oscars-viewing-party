import { dbQuery } from '../db.js';

export async function declareWinner(req, env, ctx) {
  try {
    const body = await req.json();
    // in order to declare a winner, you must know the username of the first user marked "admin".
    // super hacky, and also totally fine for this project app!
    const {
      rows: [{ username: secretPhrase }],
    } = await dbQuery(env, ctx, `select id, username from users where admin = true order by id asc`);
    if (typeof body.nominee_id !== 'number' || body.secret_phrase !== secretPhrase) {
      return Response.json(
        {
          code: 'CHEATER',
        },
        {
          status: 403,
          headers: { 'Access-Control-Allow-Origin': '*' },
        },
      );
    }

    // reset all nominees for this category/year
    const resetStatement = `
      update nominees
      set winner = false
      where category_id in (
        select category_id
        from nominees
        where id = $1
      )
      and year = $2
    `;
    await dbQuery(env, ctx, resetStatement, [body.nominee_id, req.params.year]);

    // set the winner for this category/year
    const setWinnerStatement = `
      update nominees
      set winner = true
      where id = $1
      and year = $2
    `;
    const { rowCount } = await dbQuery(env, ctx, setWinnerStatement, [body.nominee_id, req.params.year]);
    return Response.json({ nominee_id: body.nominee_id, row_count: rowCount }, { headers: { 'Access-Control-Allow-Origin': '*' } });
  } catch (e) {
    console.error(e);
    const code = e.message.includes('unique constraint') ? 'unique_conflict' : 'unknown';
    return Response.json(
      {
        code,
        message: e.message,
      },
      {
        status: 500,
        headers: { 'Access-Control-Allow-Origin': '*' },
      },
    );
  }
}
