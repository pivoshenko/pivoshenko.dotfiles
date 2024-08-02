local padding <const> = {
  background = 8,
  icon = 8,
  label = 8,
  bar = 8,
  item = 8,
  popup = 8,
}

local graphics <const> = {
  bar = {
    height = 36,
    offset = 8,
  },
  background = {
    height = 24,
    corner_radius = 8,
  },
  slider = {
    height = 20,
  },
  popup = {
    width = 300,
    large_width = 300,
  },
  blur_radius = 30,
}

local text <const> = {
  icon = 16,
  label = 14,
}

return {
  padding = padding,
  graphics = graphics,
  text = text,
}
