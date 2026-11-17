import { makeColors } from './make-colors.js'

const { theme, problems } = makeColors({
  label: 'morok',
  only: 'dark',
  roles: {
    accent: '#8da1c7',
    danger: '#df7c7b',
    success: '#8aaf86',
    warning: '#d4b070',
    pro: '#aa89c2',
  },
  dark: {
    gray: {
      anchors: {
        'surface-0': '#111111',
        'surface-1': '#181818',
        'surface-2': '#212121',
        'surface-3': '#212121',
        'text-primary': '#e7e5e4',
        'text-secondary': '#d6d3d1',
        'text-muted': '#a8a29e',
      },
    },
    git: {
      added: '#8aaf86',
      removed: '#df7c7b',
      modified: '#d4b070',
      merged: '#aa89c2',
      closed: '#df7c7b',
      conflicting: '#d99a6a',
      draft: '#78716c',
    },
  },
})

export function register(on) {
  on('session.start', async ($, e, next) => {
    const unpainted = problems.find(line => line.startsWith("Desktop won't paint"))
    if (unpainted !== undefined) {
      $.ui.toast(unpainted)
    }

    await $.theme.set({ colors: theme })

    return next(e)
  })
}
