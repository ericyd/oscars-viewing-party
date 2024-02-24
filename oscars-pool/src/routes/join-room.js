import { dbQuery } from '../db.js';

export async function joinRoom(req, env, ctx) {
  const body = await req.json();
  console.log(body);
  const {
    rows: [existing],
  } = await dbQuery(
    env,
    ctx,
    `select *
    from users
    where name = $1
    and username = $2`,
    [body.name, body.username],
  );
  if (existing) {
    return Response.json({
      name: existing.name,
      username: existing.username,
      roomId: req.params.roomId,
      userId: existing.id,
    });
  }
  try {
    const {
      rows: [user],
    } = await dbQuery(env, ctx, `insert into users (name, username, room_id) values ($1, $2, $3) returning *`, [
      body.name,
      body.username,
      req.params.roomId,
    ]);
    return Response.json(
      { name: user.name, username: user.username, roomId: req.params.roomId, userId: user.id },
      { headers: { 'Access-Control-Allow-Origin': '*' } },
    );
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
