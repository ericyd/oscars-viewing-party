import { fileURLToPath, URL } from 'node:url';

import { defineConfig } from 'vite';
import vue from '@vitejs/plugin-vue';
import vike from 'vike/plugin'

// https://vitejs.dev/config/
export default defineConfig({
  plugins: [vue(), 
    vike({ prerender: true })
  ],
  resolve: {
    alias: {
      '@': fileURLToPath(new URL('./src', import.meta.url)),
    },
  },
});
