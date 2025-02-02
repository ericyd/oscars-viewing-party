// https://vuejs.org/guide/scaling-up/ssr.html#rendering-an-app
// app.js (shared between server and client)
import { createSSRApp, h } from 'vue'
import Home from './pages/index/+Page.vue'

export function createApp() {
  const RootComponent = () => h('div', null, h(Home, {}))
  return createSSRApp(RootComponent)
  // return createSSRApp({
  //   data: () => ({ count: 1 }),
  //   template: `<button @click="count++">{{ count }}</button>`
  // })
}