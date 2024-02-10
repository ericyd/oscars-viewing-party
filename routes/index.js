import express from 'express'
import { db } from '../db/db.js'
import { getNominees } from './queries.js';
const router = express.Router();

/* GET home page. */
router.get('/', (req, res, next) => {
  res.render('index');
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
  req.session.roomId = req.params.roomId
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
  const [existing] = await db.select('*').from('users').where({ name: req.body.name, username: req.body.username })

  // if they have the same name AND username, let's just assume they are trying to get back in
  // remember, this app is NOT secure, no passwords here!!!
  if (existing) {
    req.session.userId = existing.id
    req.session.name = existing.name
    return res.redirect(`/room/${req.params.roomId}`)
  }

  try {
    const [person] = await db('users').returning('*').insert({ ...req.body, room_id: req.params.roomId })
    req.session.userId = person.id
    req.session.name = person.name
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

router.get('/room/:roomId/person/:userId', async (req, res, next) => {
  // TODO: this is close, but not left joining the way I'd expect.
  // Also it should be structured like the "groupNominees" query
  const data = await db
    .select(
      '*',
      'predictions.id as prediction_id'
    )
    .from('nominees')
    .join('categories', 'categories.id', '=', 'nominees.category_id')
    .leftJoin('predictions', 'predictions.nominee_id', '=', 'nominees.id')
    .join('users', 'users.id', '=', 'predictions.user_id')
    .where({
      'predictions.user_id': req.params.userId,
    })
  const [user] = await db.select('*').from('users').where({ id: req.params.userId })
  console.log(data, user)
  res
    .render('person', {
      roomId: req.params.roomId,
      person: user.name /** todo: get person with votes */,
      list: data
    });
});

export default router;
