local settings = require("config.settings")

sbar.add(
  "item",
  "apple",
  {
    icon = {
      string = settings.icons.text.apple,
      font = {
        family = settings.fonts.icon,
        style = settings.fonts.styles.bold,
        size = 20
      }
    },
    label = { drawing = false },
    click_script = "$CONFIG_DIR/bridge/menus/bin/menus -s 0"
  }
)
