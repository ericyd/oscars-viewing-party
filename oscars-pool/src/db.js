import { Client } from 'pg';

export async function dbQuery(env, ctx, query, values = []) {
  const client = new Client(env.DB_URL);
  try {
    await client.connect();
    return await client.query(query, values);
  } catch (e) {
    throw e;
  } finally {
    ctx.waitUntil(client.end());  // this doesn’t hold up the response
  }
}
