import express from 'express'
import { db } from '../db/db.js'
import { getNominees } from './queries.js';
const router = express.Router();

router.get('/:year', async (req, res, next) => {
  // TOD: do not show ones that already have a winner!
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
  try {
    const predictions = Object.entries(req.body).map(([category_id, nominee_id]) => ({
      user_id: req.session.userId,
      category_id,
      nominee_id
    }))
    // TODO: fetch categories that are already decided, and filter out predictions from that category
    const alreadyDecided = [];
    const filteredPredctions = predictions.filter(p => !alreadyDecided.some(a => a.category_id = p.category_id))
    const error = filteredPredctions.length !== predictions.length ? '?error=updating_after_decided' : ''
    await db('predictions').insert(predictions).onConflict(['user_id', 'category_id']).merge()
    return res.redirect(`/room/${req.session.roomId}${error}`)
  } catch (e) {
    return res.render('error', { message: e.message, subheading: null, error: e })
  }
});

export default router;
