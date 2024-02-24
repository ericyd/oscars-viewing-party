export function groupNominees(list) {
  const groups = [];
  for (const nomination of list) {
    const { meta_category, category, ...nominee } = nomination;
    const foundMetaCategory = groups.find((g) => g.metaCategory === meta_category);
    if (foundMetaCategory) {
      const foundCategory = foundMetaCategory.categories.find((c) => c.category === category);
      if (foundCategory) {
        foundCategory.nominees.push(nominee);
      } else {
        foundMetaCategory.categories.push({
          category,
          nominees: [nominee],
        });
      }
    } else {
      groups.push({
        metaCategory: meta_category,
        categories: [
          {
            category: category,
            nominees: [nominee],
          },
        ],
      });
    }
  }
  groups.sort((a, b) => (a.metaCategory > b.metaCategory ? 1 : b.metaCategory > a.metaCategory ? -1 : 0));
  return groups;
}
