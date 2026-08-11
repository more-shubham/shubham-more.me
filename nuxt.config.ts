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

  site: {
    url: 'https://shubham-more.me',
    name: 'Shubham More'
  },

  sitemap: {
    sources: [
      '/api/__sitemap__/urls'
    ]
  },

  robots: {
    userAgent: '*',
    allow: '/',
    sitemap: 'https://shubham-more.me/sitemap.xml'
  },

  devtools: {
    enabled: true
  },

  app: {
    head: {
      link: [
        {
          rel: 'canonical',
          href: 'https://shubham-more.me'
        }
      ]
    }
  },

  css: ['~/assets/css/main.css'],

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

  ogImage: {
    zeroRuntime: true
  },

  icon: {
    serverBundle: {
      collections: ['lucide', 'simple-icons']
    },
    clientBundle: {
      scan: true
    }
  }
})
