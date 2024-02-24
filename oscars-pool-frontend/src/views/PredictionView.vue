<script setup>
import { request } from '@/api';
import { onMounted, ref } from 'vue';
import { useRoute, useRouter } from 'vue-router';

const router = useRouter();
const route = useRoute();
const userId = localStorage.getItem('oscars-viewing-party-userId')
const { year } = route.params;
const list = ref([]);
const predictions = defineModel('predictions')

onMounted(async () => {
  const json = await request(`/nominees/${year}?userId=${userId}`);
  console.log({json});
  list.value = json.nominees;
  const categories = json.nominees.flatMap(n => n.categories)
  // this feels like bubblegum and tape
  predictions.value = categories.reduce((map, curr) => ({ ...map, [curr.category_id]: curr.nominees.find(n => n.prediction_nominee_id)?.nominee_id ?? null }), {})
  console.log({'predictions.value': predictions.value})
});

async function handleSubmit() {
  console.log(predictions.value)
  const body = {
    userId,
    predictions: predictions.value,
  };
  const json = await request(`/predictions/${year}`, 'post', body);
  
  console.log(json);
  router.push(`/${localStorage.getItem('oscars-viewing-party-roomId')}`);
}
</script>

<template>
  <h1>Make your predictions</h1>

  <form @submit.prevent="handleSubmit">
    <template v-for="item of list">
      <h2 class="meta-category">{{ item.metaCategory }}</h2>
      <template v-for="c of item.categories">
        <h3>{{ c.category }}</h3>
        <div v-for="n of c.nominees" class="flex margin-bottom">
          <div class="width-2 flex items-center">
            <!-- v-model="predictions[`${n.category_id}_${n.nominee_id}`]" -->
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
      </template>
    </template>
    <button type="submit">Submit predictions</button>
  </form>
</template>

