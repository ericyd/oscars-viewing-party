import express from 'express'
import { db } from '../db/db.js';
import { getNominees } from './queries.js';
const router = express.Router();

router.get('/nominees/:year', async (req, res) => {
  return res.status(200).json({ nominees: await getNominees(req.params.year) })
});

router.get('/categories', async (req, res) => {
  const categories = await db.select('*').from('categories')
  return res.status(200).json({ categories: groupCategories(categories) })
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
