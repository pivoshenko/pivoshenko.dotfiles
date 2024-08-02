local settings = require("config.settings")

sbar.default(
  {
    updates = "when_shown",
    icon = {
      font = {
        family = settings.fonts.icon,
        style = settings.fonts.styles.bold,
        size = settings.dimens.text.icon
      },
      color = settings.colors.text,
      padding_left = settings.dimens.padding.icon,
      padding_right = settings.dimens.padding.icon
    },
    label = {
      font = {
        family = settings.fonts.text,
        style = settings.fonts.styles.bold,
        size = settings.dimens.text.label
      },
      color = settings.colors.text,
      padding_left = settings.dimens.padding.label,
      padding_right = settings.dimens.padding.label
    },
    background = {
      height = settings.dimens.graphics.background.height,
      corner_radius = settings.dimens.graphics.background.corner_radius,
      border_width = 0,
      image = {
        corner_radius = settings.dimens.graphics.background.corner_radius
      }
    },
    popup = {
      y_offset = settings.dimens.padding.popup,
      align = "center",
      background = {
        border_width = 0,
        corner_radius = settings.dimens.graphics.background.corner_radius,
        color = settings.colors.base,
        shadow = { drawing = true },
        padding_left = settings.dimens.padding.icon,
        padding_right = settings.dimens.padding.icon
      },
      blur_radius = settings.dimens.graphics.blur_radius
    },
    slider = {
      highlight_color = settings.colors.mauve,
      background = {
        height = settings.dimens.graphics.slider.height,
        corner_radius = settings.dimens.graphics.background.corner_radius,
        color = settings.colors.base,
        border_color = settings.colors.mantle,
        border_width = 2
      },
      knob = {
        font = {
          family = settings.fonts.icon,
          style = settings.fonts.styles.regular,
          size = 32
        },
        string = settings.icons.text.slider.knob,
        drawing = false
      }
    },
    scroll_texts = true
  }
)
