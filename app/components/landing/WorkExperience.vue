<script setup lang="ts">
import type { IndexCollectionItem } from '@nuxt/content'

defineProps<{
  page: IndexCollectionItem
}>()
</script>

<template>
  <div class="flex flex-col">
    <h2 class="text-left text-xl sm:text-xl lg:text-2xl font-medium text-highlighted mb-3 sm:mb-2">
      {{ page.experience.title }}
    </h2>
    <div class="flex flex-col gap-3">
      <Motion
        v-for="(experience, index) in page.experience.items"
        :key="index"
        :initial="{ opacity: 0, transform: 'translateY(20px)' }"
        :while-in-view="{ opacity: 1, transform: 'translateY(0)' }"
        :transition="{ delay: 0.4 + 0.2 * index }"
        :in-view-options="{ once: true }"
        class="text-muted flex flex-col sm:flex-row sm:items-center gap-1.5 sm:gap-2"
        itemscope
        itemtype="https://schema.org/Occupation"
      >
        <div class="flex items-center gap-2 shrink-0">
          <span class="text-xs sm:text-sm text-neutral-400 dark:text-neutral-400 font-mono tracking-tight">
            {{ experience.date }}
          </span>
          <USeparator class="hidden sm:block flex-1 min-w-4" />
        </div>
        <ULink
          class="flex items-center flex-wrap gap-1 hover:opacity-80 transition-opacity text-sm"
          :to="experience.company.url"
          target="_blank"
          itemprop="worksFor"
          itemscope
          itemtype="https://schema.org/Organization"
        >
          <span itemprop="jobTitle">
            {{ experience.position }}
          </span>
          <div
            class="inline-flex items-center gap-1 font-medium"
            :style="{ color: experience.company.color }"
            itemprop="name"
          >
            <span>{{ experience.company.name }}</span>
            <UIcon
              :name="experience.company.logo"
              class="shrink-0 text-base"
            />
          </div>
        </ULink>
        <span
          v-if="experience.techStack && experience.techStack.length > 0"
          class="sr-only"
        >
          Technologies: {{ experience.techStack.join(', ') }}
        </span>
      </Motion>
    </div>
  </div>
</template>
