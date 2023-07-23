return {
    {
        "jose-elias-alvarez/null-ls.nvim",
        config = function()
            local null_ls = require "null-ls"
            -- need to import first
            null_ls.setup {
                sources = {
                    null_ls.builtins.formatting.lua_format,
                },
            }
        end,
    },
}
