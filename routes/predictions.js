import express from 'express'
import { db } from '../db/db.js'
import { getNominees } from './queries.js';
const router = express.Router();

router.get('/:year', async (req, res, next) => {
  const nominees = await getNominees(req.params.year)
  res.render('predictions', { year: req.params.year, list: nominees });
});

/*
body has the shape
{
  [category_id]: nominee_id
}
*/
router.post('/:year', async (req, res, next) => {
  const predictions = Object.entries(req.body).map(([category_id, nominee_id]) => ({
    user_id: req.session.userId,
    category_id,
    nominee_id
  }))
  await db('predictions').insert(predictions)
  return res.redirect(`/room/${req.session.roomId}`)
});

export default router;
