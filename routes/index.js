import express from 'express'
import { db } from '../db/db.js'
import { getNominees } from './queries.js';
const router = express.Router();

/* GET home page. */
router.get('/', (req, res, next) => {
  res.render('index', { title: 'Express' });
});

router.get('/vote/:year', async (req, res, next) => {
  const nominees = await getNominees(req.params.year)
  res.render('vote', { year: req.params.year, list: nominees });
});

router.post('/room', async (req, res) => {
  const roomId = req.body.roomId.replace(/[^a-zA-Z0-9]/g, '-')
  if (!roomId) {
    res.render('error', { message: 'you gotta include a room id' })
  }

  const [room] = await db.select('*').from('rooms').where({ id: roomId })
  if (!room) {
    await db('rooms').insert({ id: roomId })
  }
  return res.redirect(`/room/${roomId}`)
});

router.get('/room/:roomId', async (req, res, next) => {
  res
    .render('room', {
      roomId: req.params.roomId,
      people: await getPeople(req.params.roomId),
      error: req.query.error === 'unique_conflict' ? 'Looks like that name or username is already taken, please try again' : null,
      userId: req.session.userId,
      name: req.session.name
    });
});

router.post('/room/:roomId/join', async (req, res, next) => {
  try {
    const [person] = await db('users').returning('*').insert({ ...req.body, room_id: req.params.roomId })
    req.session.userId = person.id
    req.session.name = person.name
    console.log(person.name)
    // await new Promise((resolve, reject) => req.session.save(resolve))
    return res.redirect(`/room/${req.params.roomId}`)
  } catch (e) {
    if (e.message.includes('unique constraint')) {
      return res.redirect(`/room/${req.params.roomId}?error=unique_conflict`)
    } else {
      throw e
    }
  }
});

async function getPeople(roomId) {
  return db.select('*').from('users').where({ room_id: roomId })
}

export default router;
