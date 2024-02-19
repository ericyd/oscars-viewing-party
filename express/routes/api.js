import express from 'express'
import { db } from '../db/db.js';
import { groupNominees } from './queries.js';
const router = express.Router();

router.get('/nominees/:year', async (req, res) => {
  try {
    const nominees = await db
      .select(
        'category',
        'meta_category',
        'nominees.id as nominee_id',
        'categories.id as category_id',
        'nominee',
        'artwork',
        'year',
      )
      .from('categories')
      .join('nominees', 'nominees.category_id', '=', 'categories.id')
      .where({ 'nominees.year': req.params.year })
    return res.status(200).json({ nominees: groupNominees(nominees) })
  } catch (e) {
    return res.status(500).json({ error: e })
  }
});

router.get('/categories', async (req, res) => {
  try {
    const categories = await db.select('*').from('categories')
    return res.status(200).json({ categories: groupCategories(categories) })
  } catch (e) {
    return res.status(500).json({ error: e })
  }
})

function groupCategories(list) {
  const groups = []
  for (const item of list) {
    const { meta_category, ...category } = item
    const foundMetaCategory = groups.find(g => g.metaCategory === meta_category)
    if (foundMetaCategory) {
      foundMetaCategory.categories.push(category)
    } else {
      groups.push({
        metaCategory: meta_category,
        categories: [category]
      })
    }
  }
  groups.sort((a, b) => a.metaCategory > b.metaCategory ? 1 : b.metaCategory > a.metaCategory ? -1 : 0)
  return groups
}

export default router;
