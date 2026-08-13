<script setup lang="ts">
const { data: page } = await useAsyncData('index', () => {
  return queryCollection('index').first()
})
if (!page.value) {
  throw createError({
    statusCode: 404,
    statusMessage: 'Page not found',
    fatal: true
  })
}

const { global, footer } = useAppConfig()
const config = useRuntimeConfig()
const siteUrl = config.public.siteUrl || 'https://shubham-more.me'

const title = page.value?.seo?.title || page.value?.title || 'Shubham More - Senior Software Engineer & System Architect'
const description = page.value?.seo?.description || page.value?.description || 'Personal website and portfolio of Shubham More, Senior Software Engineer & System Architect.'

useSeoMeta({
  title,
  ogTitle: title,
  description,
  ogDescription: description,
  ogUrl: `${siteUrl}/`,
  ogType: 'website',
  ogSiteName: 'Shubham More',
  ogLocale: 'en_US',
  twitterTitle: title,
  twitterDescription: description,
  twitterSite: '@_MoreShubham',
  twitterCreator: '@_MoreShubham',
  robots: 'index, follow',
  keywords: 'Shubham More, Software Engineer, System Architect, Golang, Node.js, Python, TypeScript, Nuxt.js, Next.js, PostgreSQL, MongoDB, AWS, Azure'
})

const socialUrls = (footer?.links || [])
  .map(link => link.to)
  .filter((url): url is string => Boolean(url) && !url.startsWith('mailto:'))

const irysGroupOrg = {
  '@type': 'Organization',
  'name': 'Irys Group',
  'url': 'https://irysgroup.com/'
}

const srAnalyticsOrg = {
  '@type': 'Organization',
  'name': 'SR Analytics',
  'url': 'https://sranalytics.io/'
}

const personImage = {
  '@type': 'ImageObject',
  'url': `${siteUrl}/images/shubham_headshot.webp`,
  'contentUrl': `${siteUrl}/images/shubham_headshot.webp`,
  'width': 1122,
  'height': 1402
}

useHead({
  link: [
    { rel: 'canonical', href: `${siteUrl}/` }
  ],
  script: [
    {
      type: 'application/ld+json',
      innerHTML: JSON.stringify({
        '@context': 'https://schema.org',
        '@graph': [
          {
            '@type': 'WebSite',
            '@id': `${siteUrl}/#website`,
            'url': siteUrl,
            'name': 'Shubham More',
            'description': description,
            'publisher': {
              '@type': 'Person',
              '@id': `${siteUrl}/#person`
            }
          },
          {
            '@type': 'Person',
            '@id': `${siteUrl}/#person`,
            'name': 'Shubham More',
            'url': siteUrl,
            'image': personImage,
            'email': global?.email,
            'jobTitle': 'Senior Software Engineer & System Architect',
            'sameAs': socialUrls,
            'worksFor': [irysGroupOrg, srAnalyticsOrg],
            'hasOccupation': [
              {
                '@type': 'Occupation',
                'name': 'Senior Software Engineer & System Architect',
                'worksFor': irysGroupOrg,
                'skills': 'Golang, Node.js, Nuxt.js, MongoDB, Express.js, AWS Cloud'
              },
              {
                '@type': 'Occupation',
                'name': 'Full Stack Developer',
                'worksFor': srAnalyticsOrg,
                'skills': 'Python, Node.js, Next.js, PostgreSQL, Azure Cloud'
              }
            ]
          }
        ]
      })
    }
  ]
})

defineOgImage('Portfolio', { title, description })
</script>

<template>
  <UPage v-if="page">
    <LandingHero :page="page" />
    <UPageSection
      :ui="{
        container: 'py-6! sm:py-8! flex flex-col gap-8 lg:grid lg:grid-cols-2 lg:gap-8'
      }"
    >
      <LandingAbout :page="page" />
      <LandingWorkExperience :page="page" />
    </UPageSection>
    <LandingTestimonials :page="page" />
    <LandingFAQ :page="page" />
  </UPage>
</template>
