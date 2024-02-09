import dotenv from 'dotenv'
dotenv.config()
import knex from 'knex'

console.log(process.env.DB_CONNECTION_STRING)

export const db = knex({
  client: 'pg',
  connection: process.env.DB_CONNECTION_STRING,
  searchPath: ['public'],
});
