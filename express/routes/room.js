import express from 'express';
import { db } from '../db/db.js';
import peopleRouter from './people.js';
const router = express.Router();

router.post('/room', async (req, res) => {
  const roomId = req.body.roomId.replace(/[^a-zA-Z0-9]/g, '-');
  if (!roomId) {
    res.render('error', { message: 'Oops, you broke the whole app', subheading: 'Try not to be so bad at this', error: null });
  }

  return res.redirect(`/${roomId}`);
});

router.get('/:roomId', async (req, res, next) => {
  req.session.roomId = req.params.roomId;
  try {
    const people = await db
      .with(
        'winners',
        db.raw(`
          select
            winners.category_id,
            winners.winning_nominee_id
          from categories
          left join (
            select id as winning_nominee_id, category_id
            from nominees
            where nominees.winner = true
          ) as winners on winners.category_id = categories.id
        `),
      )
      .select(
        'users.id',
        'users.name',
        db.raw(`count(predictions.*) as total_predictions`),
        db.raw(`
          count(*) filter (
            where exists (select * from winners where winning_nominee_id = predictions.nominee_id)
          ) as correct
        `),
        db.raw(`
          count(*) filter (
            where predictions.category_id is not null
            and not exists (select * from winners where category_id = predictions.category_id)
          ) as undecided
        `),
        db.raw(`
          count(*) filter (
            where exists (select * from winners where category_id = predictions.category_id)
            and not exists (select * from winners where winning_nominee_id = predictions.nominee_id)
          ) as wrong
        `),
      )
      .from('users')
      .leftJoin('predictions', 'predictions.user_id', '=', 'users.id')
      .where({ room_id: req.params.roomId })
      .groupBy('users.id', 'users.name');

    const errors = {
      unique_conflict: 'Looks like that name or username is already taken, please try again',
      updating_after_decided:
        "Looks like you might be trying to cheat, and submit predictions after a decision has already been made! Don't worry, you other predictions were saved.",
    };
    res.render('room', {
      roomId: req.params.roomId,
      people,
      error: errors[req.query?.error] ?? null,
      userId: req.session.userId,
      name: req.session.name,
    });
  } catch (e) {
    res.render('error', { message: "Wow, you aren't very good at this", subheading: 'Next time try not to break it', error: e });
  }
});

router.post('/:roomId/join', async (req, res, next) => {
  const [existing] = await db.select('*').from('users').where({ name: req.body.name, username: req.body.username });

  // if they have the same name AND username, let's just assume they are trying to get back in
  // remember, this app is NOT secure, no passwords here!!!
  if (existing) {
    req.session.userId = existing.id;
    req.session.name = existing.name;
    return res.redirect(`/${req.params.roomId}`);
  }

  try {
    const [person] = await db('users')
      .returning('*')
      .insert({ ...req.body, room_id: req.params.roomId });
    req.session.userId = person.id;
    req.session.name = person.name;
    return res.redirect(`/${req.params.roomId}`);
  } catch (e) {
    if (e.message.includes('unique constraint')) {
      return res.redirect(`/${req.params.roomId}?error=unique_conflict`);
    } else {
      res.render('error', {
        error: e,
        message: 'I have no idea how you are so bad at this',
        subheading: "You should probably stop while you're behind",
      });
    }
  }
});

router.use('/:roomId/person', peopleRouter);

export default router;
