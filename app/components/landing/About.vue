<script setup lang="ts">
import type { IndexCollectionItem } from '@nuxt/content'

defineProps<{
  page: IndexCollectionItem
}>()
</script>

<template>
  <div class="flex flex-col">
    <h2 class="text-left text-xl sm:text-xl lg:text-2xl font-medium text-highlighted">
      {{ page.about.title }}
    </h2>
    <p class="text-left mt-3 text-sm sm:text-base lg:text-sm text-muted leading-relaxed">
      {{ page.about.description }}
    </p>
  </div>
</template>

<style scoped>

</style>
