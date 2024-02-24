<script setup>
import { request } from '@/api';
import { onMounted, ref } from 'vue';
import { useRoute } from 'vue-router';

const route = useRoute();
const { roomId, userId } = route.params;
const person = ref('');
const list = ref([]);

onMounted(async () => {
  const json = await request(`/room/${roomId}/person/${userId}`);
  console.log(json);
  list.value = json.predictions;
  person.value = json.user?.name ?? 'unknown';
});
</script>

<template>
  <h1>{{ person }}'s predictions</h1>

  (👑 = winner, ✅ = correct prediction, ❌ = wrong prediction, ⭕️ = predicted but no winner yet)

  <template v-for="item of list">
    <h2 class="meta-category">{{ item.meta_category }}</h2>
    <template v-for="c of item.categories">
      <h3>{{ c.category }}</h3>
      <div v-for="n of c.nominees" class="flex margin-bottom">
        <div class="width-2 flex items-center">
          <template v-if="n.winning_nominee_id">
            <template v-if="n.winning_nominee_id === n.nominee_id"> 👑 </template>
            <template v-if="n.winning_nominee_id === n.prediction_nominee_id"> ✅ </template>
            <tempalte v-else-if="n.prediction_nominee_id === n.nominee_id"> ❌ </tempalte>
          </template>
          <template v-else-if="n.prediction_nominee_id"> ⭕️ </template>
        </div>
        <div class="flex column max-width-80">
          {{ n.nominee }}
          <strong class="block small">{{ n.artwork }}</strong>
        </div>
      </div>
    </template>
  </template>
</template>
