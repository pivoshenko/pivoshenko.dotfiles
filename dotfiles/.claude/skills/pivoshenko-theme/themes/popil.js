import { makeColors } from './make-colors.js'

const { theme, problems } = makeColors({
  label: 'popil',
  only: 'dark',
  roles: {
    accent: '#8da7d1',
    danger: '#ec7470',
    success: '#91ab78',
    warning: '#d4aa5c',
    pro: '#ad8cc0',
  },
  dark: {
    gray: {
      anchors: {
        'surface-0': '#1f1f1e',
        'surface-1': '#292928',
        'surface-2': '#323231',
        'surface-3': '#323231',
        'text-primary': '#e4e2de',
        'text-secondary': '#b8b3a8',
        'text-muted': '#9b958a',
      },
    },
    git: {
      added: '#91ab78',
      removed: '#ec7470',
      modified: '#d4aa5c',
      merged: '#ad8cc0',
      closed: '#ec7470',
      conflicting: '#e48d66',
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
