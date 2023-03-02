-- LazyGit

vim.keymap.set("n", "<leader>lg", ":LazyGit<CR>", { silent = true, desc = "Open [L]azy[G]it" })

-- gitsigns.nvim

require("gitsigns").setup()
