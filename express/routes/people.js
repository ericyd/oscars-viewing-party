import express from 'express'
import { db } from '../db/db.js'
import { groupNominees } from './queries.js';
const router = express.Router();

router.get('/:userId', async (req, res, next) => {
  try {
    const data = await db
      .select(
        '*',
        'nominees.id as nominee_id',
        'predictions.id as prediction_id',
        'predictions.nominee_id as prediction_nominee_id',
      )
      .from('nominees')
      .join('categories', 'categories.id', 'nominees.category_id')
      .joinRaw(`
        left join (
          select id as winning_nominee_id, category_id
          from nominees
          where nominees.winner = true
        ) as winners on winners.category_id = categories.id
      `)
      .leftJoin('predictions', function() {
        this
          .on('predictions.nominee_id', '=', 'nominees.id')
          .andOn('predictions.user_id', '=', db.raw(req.params.userId))
          .orOn(db.raw('predictions.user_id is null'))
      })
  
    const [user] = await db.select('*').from('users').where({ id: req.params.userId })
    res
      .render('person', {
        roomId: req.params.roomId,
        person: user.name,
        list: groupNominees(data)
      });
  } catch (e) {
    res.render('error', {
      error: e,
      message: "I can't believe you did that",
      subheading: 'You broke it'
    })
  }
});

export default router;
