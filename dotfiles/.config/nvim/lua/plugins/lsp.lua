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
                on_attach = function(_, _)
                    vim.api.nvim_create_augroup("Format on save", { clear = false })
                    vim.api.nvim_create_autocmd("BufWritePre", {
                        callback = function()
                            vim.lsp.buf.format {
                                async = true,
                                filter = function(client)
                                    -- if client.supports_method "textDocument/formatting" then
                                    --   return client.name ~= "null-ls"
                                    -- end
                                    return client.name == "null-ls"
                                end,
                            }
                            vim.notify("Format Done", vim.log.levels.INFO, { title = "Format" })
                        end,
                        group = "Format on save",
                    })
                end,
            }
        end,
    },
}
