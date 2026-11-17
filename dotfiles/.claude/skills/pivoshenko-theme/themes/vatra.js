import { makeColors } from './make-colors.js'

const { theme, problems } = makeColors({
  label: 'vatra',
  only: 'dark',
  roles: {
    accent: '#80a6d1',
    danger: '#f7716e',
    success: '#a6bc6a',
    warning: '#e2b54c',
    pro: '#b98dd2',
  },
  dark: {
    gray: {
      anchors: {
        'surface-0': '#1f1f1f',
        'surface-1': '#2a2928',
        'surface-2': '#353230',
        'surface-3': '#353230',
        'text-primary': '#f3e0ba',
        'text-secondary': '#d1bea0',
        'text-muted': '#aa9983',
      },
    },
    git: {
      added: '#a6bc6a',
      removed: '#f7716e',
      modified: '#e2b54c',
      merged: '#b98dd2',
      closed: '#f7716e',
      conflicting: '#f18c46',
      draft: '#7d7063',
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
