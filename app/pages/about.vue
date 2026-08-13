<script setup lang="ts">
const { data: page } = await useAsyncData('about', () => {
  return queryCollection('about').first()
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

const title = page.value?.seo?.title || page.value?.title || 'About - Shubham More'
const description = page.value?.seo?.description || page.value?.description || 'Learn more about Shubham More, Senior Software Engineer & System Architect.'

useSeoMeta({
  title,
  ogTitle: title,
  description,
  ogDescription: description,
  ogUrl: `${siteUrl}/about`,
  ogType: 'profile',
  ogSiteName: 'Shubham More',
  ogLocale: 'en_US',
  twitterTitle: title,
  twitterDescription: description,
  twitterSite: '@_MoreShubham',
  twitterCreator: '@_MoreShubham',
  robots: 'index, follow',
  keywords: 'Shubham More, Senior Software Engineer, System Architect, Golang, Node.js, Python, TypeScript, Nuxt.js, Next.js, PostgreSQL, MongoDB, AWS, Azure'
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
    { rel: 'canonical', href: `${siteUrl}/about` }
  ],
  script: [
    {
      type: 'application/ld+json',
      innerHTML: JSON.stringify({
        '@context': 'https://schema.org',
        '@type': 'ProfilePage',
        'mainEntity': {
          '@type': 'Person',
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
      })
    }
  ]
})

defineOgImage('Portfolio', { title, description })
</script>

<template>
  <UPage v-if="page">
    <AppBreadcrumbs />

    <UPageHero
      :title="page.title"
      :description="page.description"
      orientation="horizontal"
      :ui="{
        container: 'lg:flex sm:flex-row items-center',
        title: 'mx-0! text-left',
        description: 'mx-0! text-left',
        links: 'justify-start'
      }"
    >
      <img
        :src="global.picture?.dark || global.picture?.light"
        :alt="global.picture?.alt || 'Shubham More Profile Picture'"
        class="sm:rotate-4 size-36 rounded-lg object-cover ring ring-default ring-offset-3 ring-offset-bg"
      >
    </UPageHero>
    <UPageSection
      :ui="{
        container: 'pt-0!'
      }"
    >
      <MDC
        :value="page.content"
        unwrap="p"
      />
      <div class="flex flex-row justify-center items-center py-10 -space-x-8">
        <PolaroidItem
          v-for="(image, index) in page.images"
          :key="index"
          :image="image"
          :index="index"
        />
      </div>
    </UPageSection>
  </UPage>
</template>
