require("telescope").setup {
    defaults = {
        prompt_position = "top",
        sorting_strategy = "ascending",
        use_less = false,
        winblend = 10
    }
}

vim.api.nvim_set_keymap("n", "gfg", ":Telescope git_files<CR>", {noremap = True, silent = True})
vim.api.nvim_set_keymap("n", "gff", ":Telescope live_grep<CR>", {noremap = True, silent = True})
vim.api.nvim_set_keymap("n", "gfb", ":Telescope buffers<CR>", {noremap = True, silent = True})
vim.cmd [[ command! GBranch :Telescope git_branches]]
