local settings = require("config.settings")

sbar.bar(
  {
    topmost = "window",
    height = settings.dimens.graphics.bar.height,
    color = settings.colors.crust,
    padding_right = settings.dimens.padding.bar,
    padding_left = settings.dimens.padding.bar,
    margin = settings.dimens.padding.bar,
    corner_radius = settings.dimens.graphics.background.corner_radius,
    y_offset = settings.dimens.graphics.bar.offset,
    border_width = 0
  }
)
