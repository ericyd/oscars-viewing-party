<script setup>
// import { useRouter } from 'vue-router';

const roomId = defineModel();
// const router = useRouter();
function handleSubmit(e) {
  const path = roomId.value.replace(/[^a-zA-Z0-9]/g, '-');
  console.log('handleSubmit', path, e)
  // router.push(`/${path}`);
}
</script>

<template>
  <h1>Oscars Viewing Party!</h1>
  <form @submit.prevent="handleSubmit">
    <label class="margin-bottom">
      Join or create a room
      <input type="text" name="roomId" v-model="roomId" />
    </label>
    <button type="submit">Go!</button>
  </form>
  <br />
  <hr />
  <h2>Tips 'n tricks</h2>
  <ul>
    <li>Create a room to compare predictions with your friends</li>
    <li>Submit your Oscars predictions, and see how many you got right! Results will be updated live during the Oscars</li>
    <li>You can join multiple rooms, but its janky so you have to use Incognito or Private windows</li>
    <li>
      This app is <em><strong>extremely insecure</strong></em
      >. Please only enter information that you want publicly available.
    </li>
  </ul>
</template>
