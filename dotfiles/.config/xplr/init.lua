version = "0.21.2"

local home = os.getenv("HOME")
local xpm_path = home .. "/.local/share/xplr/dtomvan/xpm.xplr"
local xpm_url = "https://github.com/dtomvan/xpm.xplr"

package.path = package.path .. ";" .. xpm_path .. "/?.lua;" .. xpm_path .. "/?/init.lua"
os.execute(string.format("[ -e '%s' ] || git clone '%s' '%s'", xpm_path, xpm_url, xpm_path))

package.path = home
    .. "/.config/xplr/plugins/?/init.lua;"
    .. home
    .. "/.config/xplr/plugins/?.lua;"
    .. package.path


require("xpm").setup(
  {
    auto_install = true,
    auto_cleanup = true,
    plugins = {
      "dtomvan/xpm.xplr",
      -- icons
      "prncss-xyz/icons.xplr",
      "gitlab:hartan/web-devicons.xplr",
      {
        'dtomvan/extra-icons.xplr',
        after = function()
          xplr.config.general.table.row.cols[2] = { format = "custom.icons_dtomvan_col_1" }
        end
      },
      -- fzf
      {
        name = "sayanarijit/fzf.xplr",
        setup = function()
          require("fzf").setup({
            mode = "default",
            key = "ctrl-f",
            bin = "fzf",
            args = "--preview 'bat -n --color=always {}'",
            recursive = true,  -- if true, search all files under $PWD
            enter_dir = false, -- enter if the result is directory
          })
        end,
      },
      -- command mode
      {
        name = "sayanarijit/command-mode.xplr",
        setup = function()
          local m = require("command-mode")
          m.setup()
          local help = m.silent_cmd("help", "show global help menu")(
            m.BashExec([[glow --pager $XPLR_PIPE_GLOBAL_HELP_MENU_OUT]])
          )
          local doc =
              m.silent_cmd("doc", "show docs")(m.BashExec([[glow /usr/share/doc/xplr]]))
          -- map `?` to command `help`
          help.bind("default", "?")
          -- map `ctrl-?` to command `help`
          doc.bind("default", "ctrl-?")
        end,
      },
      -- previewer
      {
        name = "Junker/nuke.xplr",
        setup = function()
          require("nuke").setup({})
          local key = xplr.config.modes.builtin.default.key_bindings.on_key
          key.v = {
            help = "nuke",
            messages = { "PopMode", { SwitchModeCustom = "nuke" } },
          }
        end,
      },
      -- dual pane mode
      "sayanarijit/dual-pane.xplr",
      -- selection storage
      "sayanarijit/registers.xplr",
      -- docs
      "sayanarijit/offline-docs.xplr",
      -- ranger UI
      {
        name = "sayanarijit/tri-pane.xplr",
        setup = function()
          require("tri-pane").setup({ as_default_layout = false })
        end,
      },
      -- zoxide integration for xplr
      "sayanarijit/zoxide.xplr",
      -- use this plugin to paste your files to paste.rs, and open/delete them later in fzf.
      {
        name = "dtomvan/paste-rs.xplr",
        setup = function()
          require("paste-rs").setup({
            db_path = home .. "/" .. "paste.rs.list",
          })
        end,
      },
      -- qrcp integration for xplr
      "sayanarijit/qrcp.xplr",
    },
  }
)

xplr.config.general.show_hidden = true
