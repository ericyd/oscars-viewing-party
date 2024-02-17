import { Client } from "pg";

export async function query(env, query) {
  const client = new Client(env.DB_URL);
  try {
    await client.connect();
    return await client.query(query)
  } catch (e) {
    throw e
  } finally {
    await client.end()
  }
}
