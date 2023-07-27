return {
    { "lvimuser/lsp-inlayhints.nvim" },
    {
        "jose-elias-alvarez/null-ls.nvim",
        config = function()
            local null_ls = require "null-ls"
            -- need to import first
            null_ls.setup {
                sources = {
                    null_ls.builtins.formatting.lua_format,
                    null_ls.builtins.formatting.black,
                    null_ls.builtins.formatting.isort,
                    null_ls.builtins.formatting.sqlfluff,
                    null_ls.builtins.code_actions.eslint,
                    null_ls.builtins.code_actions.gitsigns,
                    null_ls.builtins.code_actions.shellcheck,
                    null_ls.builtins.completion.tags,
                    null_ls.builtins.diagnostics.actionlint,
                    null_ls.builtins.diagnostics.ansiblelint,
                    null_ls.builtins.diagnostics.checkmake,
                    null_ls.builtins.diagnostics.codespell,
                    null_ls.builtins.diagnostics.commitlint,
                    null_ls.builtins.diagnostics.djlint,
                    null_ls.builtins.diagnostics.dotenv_linter,
                    null_ls.builtins.diagnostics.editorconfig_checker,
                    null_ls.builtins.diagnostics.mypy,
                    null_ls.builtins.diagnostics.rstcheck,
                    null_ls.builtins.diagnostics.ruff,
                    null_ls.builtins.diagnostics.sqlfluff,
                    null_ls.builtins.diagnostics.todo_comments,
                    null_ls.builtins.diagnostics.hadolint,
                },
            }
        end,
    },
}
