local constants = require("constants")
local settings = require("config.settings")

local ram =
    sbar.add(
      "item",
      constants.RAM,
      {
        position = "right",
        width = 0,
        padding_left = -5,
        icon = {
          padding_left = 0,
          padding_right = 0,
          font = {
            family = settings.fonts.icon,
            style = settings.fonts.styles.bold,
            size = 10
          },
          string = settings.icons.text.ramicons.ram
        },
        label = {
          font = {
            family = settings.fonts.text,
            style = settings.fonts.styles.bold,
            size = 10,
          },
          padding_left = 19,
          padding_right = 14,
          color = settings.colors.text,
          string = "??? %"
        },
        y_offset = 4,
        update_freq = 180
      }
    )

local swap =
    sbar.add(
      "item",
      constants.SWAP,
      {
        position = "right",
        padding_left = -5,
        icon = {
          padding_right = 0,
          padding_left = 0,
          font = {
            family = settings.fonts.icon,
            style = settings.fonts.styles.bold,
            size = 10
          },
          string = settings.icons.text.ramicons.swap
        },
        label = {
          font = {
            family = settings.fonts.text,
            style = settings.fonts.styles.bold,
            size = 10
          },
          color = settings.colors.text,
          string = "??.? Mb"
        },
        y_offset = -4,
        update_freq = 180
      }
    )

local swapram =
    sbar.add(
      "item",
      "widgets.ram.padding",
      {
        position = "right",
        label = { drawing = false }
      }
    )

local ram_bracket =
    sbar.add(
      "bracket",
      "widgets.ram.bracket",
      {
        swapram.name,
        ram.name,
        swap.name
      },
      {
        background = {
          color = settings.colors.base,
        }
      }
    )

sbar.add("item", { position = "right", width = settings.dimens.padding.item })

ram:subscribe(
  { "routine", "forced" },
  function(env)
    sbar.exec(
      "memory_pressure | grep -o 'System-wide memory free percentage: [0-9]*' | awk '{print $5}'",
      function(freeram)
        local usedram = 100 - tonumber(freeram)
        local Color = settings.colors.grey
        local label = tostring(usedram) .. " %"

        if usedram >= 80 then
          Color = settings.colors.red
          label = "KILL ME"
          Padding_left = 0
        elseif usedram >= 60 then
          Color = settings.colors.red
        elseif usedram >= 30 then
          Color = settings.colors.peach
        elseif usedram >= 20 then
          Color = settings.colors.yellow
        end

        ram:set(
          {
            label = {
              string = label,
              color = Color,
              padding_left = Padding_left
            },
            icon = {
              color = Color
            }
          }
        )
      end
    )
  end
)

swap:subscribe(
  { "routine", "forced" },
  function(env)
    sbar.exec(
      "sysctl -n vm.swapusage | awk '{print $6}' | sed 's/M//'",
      function(swapstore_untrimmed)
        if swapstore_untrimmed then
          local swapstore = swapstore_untrimmed:gsub("%s*$", "")
          swapstore = swapstore:gsub(",", ".")
          local swapuse = tonumber(swapstore)

          local function formatSwapUsage(swapuse)
            if swapuse < 1 then
              return "0.00 Mb", settings.colors.text
            elseif swapuse < 100 then
              return string.format("•%03d Mb ", swapuse), settings.colors.subtext0
            elseif swapuse < 1000 then
              return string.format("•%03d Mb ", swapuse), settings.colors.yellow
            elseif swapuse < 2000 then
              return string.format("%.2f Gb", swapuse / 1000), settings.colors.peach
            elseif swapuse < 10000 then
              return string.format("%.2f Gb", swapuse / 1000), settings.colors.red
            else
              return string.format("%.1f Gb", swapuse / 1000), settings.colors.red
            end
          end

          local swapLabel, swapColor = formatSwapUsage(swapuse)
          swap:set(
            {
              label = {
                string = swapLabel,
                color = swapColor
              },
              icon = {
                color = swapColor
              }
            }
          )
        end
      end
    )
  end
)
