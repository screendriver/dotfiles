-- LazyGit

vim.keymap.set("n", "<leader>lg", ":LazyGit<CR>", { silent = true })

-- gitsigns.nvim

require("gitsigns").setup()
