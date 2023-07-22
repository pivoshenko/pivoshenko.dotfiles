version = '0.20.1'

local home = os.getenv("HOME")
local xpm_path = home .. "/.local/share/xplr/dtomvan/xpm.xplr"
local xpm_url = "https://github.com/dtomvan/xpm.xplr"

package.path = package.path .. ";" .. xpm_path .. "/?.lua;" .. xpm_path .. "/?/init.lua"

os.execute(string.format("[ -e '%s' ] || git clone '%s' '%s'", xpm_path, xpm_url, xpm_path))

require("xpm").setup({ 'dtomvan/xpm.xplr' })

require('xpm').setup { 'dtomvan/xpm.xplr', {
    'dtomvan/extra-icons.xplr',
    after = function()
        xplr.config.general.table.row.cols[2] = {
            format = "custom.icons_dtomvan_col_1"
        }
    end
} }

require('xpm').setup { 'dtomvan/xpm.xplr', {
    'prncss-xyz/icons.xplr',
    after = function()
        xplr.config.general.table.row.cols[2] = {
            format = "custom.icons_dtomvan_col_1"
        }
    end
} }
