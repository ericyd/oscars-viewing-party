import express from 'express'
import { db } from '../db/db.js'
import { getNominees } from './queries.js';
const router = express.Router();

router.get('/:year', async (req, res, next) => {
  const nominees = await getNominees(req.params.year, req.session.userId)
  res.render('predictions', { year: req.params.year, list: nominees });
});

/*
body has the shape
{
  [category_id]: nominee_id
}
*/
router.post('/:year', async (req, res, next) => {
  if (!req.session.userId) {
    return res.render('error', { message: 'Way to go, loser', subheading: 'You have to be "logged in" to submit predictions', error: null })
  }
  const predictions = Object.entries(req.body).map(([category_id, nominee_id]) => ({
    user_id: req.session.userId,
    category_id,
    nominee_id
  }))
  try {
    await db('predictions').insert(predictions).onConflict(['user_id', 'category_id']).merge()
    return res.redirect(`/room/${req.session.roomId}`)
  } catch (e) {
    return res.render('error', { message: e.message, subheading: null, error: e })
  }
});

export default router;
