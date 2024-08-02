local catppuccin_latte <const> = {
  rosewater = 0xffdc8a78,
  flamingo = 0xffdd7878,
  pink = 0xffea76cb,
  mauve = 0xff8839ef,
  red = 0xffd20f39,
  maroon = 0xffe64553,
  peach = 0xfffe640b,
  yellow = 0xffdf8e1d,
  green = 0xff40a02b,
  teal = 0xff179299,
  sky = 0xff04a5e5,
  sapphire = 0xff209fb5,
  blue = 0xff1e66f5,
  lavender = 0xff7287fd,
  text = 0xff4c4f69,
  subtext1 = 0xff5c5f77,
  subtext0 = 0xff6c6f85,
  overlay2 = 0xff7c7f93,
  overlay1 = 0xff8c8fa1,
  overlay0 = 0xff9ca0b0,
  surface2 = 0xffacb0be,
  surface1 = 0xffbcc0cc,
  surface0 = 0xffccd0da,
  base = 0xffeff1f5,
  mantle = 0xffe6e9ef,
  crust = 0xffdce0e8,

  transparent = 0x00000000,

  with_alpha = function(color, alpha)
    if alpha > 1.0 or alpha < 0.0 then return color end
    return (color & 0x00ffffff) | (math.floor(alpha * 255.0) << 24)
  end,
}

local catppuccin_frappe <const> = {
  rosewater = 0xfff2d5cf,
  flamingo = 0xffeebebe,
  pink = 0xfff4b8e4,
  mauve = 0xffca9ee6,
  red = 0xffe78284,
  maroon = 0xffea999c,
  peach = 0xffef9f76,
  yellow = 0xffe5c890,
  green = 0xffa6d189,
  teal = 0xff81c8be,
  sky = 0xff99d1db,
  sapphire = 0xff85c1dc,
  blue = 0xff8caaee,
  lavender = 0xffbabbf1,
  text = 0xffc6d0f5,
  subtext1 = 0xffb5bfe2,
  subtext0 = 0xffa5adce,
  overlay2 = 0xff949cbb,
  overlay1 = 0xff838ba7,
  overlay0 = 0xff737994,
  surface2 = 0xff626880,
  surface1 = 0xff51576d,
  surface0 = 0xff414559,
  base = 0xff303446,
  mantle = 0xff292c3c,
  crust = 0xff232634,

  transparent = 0x00000000,

  with_alpha = function(color, alpha)
    if alpha > 1.0 or alpha < 0.0 then return color end
    return (color & 0x00ffffff) | (math.floor(alpha * 255.0) << 24)
  end,
}

local catppuccin_macchiato <const> = {
  rosewater = 0xfff4dbd6,
  flamingo = 0xfff0c6c6,
  pink = 0xfff5bde6,
  mauve = 0xffc6a0f6,
  red = 0xffed8796,
  maroon = 0xffee99a0,
  peach = 0xfff5a97f,
  yellow = 0xffeed49f,
  green = 0xffa6da95,
  teal = 0xff8bd5ca,
  sky = 0xff91d7e3,
  sapphire = 0xff7dc4e4,
  blue = 0xff8aadf4,
  lavender = 0xffb7bdf8,
  text = 0xffcad3f5,
  subtext1 = 0xffb8c0e0,
  subtext0 = 0xffa5adcb,
  overlay2 = 0xff939ab7,
  overlay1 = 0xff8087a2,
  overlay0 = 0xff6e738d,
  surface2 = 0xff5b6078,
  surface1 = 0xff494d64,
  surface0 = 0xff363a4f,
  base = 0xff24273a,
  mantle = 0xff1e2030,
  crust = 0xff181926,

  transparent = 0x00000000,

  with_alpha = function(color, alpha)
    if alpha > 1.0 or alpha < 0.0 then return color end
    return (color & 0x00ffffff) | (math.floor(alpha * 255.0) << 24)
  end,
}

local catppuccin_mocha <const> = {
  rosewater = 0xfff5e0dc,
  flamingo = 0xfff2cdcd,
  pink = 0xfff5c2e7,
  mauve = 0xffcba6f7,
  red = 0xfff38ba8,
  maroon = 0xffeba0ac,
  peach = 0xfffab387,
  yellow = 0xfff9e2af,
  green = 0xffa6e3a1,
  teal = 0xff94e2d5,
  sky = 0xff89dceb,
  sapphire = 0xff74c7ec,
  blue = 0xff89b4fa,
  lavender = 0xffb4befe,
  text = 0xffcdd6f4,
  subtext1 = 0xffbac2de,
  subtext0 = 0xffa6adc8,
  overlay2 = 0xff9399b2,
  overlay1 = 0xff7f849c,
  overlay0 = 0xff6c7086,
  surface2 = 0xff585b70,
  surface1 = 0xff45475a,
  surface0 = 0xff313244,
  base = 0xff1e1e2e,
  mantle = 0xff181825,
  crust = 0xff11111b,

  transparent = 0x00000000,

  with_alpha = function(color, alpha)
    if alpha > 1.0 or alpha < 0.0 then return color end
    return (color & 0x00ffffff) | (math.floor(alpha * 255.0) << 24)
  end,
}

local colors <const> = catppuccin_macchiato

return colors
