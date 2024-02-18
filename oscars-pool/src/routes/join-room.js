import { dbQuery } from '../db.js';

export async function joinRoom(req, env, ctx) {
  const body = await req.json();
  const { rows: existing } = await dbQuery(
    env,
    `select *
    from users
    where name = $1
    and username = $2`,
    [body.name, body.username],
  );
  if (existing[0]) {
    return Response.json({
      name: existing[0].name,
      username: existing[0].username,
    });
  }
  try {
    const { rows: created } = await dbQuery(env, ctx, `insert into users (name, username, room_id) values ($1, $2, $3) returning *`, [
      body.name,
      body.username,
      req.params.roomId,
    ]);
    return Response.json({ name: created[0].name, username: created[0].username });
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
      },
    );
  }
}
