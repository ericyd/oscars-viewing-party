import * as pg from 'pg';
const { Client } = pg;

export async function dbQuery(env, ctx, query, values = []) {
  const client = new Client({ connectionString: env.DB_URL });
  try {
    await client.connect();
    return await client.query(query, values);
  } catch (e) {
    throw e;
  } finally {
    // cleans up the client without having to `await` the result and hold up the response
    ctx.waitUntil(client.end());
  }
}
