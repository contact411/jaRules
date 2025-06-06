import { defineConfig } from 'astro/config';
import tailwind from '@astrojs/tailwind';
import react from '@astrojs/react';
import mdx from '@astrojs/mdx';
import sitemap from '@astrojs/sitemap';
import cloudflare from '@astrojs/cloudflare';

// https://astro.build/config
export default defineConfig({
  site: 'https://jarule.dev',
  integrations: [
    tailwind({
      applyBaseStyles: false,
    }),
    react(),
    mdx(),
    sitemap(),
  ],
  adapter: cloudflare({
    imageService: 'cloudflare',
    platformProxy: {
      enabled: true,
    },
  }),
  output: 'hybrid',
  vite: {
    define: {
      __DATE__: `'${new Date().toISOString()}'`,
    },
  },
  markdown: {
    shikiConfig: {
      theme: 'catppuccin-mocha',
    },
  },
  experimental: {
    contentCollectionCache: true,
  },
});