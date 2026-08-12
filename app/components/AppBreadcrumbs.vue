<script setup lang="ts">
const route = useRoute()
const config = useRuntimeConfig()
const siteUrl = config.public.siteUrl || 'https://shubham-more.me'

interface BreadcrumbPropItem {
  label: string
  to?: string
  icon?: string
}

const props = defineProps<{
  items?: BreadcrumbPropItem[]
}>()

const computedItems = computed<BreadcrumbPropItem[]>(() => {
  if (props.items && props.items.length > 0) {
    return props.items
  }

  const list: BreadcrumbPropItem[] = [
    { label: 'Home', to: '/', icon: 'i-lucide-house' }
  ]

  const pathSegments = route.path.split('/').filter(Boolean)
  let accumulatedPath = ''

  for (const segment of pathSegments) {
    accumulatedPath += `/${segment}`
    const label = segment.charAt(0).toUpperCase() + segment.slice(1).replace(/-/g, ' ')
    list.push({
      label,
      to: accumulatedPath
    })
  }

  return list
})

useHead({
  script: [
    {
      type: 'application/ld+json',
      innerHTML: computed(() => JSON.stringify({
        '@context': 'https://schema.org',
        '@type': 'BreadcrumbList',
        'itemListElement': computedItems.value.map((item, index) => ({
          '@type': 'ListItem',
          'position': index + 1,
          'name': item.label,
          'item': siteUrl + (item.to || '')
        }))
      }))
    }
  ]
})
</script>

<template>
  <nav
    v-if="computedItems.length > 1"
    aria-label="Breadcrumb"
    class="sr-only"
  >
    <UBreadcrumb :items="computedItems" />
  </nav>
</template>
