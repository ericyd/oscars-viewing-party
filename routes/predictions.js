import express from 'express'
import { db } from '../db/db.js'
import { groupNominees } from './queries.js';
const router = express.Router();

router.get('/:year', async (req, res, next) => {
  const nominees = await db
    .select(
      'category',
      'meta_category',
      'nominees.id as nominee_id',
      'categories.id as category_id',
      'nominee',
      'artwork',
      'year',
      'predictions.nominee_id as prediction_nominee_id'
    )
    .from('categories')
    .join('nominees', 'nominees.category_id', '=', 'categories.id')
    .leftJoin('predictions', function() {
      this
        .on('predictions.nominee_id', '=', 'nominees.id')
        .andOn('predictions.user_id', '=', db.raw(req.session.userId))
        .orOn(db.raw('predictions.user_id is null'))
    })
    .where({ 'nominees.year': req.params.year })
    .andWhereRaw(`
      nominees.category_id not in (
        select category_id
        from nominees
        where winner = true
        and year = ?
      )
    `, req.params.year)
  res.render('predictions', { year: req.params.year, list: groupNominees(nominees) });
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
    const alreadyDecided = await db.select('category_id').from('nominees').where({ winner: true, year: req.params.year });
    const filteredPredctions = predictions.filter(p => !alreadyDecided.some(a => String(a.category_id) === String(p.category_id)))
    const error = filteredPredctions.length !== predictions.length ? '?error=updating_after_decided' : ''
    if (filteredPredctions.length > 0) {
      await db('predictions').insert(filteredPredctions).onConflict(['user_id', 'category_id']).merge()
    }
    return res.redirect(`/${req.session.roomId}${error}`)
  } catch (e) {
    return res.render('error', { message: e.message, subheading: null, error: e })
  }
});

export default router;
