<script setup>
import { request } from '@/api';
import { onMounted, ref } from 'vue';
import { RouterLink, useRoute } from 'vue-router';

const route = useRoute();
const { roomId } = route.params;
const { error } = route.query;
const people = defineModel({ default: [] });

onMounted(async () => {
  const json = await request(`/room/${roomId}`);
  console.log(json);
  people.value = json.people;
});

const name = ref(localStorage.getItem('oscars-viewing-party-name'));
const userId = ref(localStorage.getItem('oscars-viewing-party-userId'));
const nameInput = defineModel('nameInput')
const usernameInput = defineModel('usernameInput')

async function handleSubmit() {
  console.log('handling')
  const body = {
    name: nameInput.value,
    username: usernameInput.value
  };
  console.log(body, `/room/${roomId}/join`)
  const json = await request(`/room/${roomId}/join`, 'post', body);
  console.log(json)
  localStorage.setItem('oscars-viewing-party-userId', json.userId);
  userId.value = json.userId;
  localStorage.setItem('oscars-viewing-party-roomId', json.roomId);
  localStorage.setItem('oscars-viewing-party-name', json.name);
  name.value = json.name;
}
</script>

<template>
  <h1>
    Welcome to room {{ roomId }}<template v-if="name">, {{ name }}</template>
  </h1>
  <div class="margin-bottom">
    <p class="error" v-if="error">{{ error }}</p>
    <a href="/predictions/2024" class="button" v-if="userId">My Predictions</a>

    <form v-else @submit.prevent="handleSubmit">
      <label>
        Display name
        <input type="text" name="name" id="displayName" v-model="nameInput" />
      </label>
      <label class="margin-bottom">
        Username (use something identifiable to you)
        <input type="text" name="username" id="username" v-model="usernameInput" />
      </label>
      <button type="submit">Join room</button>
    </form>
  </div>

  <div>(click someone's name to see their predictions)</div>

  <ul class="people">
    <li v-for="person of people">
      <RouterLink :to="`/${roomId}/person/${person.id}`"
        >{{ person.name }}
        <br />
        <small>{{ person.total_predictions }} predictions, {{ person.correct }} ✅, {{ person.wrong }} ❌, {{ person.undecided }} ⭕️</small>
      </RouterLink>
    </li>
  </ul>
</template>

<style>
@media (min-width: 1024px) {
  .about {
    min-height: 100vh;
    display: flex;
    align-items: center;
  }
}
</style>
