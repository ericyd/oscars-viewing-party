import dotenv from 'dotenv'
dotenv.config()
import knex from 'knex'

export const db = knex({
  client: 'pg',
  connection: process.env.DB_CONNECTION_STRING,
  searchPath: ['public'],
});
