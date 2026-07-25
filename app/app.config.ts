export default defineAppConfig({
  global: {
    picture: {
      dark: '/shubham_headshot.png',
      light: '/shubham_headshot.png',
      alt: 'Shubham More Profile Picture'
    },
    meetingLink: 'https://shubham-more.me',
    email: 'hi@shubham-more.me',
    available: true
  },
  ui: {
    colors: {
      primary: 'emerald',
      neutral: 'slate'
    },
    pageHero: {
      slots: {
        container: 'py-18 sm:py-24 lg:py-32',
        title: 'mx-auto max-w-xl text-pretty text-3xl sm:text-4xl lg:text-5xl',
        description: 'mt-2 text-md mx-auto max-w-2xl text-pretty sm:text-md text-muted'
      }
    }
  },
  footer: {
    credits: `Built by Shubham More • © ${new Date().getFullYear()}`,
    colorMode: false,
    links: [{
      'icon': 'i-simple-icons-linkedin',
      'to': 'https://www.linkedin.com/in/shubhammore-dev/',
      'target': '_blank',
      'aria-label': 'Shubham More on LinkedIn'
    }, {
      'icon': 'i-simple-icons-github',
      'to': 'https://github.com/more-shubham',
      'target': '_blank',
      'aria-label': 'Shubham More on GitHub'
    }, {
      'icon': 'i-simple-icons-x',
      'to': 'https://x.com/_MoreShubham',
      'target': '_blank',
      'aria-label': 'Shubham More on X'
    }, {
      'icon': 'i-lucide-mail',
      'to': 'mailto:hi@shubham-more.me',
      'target': '_blank',
      'aria-label': 'Email Shubham More'
    }]
  }
})
