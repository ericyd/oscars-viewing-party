export function groupNominees(list) {
  const groups = [];
  for (const nomination of list) {
    const { meta_category, category, ...nominee } = nomination;
    const foundMetaCategory = groups.find((g) => g.meta_category === meta_category);
    if (foundMetaCategory) {
      const foundCategory = foundMetaCategory.categories.find((c) => c.category === category);
      if (foundCategory) {
        foundCategory.nominees.push(nominee);
        if (nominee.winner) {
          foundCategory.winning_nominee_id = nominee.category_id;
        }
      } else {
        foundMetaCategory.categories.push({
          category,
          category_id: nominee.category_id,
          winning_nominee_id: nominee.winner ? nominee.category_id : null,
          nominees: [nominee],
        });
      }
    } else {
      groups.push({
        meta_category,
        categories: [
          {
            category,
            category_id: nominee.category_id,
            winning_nominee_id: nominee.winner ? nominee.category_id : null,
            nominees: [nominee],
          },
        ],
      });
    }
  }
  groups.sort((a, b) => (a.meta_category > b.meta_category ? 1 : b.meta_category > a.meta_category ? -1 : 0));
  return groups;
}
