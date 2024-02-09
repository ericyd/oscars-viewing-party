import express from 'express'
import { db } from '../db/db.js';
const router = express.Router();

router.get('/nominees/:year', async (req, res) => {
  const nominees = await db
    .select(
      'category',
      'meta_category',
      'nominees.id as nominee_id',
      'categories.id as category_id',
      'nominee',
      'artwork',
      'year'
    )
    .from('categories')
    .join('nominees', 'nominees.category_id', '=', 'categories.id')
    .where({ 'nominees.year': req.params.year })
  return res.status(200).json({ nominees: groupNominees(nominees) })
});

router.get('/categories', async (req, res) => {
  const categories = await db.select('*').from('categories')
  return res.status(200).json({ categories: groupCategories(categories) })
})

function groupNominees(list) {
  const groups = []
  for (const nomination of list) {
    const { meta_category, category, ...nominee } = nomination
    const foundMetaCategory = groups.find(g => g.metaCategory === meta_category)
    if (foundMetaCategory) {
      const foundCategory = foundMetaCategory.categories.find(c => c.category === category)
      if (foundCategory) {
        foundCategory.nominees.push(nominee)
      } else {
        foundMetaCategory.categories.push({
          category,
          nominees: [nominee]
        })
      }
    } else {
      groups.push({
        metaCategory: meta_category,
        categories: [{
          category: category,
          nominees: [nominee]
        }]
      })
    }
  }
  groups.sort((a, b) => a.metaCategory > b.metaCategory ? 1 : b.metaCategory > a.metaCategory ? -1 : 0)
  return groups
}

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
