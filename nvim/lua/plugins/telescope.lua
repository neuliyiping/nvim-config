local M = {}
local custom_actions = {}

local telescope = require("telescope")
local actions = require("telescope.actions")
local action_state = require("telescope.actions.state")
local previewers = require("telescope.previewers")
local Job = require("plenary.job")

local function disable_binary_preview(filepath, bufnr, opts)
    -- source: https://github.com/nvim-telescope/telescope.nvim/wiki/Configuration-Recipes#dont-preview-binaries
    filepath = vim.fn.expand(filepath)
    local function on_exit(j)
        local mime_type = vim.split(j:result()[1], "/")[1]
        if mime_type == "text" then
            previewers.buffer_previewer_maker(filepath, bufnr, opts)
        else
            vim.schedule(
                function()
                    vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, {"Binary file"})
                end
            )
        end
    end

    Job:new(
        {
            command = "file",
            args = {"--mime-type", "-b", filepath},
            on_exit = on_exit
        }
    ):sync()
end

function custom_actions.fzf_multi_select(prompt_bufnr)
    -- source: https://github.com/nvim-telescope/telescope.nvim/issues/1048
    local picker = action_state.get_current_picker(prompt_bufnr)
    local num_selections = table.getn(picker:get_multi_selection())

    if num_selections > 1 then
        local picker = action_state.get_current_picker(prompt_bufnr)
        for _, entry in ipairs(picker:get_multi_selection()) do
            vim.cmd(string.format("%s %s", ":e!", entry.value))
        end
        vim.cmd("stopinsert")
    else
        actions.file_edit(prompt_bufnr)
    end
end

function M.setup()
    telescope.load_extension("fzf")
    telescope.setup(
        {
            defaults = {
                mappings = {
                    i = {
                        ["<c-j>"] = actions.move_selection_next,
                        ["<c-k>"] = actions.move_selection_previous,
                        -- source: https://github.com/nvim-telescope/telescope.nvim/wiki/Configuration-Recipes#mapping-esc-to-quit-in-insert-mode
                        ["<esc>"] = actions.close,
                        ["<tab>"] = actions.toggle_selection + actions.move_selection_next,
                        ["<s-tab>"] = actions.toggle_selection + actions.move_selection_previous,
                        ["<cr>"] = custom_actions.fzf_multi_select
                    },
                    n = {
                        ["<esc>"] = actions.close,
                        ["<tab>"] = actions.toggle_selection + actions.move_selection_next,
                        ["<s-tab>"] = actions.toggle_selection + actions.move_selection_previous,
                        ["<cr>"] = custom_actions.fzf_multi_select
                    }
                },
                buffer_previewer_maker = disable_binary_preview,
                file_ignore_patterns = {"node_modules", ".git"},
                prompt_prefix = " ",
                use_less = false,
                sorting_strategy = "ascending",
                layout_config = {
                    height = 0.66,
                    width = 0.85
                }
            },
            extensions = {
                fzf = {
                    fuzzy = true,
                    override_generic_sorter = false,
                    override_file_sorter = true,
                    case_modes = "smart_case"
                }
            }
        }
    )
end

function M.project_files()
    local builtin = require("telescope.builtin")
    local opts = {}

    local ok = pcall(builtin.git_files, opts)

    if not ok then
        builtin.find_files(opts)
    end
end

return M
