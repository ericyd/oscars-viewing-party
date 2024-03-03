<script setup>
import { request } from '@/api';
import { onMounted, ref } from 'vue';
import { useRoute, useRouter } from 'vue-router';

const router = useRouter();
const route = useRoute();
const userId = localStorage.getItem('oscars-viewing-party-userId');
const roomId = localStorage.getItem('oscars-viewing-party-roomId');
const { year } = route.params;
const list = ref([]);
const predictions = defineModel('predictions');
const status = ref({})

onMounted(async () => {
  const json = await request(`/nominees/${year}?userId=${userId}`);
  console.log({ json });
  list.value = json.nominees;
  // this feels like bubblegum and tape
  // the idea here is that the "predictions" model is an Record<category_id, nominee_id> type;
  // the nominee_id must be equal to the value which was predicted by the current user.
  // this value gets updated via the v-model bindings in the radio inputs.
  const categories = json.nominees.flatMap((n) => n.categories);
  predictions.value = categories.reduce(
    (map, curr) => ({ ...map, [curr.category_id]: curr.nominees.find((n) => n.prediction_nominee_id)?.nominee_id ?? null }),
    {},
  );
  console.log({ 'predictions.value': predictions.value });
});

async function handleSubmit(categoryId) {
  console.log({ 'predictions.value': predictions.value[categoryId] });
  const body = {
    userId,
    categoryId,
    nomineeId: predictions.value[categoryId],
  };
  try {
    const json = await request(`/prediction/${year}`, 'post', body);
    console.log({ json });
    status.value[categoryId] = 'Saved! ✅'
  } catch (e) {
    status.value[categoryId] = 'You broke something 😿'
  }
}
</script>

<template>
  <h1>Make your predictions</h1>

  <RouterLink :to="`/${roomId}`" class="block margin-bottom">Back to room {{ roomId }}</RouterLink>

  <template v-for="item of list">
    <h2 class="meta-category">{{ item.meta_category }}</h2>
    <template v-for="c of item.categories">
      <h3>{{ c.category }}</h3>
      <form @submit.prevent="(e) => handleSubmit(c.category_id)" class="margin-bottom">
        <div v-for="n of c.nominees" class="flex margin-bottom">
          <div class="width-2 flex items-center">
            <input
              type="radio"
              :name="n.category_id"
              :value="n.nominee_id"
              v-model="predictions[n.category_id]"
              :id="`${n.category_id}_${n.nominee_id}`"
              :checked="n.prediction_nominee_id === n.nominee_id ? 'checked' : undefined"
            />
          </div>
          <div class="flex items-center max-width-80">
            <label :for="`${n.category_id}_${n.nominee_id}`">
              {{ n.nominee }}
              <strong class="block small">{{ n.artwork }}</strong>
            </label>
          </div>
        </div>
        <button type="submit">Submit prediction for {{ c.category }}</button>
        <div v-if="status[c.category_id]">{{ status[c.category_id] }}</div>
      </form>
    </template>
  </template>
  <RouterLink :to="`/${roomId}`" class="block margin-bottom">Back to room {{ roomId }}</RouterLink>
</template>
