export function groupNominees(list) {
  const groups = []
  for (const nomination of list) {
    const { meta_category, category, ...nominee } = nomination
    const foundMetaCategory = groups.find(g => g.meta_category === meta_category)
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
        meta_category,
        categories: [{
          category: category,
          nominees: [nominee]
        }]
      })
    }
  }
  groups.sort((a, b) => a.meta_category > b.meta_category ? 1 : b.meta_category > a.meta_category ? -1 : 0)
  return groups
}
