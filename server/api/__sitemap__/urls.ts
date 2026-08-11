import { defineSitemapEventHandler } from '#imports'

export default defineSitemapEventHandler(async () => {
  return [
    { loc: '/', changefreq: 'weekly', priority: 1.0 },
    { loc: '/about', changefreq: 'monthly', priority: 0.8 },
    { loc: '/projects', changefreq: 'weekly', priority: 0.9 }
  ]
})
