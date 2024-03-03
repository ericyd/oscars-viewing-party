import { createRouter, createWebHistory } from 'vue-router';
import HomeView from '../views/HomeView.vue';

const router = createRouter({
  history: createWebHistory(import.meta.env.BASE_URL),
  routes: [
    {
      path: '/',
      name: 'home',
      component: HomeView,
    },
    {
      path: '/admin/:year',
      name: 'admin',
      // route level code-splitting
      // this generates a separate chunk (Room.[hash].js) for this route
      // which is lazy-loaded when the route is visited.
      component: () => import('../views/AdminView.vue'),
    },
    {
      path: '/:roomId',
      name: 'room',
      component: () => import('../views/RoomView.vue'),
    },
    {
      path: '/:roomId/person/:userId',
      name: 'person',
      component: () => import('../views/PersonView.vue'),
    },
    {
      path: '/predictions/:year',
      name: 'predictions',
      component: () => import('../views/PredictionView.vue'),
    },
  ],
});

export default router;
