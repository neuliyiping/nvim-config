local function borders()
    -- Set up border for floating preview windows
    -- source: https://github.com/neovim/nvim-lspconfig/wiki/UI-customization
    local border = {
        { "╭", "FloatBorder" },
        { "─", "FloatBorder" },
        { "╮", "FloatBorder" },
        { "│", "FloatBorder" },
        { "╯", "FloatBorder" },
        { "─", "FloatBorder" },
        { "╰", "FloatBorder" },
        { "│", "FloatBorder" },
    }

    local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
    function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
        opts = opts or {}
        opts.border = opts.border or border
        return orig_util_open_floating_preview(contents, syntax, opts, ...)
    end
end

local function on_attach(client, bufnr)
    client.server_capabilities.documentFormattingProvider = false

    vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

    local opts = { noremap = true, silent = true, buffer = bufnr }
    local set_keymap = vim.keymap.set

    set_keymap("n", "gd", vim.lsp.buf.definition, opts)
    set_keymap("n", "gr", vim.lsp.buf.rename, opts)
    set_keymap("n", "gR", vim.lsp.buf.references, opts)
    set_keymap("n", "K", vim.lsp.buf.hover, opts)
end

local function disable_virtual_text()
    vim.diagnostic.config({ virtual_text = false })
end

local function setup_lsp(lsp_name)
    require("lspconfig")[lsp_name].setup({ on_attach = on_attach })
end

local function setup_all_servers(servers)
    for _, lsp in ipairs(servers) do
        setup_lsp(lsp)
    end
end

local function setup()
    disable_virtual_text()
    borders()
    setup_all_servers({
        "pylsp",
        "tsserver",
    })
end

return {
    "neovim/nvim-lspconfig",
    config = function()
        setup()
    end,
    dependencies = {
        "null_ls",
    },
    event = "BufRead",
}
