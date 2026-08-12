// https://nuxt.com/docs/api/configuration/nuxt-config
export default defineNuxtConfig({
  modules: [
    '@nuxt/eslint',
    '@nuxt/image',
    '@nuxt/ui',
    '@nuxt/content',
    '@vueuse/nuxt',
    'nuxt-og-image',
    'motion-v/nuxt',
    '@nuxtjs/sitemap',
    '@nuxtjs/robots'
  ],

  devtools: {
    enabled: true
  },

  app: {
    head: {
      link: []
    }
  },

  css: ['~/assets/css/main.css'],

  site: {
    url: 'https://shubham-more.me',
    name: 'Shubham More'
  },

  content: {
    experimental: {
      sqliteConnector: 'native'
    }
  },

  runtimeConfig: {
    public: {
      siteUrl: 'https://shubham-more.me',
      siteName: 'Shubham More'
    }
  },

  compatibilityDate: '2026-06-30',

  nitro: {
    prerender: {
      routes: [
        '/',
        '/about',
        '/projects'
      ],
      crawlLinks: true
    },
    static: true
  },

  eslint: {
    config: {
      stylistic: {
        commaDangle: 'never',
        braceStyle: '1tbs'
      }
    }
  },

  icon: {
    serverBundle: {
      collections: ['lucide', 'simple-icons']
    },
    clientBundle: {
      scan: true
    }
  },

  ogImage: {
    zeroRuntime: true
  },

  robots: {
    sitemap: ['https://shubham-more.me/sitemap.xml']
  },

  sitemap: {
    sources: [
      '/api/__sitemap__/urls'
    ]
  }
})
