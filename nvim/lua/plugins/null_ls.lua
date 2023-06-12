local function on_attach(_client, bufnr)
    vim.keymap.set("n", "gl", vim.diagnostic.setloclist, { noremap = true, silent = true, buffer = bufnr })

    vim.api.nvim_create_augroup("LspFormatting", { clear = true })
    vim.api.nvim_create_autocmd("BufWritePre", {
        pattern = "*",
        group = "LspFormatting",
        callback = function()
            vim.lsp.buf.format({
                timeout_ms = 2000,
                filter = function(clients)
                    return vim.tbl_filter(function(client)
                        return pcall(function(_client)
                            return _client.config.settings.autoFixOnSave or false
                        end, client) or false
                    end, clients)
                end,
            })
        end,
    })
end

local function setup()
    local null_ls = require("null-ls")
    local sources = {
        null_ls.builtins.formatting.reorder_python_imports,
        null_ls.builtins.formatting.black,
        null_ls.builtins.formatting.prettier.with({ disabled_filetypes = { "html", "yaml" } }),
        null_ls.builtins.formatting.djhtml,
        null_ls.builtins.diagnostics.selene.with({
            extra_args = { "--config", vim.fn.expand("$DOTFILES/selene.toml") },
        }),
        null_ls.builtins.formatting.stylua,
        null_ls.builtins.formatting.shfmt.with({ filetypes = { "sh", "zsh" } }),
        null_ls.builtins.formatting.terraform_fmt,
        null_ls.builtins.formatting.trim_newlines,
        null_ls.builtins.formatting.trim_whitespace,
        null_ls.builtins.diagnostics.flake8.with({
            command = vim.fn.expand("$HOME/.local/bin/flake8"),
            extra_args = { "--config", vim.fn.expand("$DOTFILES/python/flake8") },
        }),
        null_ls.builtins.diagnostics.mypy.with({
            command = vim.fn.expand("$HOME/.local/bin/mypy"),
            extra_args = { "--config-file", vim.fn.expand("$DOTFILES/python/mypy.ini") },
        }),
        null_ls.builtins.diagnostics.yamllint.with({
            extra_args = { "-c", vim.fn.expand("$DOTFILES/python/yamllint.yml") },
        }),
        null_ls.builtins.diagnostics.eslint_d,
        null_ls.builtins.diagnostics.shellcheck,
    }

    null_ls.setup({
        sources = sources,
        on_attach = on_attach,
        handlers = {
            ["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
                underline = false,
                virtual_text = false,
                signs = true,
                update_in_insert = false,
            }),
        },
    })
end

return {
    "nvimtools/none-ls.nvim",
    name = "null_ls",
    config = function()
        setup()
    end,
    lazy = true,
}
