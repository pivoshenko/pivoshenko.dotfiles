local constants = require("constants")
local settings = require("config.settings")

sbar.exec("killall cpu_load >/dev/null; $CONFIG_DIR/bridge/cpu_load/bin/cpu_load cpu_update 2.0")

local cpu =
    sbar.add(
      "graph",
      constants.items.CPU,
      42,
      {
        position = "right",
        graph = { color = settings.colors.blue },
        background = {
          height = 22,
          color = { alpha = 0 },
          border_color = { alpha = 0 },
          drawing = true
        },
        icon = {
          string = settings.icons.text.cpu
        },
        label = {
          string = "cpu ??%",
          font = {
            family = settings.fonts.numbers,
            style = settings.fonts.styles.bold,
            size = 9.0
          },
          align = "right",
          padding_right = 0,
          width = 0,
          y_offset = 4
        },
        padding_right = settings.dimens.padding.icon + 6
      }
    )

cpu:subscribe(
  "cpu_update",
  function(env)
    local load = tonumber(env.total_load)
    cpu:push({ load / 100. })

    local color = settings.colors.blue
    if load > 30 then
      if load < 60 then
        color = settings.colors.yellow
      elseif load < 80 then
        color = settings.colors.peach
      else
        color = settings.colors.red
      end
    end

    cpu:set(
      {
        graph = { color = color },
        label = "cpu " .. env.total_load .. "%"
      }
    )
  end
)

cpu:subscribe(
  "mouse.clicked",
  function(env)
    sbar.exec("open -a 'Activity Monitor'")
  end
)

sbar.add(
  "bracket",
  constants.items.CPU .. ".bracket",
  { cpu.name },
  {
    background = {
      color = settings.colors.base
    }
  }
)

sbar.add(
  "item",
  constants.items.CPU .. ".padding",
  {
    position = "right",
    width = settings.dimens.padding.item
  }
)
