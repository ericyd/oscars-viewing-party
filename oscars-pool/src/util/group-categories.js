export function groupCategories(list) {
  const groups = []
  for (const item of list) {
    const { meta_category, ...category } = item
    const foundMetaCategory = groups.find(g => g.meta_category === meta_category)
    if (foundMetaCategory) {
      foundMetaCategory.categories.push(category)
    } else {
      groups.push({
        meta_category: meta_category,
        categories: [category]
      })
    }
  }
  groups.sort((a, b) => a.meta_category > b.meta_category ? 1 : b.meta_category > a.meta_category ? -1 : 0)
  return groups
}
