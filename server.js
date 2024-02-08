/**
 * Important: this app is 100% insecure!!! 😅
 */
import dotenv from 'dotenv'
dotenv.config()
import express from 'express'
import knex from 'knex'
const app = express()
const port = 3000

const db = knex({
  client: 'pg',
  connection: process.env.DB_CONNECTION_STRING,
  searchPath: ['public'],
});

app.use(express.json())

app.get('/health', (req, res) => {
  res.status(200).send('OK')
})

function requireRoomId(req, res, next) {
  if (!req.params.room_id) {
    return res.status(500).json({ error: 'gotta include a room id' })
  }
  req.local = { roomId: req.params.room_id }
  next()
}

// "find or create"... "GET"... bad Eric...
app.get('/room/:room_id', requireRoomId, async (req, res) => {
  const [room] = await db.select('*').from('rooms').where({ id: req.local.roomId })
  if (room) {
    return res.status(200).json({ roomId: room.id, alreadyExists: true })
  } else {
    const [room] = await db('rooms').returning('id').insert({ id: req.local.roomId })
    return res.status(200).json({ roomId: room.id, alreadyExists: false })
  }
})

app.get('/room/:room_id/people', requireRoomId, async (req, res) => {
  const people = await db.select('*').from('users').where({ room_id: req.local.roomId })
  return res.status(200).json({ people })
})

app.get('/room/:room_id/people/:person_id', requireRoomId, async (req, res) => {
  const people = await db.select(
      'users.name as user_name',
      'category',
      'meta_category',
      'nominee',
      'artwork',
    )
    .from('users')
    .join('votes', 'users.id', '=', 'votes.user_id')
    .join('nominees', 'nomiees.id', '=', 'votes.nominee_id')
    .join('categories', 'categories.id', '=', 'votes.category_id')
    .where({
      room_id: req.local.roomId,
      'users.id': req.params.person_id,
    })
  return res.status(200).json({ people })
})

app.post('/room/:room_id/add_person', requireRoomId, async (req, res) => {
  const [person] = await db('users').returning('id').insert({...req.body, room_id: req.local.roomId })
  return res.status(200).json({ id: person?.id, username: req.body.username })
})

app.get('/nominees/:year', async (req, res) => {
  const nominees = await db
    .select(
      'category',
      'meta_category',
      'nominees.id as nominee_id',
      'categories.id as category_id',
      'nominee',
      'artwork',
      'year'
    )
    .from('categories')
    .join('nominees', 'nominees.category_id', '=', 'categories.id')
    .where({ 'nominees.year': req.params.year })
  return res.status(200).json(nominees)
})

app.get('/categories', async (req, res) => {
  const categories = await db.select('*').from('categories')
  return res.status(200).json(categories)
})

app.post('/vote', requireRoomId, async (req, res) => {
  /*
  body should have shape
  {
    votes: [
      {
        user_id: '1',
        nominee_id: '2',
        category_id: '3',
      },
      ...
    ]
  }
  */
  await db('votes').insert(req.body.votes)
  return res.status(200).json({ message: 'i voted' })
})

app.listen(port, () => {
  console.log(`Listening on port ${port}`)
})
