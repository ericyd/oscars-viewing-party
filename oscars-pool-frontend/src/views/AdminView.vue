<script setup>
import { request } from '@/api';
import { onMounted, ref } from 'vue';
import { useRoute } from 'vue-router';

const route = useRoute();
const { year } = route.params;
const list = ref([]);
const secretPhrase = ref('');
const winners = defineModel('winners');
const errors = ref({});

onMounted(async () => {
  const json = await request(`/all-nominees/${year}`);
  console.log({ json });
  list.value = json.nominees;
  // this feels like bubblegum and tape
  // the idea here is that the "winners" model is an Record<category_id, nominee_id> type;
  // the nominee_id must be equal to the value which was predicted by the current user.
  // this value gets updated via the v-model bindings in the radio inputs.
  const categories = json.nominees.flatMap((n) => n.categories);
  winners.value = categories.reduce((map, curr) => ({ ...map, [curr.category_id]: curr.winning_nominee_id }), {});
  console.log({ 'winners.value': winners.value });
});

async function handleSubmit(categoryId) {
  const body = {
    secret_phrase: secretPhrase.value,
    nominee_id: winners.value[categoryId],
  };
  try {
    errors.value[categoryId] = null;
    const json = await request(`/winner/${year}`, 'post', body);
    console.log({ json });
    if (json.code === 'cheater') {
      errors.value[categoryId] = 'Please enter a secret code';
    }
    if (json.code === 'no_nominee_id') {
      errors.value[categoryId] = 'You must select a nominee ID';
    }
  } catch (e) {
    errors.value[categoryId] = e.message;
  }
}
</script>

<template>
  <h1>Declare winners!</h1>
  <label class="margin-bottom">
    Secret phrase
    <input type="text" name="secretPhrase" v-model="secretPhrase" />
  </label>

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
              v-model="winners[c.category_id]"
              :id="`${n.category_id}_${n.nominee_id}`"
              :checked="c.winning_nominee_id === n.nominee_id ? 'checked' : undefined"
            />
          </div>
          <div class="flex items-center max-width-80">
            <label :for="`${n.category_id}_${n.nominee_id}`">
              {{ n.nominee }}
              <strong class="block small">{{ n.artwork }}</strong>
            </label>
          </div>
        </div>
        <button type="submit">Declare winner</button>
        <div v-if="!!errors[c.category_id]" class="error">{{ errors[c.category_id] }}</div>
      </form>
    </template>
  </template>
</template>
