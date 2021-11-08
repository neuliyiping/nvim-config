-- Packer.nvim Plugins
require("packer").startup(function(use)
    -- Let Packer manage itself
    use("wbthomason/packer.nvim")

    -- Dependencies
    use({
        "lewis6991/impatient.nvim",
        config = function()
            require("impatient")
        end,
    })

    -- Dependencies
    use("nvim-lua/plenary.nvim")
    use("kyazdani42/nvim-web-devicons")
    use("tami5/sqlite.lua")

    -- Reload config
    use({ "famiu/nvim-reload", cmd = "Reload" })

    -- Mappings made easy
    use("LionC/nest.nvim")

    -- Colorscheme
    use("folke/tokyonight.nvim")

    vim.g.tokyonight_style = "storm"
    vim.g.theme = "tokyonight"

    -- Make nvim prettier
    use({
        "nvim-lualine/lualine.nvim",
        config = function()
            require("plugins.statusline").setup()
        end,
    })

    use({
        "goolord/alpha-nvim",
        config = function()
            require("plugins.alpha").setup()
        end,
    })

    use({
        "danilamihailov/beacon.nvim",
        config = function()
            vim.g.beacon_ignore_filetypes = { "alpha", "NvimTree", "packer", "Trouble", "qf" }
        end,
        event = { "BufEnter" },
    })

    use("yamatsum/nvim-cursorline")

    use({
        "lukas-reineke/indent-blankline.nvim",
        config = function()
            require("indent_blankline").setup({
                use_treesitter = true,
                filetype_exclude = { "alpha", "help", "packer" },
            })
        end,
    })

    use({
        "kyazdani42/nvim-tree.lua",
        config = function()
            require("plugins.tree").setup()
        end,
        cmd = { "NvimTreeToggle", "NvimTreeFindFile" },
    })

    -- Language Parser
    use({
        "nvim-treesitter/nvim-treesitter",
        run = ":TSUpdate",
        requires = {
            { "nvim-treesitter/nvim-treesitter-textobjects", event = { "BufEnter" } },
            { "windwp/nvim-ts-autotag", event = "BufEnter" },
            { "p00f/nvim-ts-rainbow", event = "BufEnter" },
        },
        config = function()
            require("plugins.treesitter").setup()
        end,
        event = { "BufEnter" },
    })

    -- LSP
    use({
        "neovim/nvim-lspconfig",
        config = function()
            require("plugins.lsp").setup_lsp()
        end,
        requires = {
            "ray-x/lsp_signature.nvim",
            "tami5/lspsaga.nvim",
            "onsails/lspkind-nvim",
            "jose-elias-alvarez/null-ls.nvim",
        },
    })

    use({
        "hrsh7th/nvim-cmp",
        requires = {
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            { "andersevenrud/compe-tmux", branch = "cmp" },
            "hrsh7th/cmp-nvim-lua",
            "ray-x/cmp-treesitter",
            "hrsh7th/cmp-emoji",
            "f3fora/cmp-spell",
            "kdheepak/cmp-latex-symbols",
            "L3MON4D3/LuaSnip",
            "saadparwaiz1/cmp_luasnip",
        },
        config = function()
            require("plugins.cmp").setup()
        end,
    })

    use({
        "folke/trouble.nvim",
        config = function()
            require("trouble").setup()
        end,
        cmd = { "Trouble", "TroubleToggle" },
    })

    use("kevinhwang91/nvim-bqf")

    -- Testing
    use({
        "vim-test/vim-test",
        config = function()
            require("plugins.test").setup()
        end,
        cmd = { "TestFile", "TestNearest" },
    })

    -- Fuzzy finding
    use({
        "nvim-telescope/telescope.nvim",
        config = function()
            require("plugins.telescope").setup()
        end,
        key = { "<leader>f", "<leader>s", "<leader>l", "<leader>gb", "<leader>gc", "\"", { i = "<c-r>" } },
    })

    use({
        "nvim-telescope/telescope-fzf-native.nvim",
        run = "make",
    })

    use("nvim-telescope/telescope-frecency.nvim")

    -- Git Stuff
    use({
        "TimUntersberger/neogit",
        cmd = "Neogit",
        config = function()
            require("plugins.neogit").setup()
        end,
    })

    use({
        "sindrets/diffview.nvim",
        config = function()
            require("diffview.config").setup()
        end,
        cmd = { "DiffviewOpen", "DiffviewFileHistory" },
    })

    use({
        "lewis6991/gitsigns.nvim",
        config = function()
            require("plugins.gitsigns").setup()
        end,
        event = { "BufEnter" },
    })

    use({
        "pwntester/octo.nvim",
        config = function()
            require("octo").setup()
        end,
        cmd = { "Octo" },
    })
    --- Other misc plugins
    use({
        "numToStr/Comment.nvim",
        config = function()
            require("Comment").setup({ ignore = "^$" })
        end,
        keys = { "gcc", { "v", "gc" } },
    })

    use({
        "norcalli/nvim-colorizer.lua",
        config = function()
            require("colorizer").setup()
        end,
    })

    use("chaoren/vim-wordmotion")

    use({
        "christianrondeau/vim-base64",
        keys = { "<leader>atob", "<leader>btoa" },
    })

    use({
        "christoomey/vim-sort-motion",
        config = function()
            vim.g.sort_motion_flags = "ui"
        end,
        keys = { "gs" },
    })

    use({
        "gregsexton/MatchTag",
        ft = { "html" },
    })

    use({
        "tpope/vim-abolish",
        keys = { "crm", "crc", "crs", "cru", "cr-", "cr.", "cr<space>", "crt" },
    })

    use({ "tpope/vim-eunuch", cmd = { "Rename", "Remove" } })

    use({ "tpope/vim-repeat", key = { "." } })

    use("tpope/vim-surround")

    use("tpope/vim-unimpaired")

    use({
        "alvan/vim-closetag",
        config = function()
            vim.g.closetag_filetypes = "html,xhtml,phtml,vue,javascript"
            vim.g.closetag_shortcut = ">"
            vim.g.closetag_close_shortcut = "<leader>>"
        end,
        ft = { "html" },
    })

    use({
        "steelsojka/pears.nvim",
        config = function()
            require("pears").setup()
        end,
    })

    use({
        "Pocco81/TrueZen.nvim",
        config = function()
            require("true-zen").setup({
                modes = {
                    ataraxis = {
                        quit = "close",
                    },
                },
                integrations = {
                    gitsigns = true,
                    tmux = true,
                },
                misc = {
                    on_off_commands = true,
                },
            })
        end,
        cmd = { "TZAtaraxis" },
    })

    use({
        "folke/twilight.nvim",
        config = function()
            require("twilight").setup()
        end,
        cmd = "Twilight",
    })

    use({
        "caenrique/swap-buffers.nvim",
        config = function()
            require("swap-buffers").setup()
        end,
    })

    -- Language specific plugins
    use({
        "chr4/nginx.vim",
        ft = { "nginx" },
    })

    use({
        "mattn/emmet-vim",
        ft = { "html", "css", "scss" },
        keys = { "<c-y>," },
    })

    use({
        "ekalinin/Dockerfile.vim",
        ft = { "Dockerfile" },
    })

    use({
        "Glench/Vim-Jinja2-Syntax",
        ft = { "html", "j2" },
    })

    use({
        "iamcco/markdown-preview.nvim",
        ft = { "markdown" },
        run = "cd app && yarn install",
    })

    use({
        "petobens/poet-v",
        ft = { "python" },
        config = function()
            vim.g.poetv_executables = { "poetry" }
            vim.g.poetv_statusline_symbol = ""
            vim.g.poetv_set_environment = 1
            vim.g.poetv_auto_activate = 1
        end,
    })

    -- Tmux stuff
    use({
        "benmills/vimux",
        config = function()
            require("plugins.vimux").setup()
        end,
    })

    use({
        "christoomey/vim-tmux-navigator",
        config = function()
            vim.g.tmux_navigator_save_on_switch = 1
            vim.g.tmux_navigator_disable_when_zoomed = 1
            vim.g.tmux_navigator_no_mappings = 1
        end,
    })

    use("tmux-plugins/vim-tmux-focus-events")
end)
