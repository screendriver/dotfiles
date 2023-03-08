local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

function _G.check_back_space()
	local col = vim.fn.col('.') - 1
	return col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') ~= nil
end

-- Use K to show documentation in preview window
function _G.show_docs()
	local cw = vim.fn.expand("<cword>")
	if vim.fn.index({ "vim", "help" }, vim.bo.filetype) >= 0 then
		vim.api.nvim_command("h " .. cw)
	elseif vim.api.nvim_eval("coc#rpc#ready()") then
		vim.fn.CocActionAsync("doHover")
	else
		vim.api.nvim_command("!" .. vim.o.keywordprg .. " " .. cw)
	end
end

require("lazy").setup({
	{
		"dracula/vim",
		lazy = false,
		priority = 1000,
		config = function()
			vim.cmd.colorscheme("dracula")
		end
	},
	{ "nvim-lua/plenary.nvim", lazy = true },
	{ "nvim-lua/popup.nvim",   lazy = true },
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		opts = {
			ensure_installed = {
				"html",
				"css",
				"javascript",
				"typescript",
				"tsx",
				"json",
				"gitignore",
				"markdown",
				"svelte",
				"astro",
				"help",
				"gitignore",
				"lua",
				"yaml",
				"nix",
				"bash",
				"dockerfile"
			},
			highlight = {
				enable = true,
				additional_vim_regex_highlighting = false,
			},
			indent = {
				enable = true
			},
			autotag = {
				enable = true,
			},
			matchup = {
				enable = true
			}
		},
		config = function(plugin, opts)
			require("nvim-treesitter.configs").setup(opts)
			require("treesitter-context").setup()
		end
	},
	{ "nvim-treesitter/nvim-treesitter-context", lazy = true },
	{ "nvim-tree/nvim-web-devicons",             lazy = true, config = true },
	{
		"nvim-lualine/lualine.nvim",
		dependencies = {
			"nvim-tree/nvim-web-devicons"
		},
		opts = {
			options = {
				theme = "dracula",
			},
			sections = {
				lualine_a = { "mode" },
				lualine_b = { "branch", "diff", "diagnostics" },
				lualine_c = { {
					"filename",
					path = 1
				} },
				lualine_x = { "filetype" },
				lualine_y = { "progress" },
				lualine_z = { "location" }
			},
		}
	},
	{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
	{
		"nvim-telescope/telescope.nvim",
		branch = "0.1.x",
		dependencies = { "nvim-lua/plenary.nvim" },
		keys = {
			{ "<leader>bf", "<cmd>Telescope file_browser path=%:p:h select_buffer=true<CR>",         desc = "[B]rowse [F]iles with path of current buffer", noremap = true },
			{ "<leader>bF", "<cmd>Telescope file_browser<CR>",                                       desc = "[B]rowse [F]iles",                             noremap = true },
			{ "<leader>ff", function() require("telescope.builtin").find_files() end,                desc = "[F]ind [F]iles" },
			{ "<leader>fg", function() require("telescope.builtin").live_grep() end,                 desc = "[F]ind by [G]rep" },
			{ "<leader>fb", function() require("telescope.builtin").buffers() end,                   desc = "[F]ind in [B]uffers" },
			{ "<leader>fh", function() require("telescope.builtin").help_tags() end,                 desc = "[F]ind [H]elp" },
			{ "<leader>fm", function() require("telescope.builtin").marks() end,                     desc = "[F]ind [M]arks" },
			{ "<leader>fk", function() require("telescope.builtin").keymaps() end,                   desc = "[F]ind [K]eymaps" },
			{ "<leader>/",  function() require("telescope.builtin").current_buffer_fuzzy_find() end, desc = "[/] Fuzzily search in current buffer" },
			{ "<leader>fc", "<cmd>Telescope neoclip<cr>",                                            desc = "[F]ind in [C]lipboard" },
		},
		opts = {
			defaults = {
				mappings = {
					i = {
						["<C-h>"] = "which_key"
					}
				}
			},
			pickers = {
				find_files = {
					find_command = { "fd", "--type", "file", "--hidden" }
				},
			},
			extensions = {
				file_browser = {
					grouped = true,
					hidden = true,
					sorting_strategy = "ascending",
					respect_gitignore = false,
					use_fd = true
				}
			},
		},
		config = function()
			local telescope = require("telescope")
			telescope.load_extension("fzf")
			telescope.load_extension("file_browser")
			telescope.load_extension("neoclip")
			telescope.load_extension("coc")
		end
	},
	{
		"nvim-telescope/telescope-file-browser.nvim",
		dependencies = {
			"nvim-telescope/telescope.nvim",
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons"
		},
	},
	{
		"AckslD/nvim-neoclip.lua",
		name = "neoclip",
		dependencies = { "nvim-telescope/telescope.nvim" },
		opts = {
			default_register = "+"
		}
	},
	"fannheyward/telescope-coc.nvim",
	{
		"neoclide/coc.nvim",
		branch = "release",
		event = { 'BufReadPre', 'BufNewFile' },
		config = function()
			vim.cmd [[
				let g:coc_global_extensions = ["coc-css", "coc-eslint", "coc-html", "coc-json", "coc-prettier", "coc-spell-checker", "coc-svelte", "@yaegassy/coc-tailwindcss3", "coc-tsserver", "coc-deno", "coc-fsharp", "coc-lightbulb", "coc-lua", "coc-yaml", "coc-marketplace"]
			]]
			-- Highlight the symbol and its references on a CursorHold event (cursor is idle)
			vim.api.nvim_create_augroup("CocGroup", {})
			vim.api.nvim_create_autocmd("CursorHold", {
				group = "CocGroup",
				command = "silent call CocActionAsync('highlight')",
				desc = "Highlight symbol under cursor on CursorHold"
			})
			-- Update signature help on jump placeholder
			vim.api.nvim_create_autocmd("User", {
				group = "CocGroup",
				pattern = "CocJumpPlaceholder",
				command = "call CocActionAsync('showSignatureHelp')",
				desc = "Update signature help on jump placeholder"
			})
			-- Add ":Format" command to format current buffer
			vim.api.nvim_create_user_command("Format", "call CocAction('format')", { desc = "Format current buffer" })
			-- Add ":OR" command for organize imports of the current buffer
			vim.api.nvim_create_user_command("OR", "call CocActionAsync('runCommand', 'editor.action.organizeImport')",
				{ desc = "Organize imports" })
		end,
		keys = {
			{ "<CR>",       [[coc#pum#visible() ? coc#pum#confirm() : "<CR>"]],                                         mode = "i",    expr = true,                                  desc = "Use <CR> to confirm completion" },
			{ "<C-Space>",  "coc#refresh()",                                                                            mode = "i",    silent = true,                                expr = true,                                                  desc = "Use <C-Space> to trigger completion" },
			{ "<TAB>",      'coc#pum#visible() ? coc#pum#next(1) : v:lua.check_back_space() ? "<TAB>" : coc#refresh()', mode = "i",    silent = true,                                noremap = true,                                               expr = true,                                 replace_keycodes = false, desc = "Use <S-Tab> to navigate the completion list" },
			{ "<S-TAB>",    [[coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"]],                                         mode = "i",    silent = true,                                noremap = true,                                               expr = true,                                 replace_keycodes = false, desc = "Use <S-Tab> to navigate the completion list" },
			-- Use `[g` and `]g` to navigate diagnostics
			-- Use `:CocDiagnostics` to get all diagnostics of current buffer in location list
			{ "[g",         "<Plug>(coc-diagnostic-prev)",                                                              silent = true },
			{ "]g",         "<Plug>(coc-diagnostic-next)",                                                              silent = true },
			-- GoTo code navigation
			{ "gd",         "<Plug>(coc-definition)",                                                                   silent = true, desc = "[G]o to [D]efinition" },
			{ "gy",         "<Plug>(coc-type-definition)",                                                              silent = true, desc = "[G]o to t[y]pe definition" },
			{ "gi",         "<Plug>(coc-implementation)",                                                               silent = true, desc = "[G]o to [i]mplementation" },
			{ "gr",         "<Plug>(coc-references)",                                                                   silent = true, desc = "[G]o to [R]eferences" },
			{ "K",          "<CMD>lua _G.show_docs()<CR>",                                                              silent = true, desc = "Show documentation in preview window" },
			-- Symbol renaming
			{ "<leader>rn", "<Plug>(coc-rename)",                                                                       silent = true, desc = "[R]e[n]ame symbol" },
			-- Apply code actions at the cursor position.
			{ "<leader>ac", "<Plug>(coc-codeaction-cursor)",                                                            silent = true, nowait = true,                                desc = "[A]pply [C]ode actions at the cursor position" },
			-- Apply the most preferred quickfix action on the current line.
			{ "<leader>qf", "<Plug>(coc-fix-current)",                                                                  silent = true, nowait = true,                                desc = "Apply most preffered [Q]uick[f]ix on the current lin" },
			-- Remap keys for apply refactor code actions.
			{ "<leader>re", "<Plug>(coc-codeaction-refactor)",                                                          silent = true, desc = "[Re]factor code" },
			{ "<leader>r",  "<Plug>(coc-codeaction-refactor-selected)",                                                 mode = "x",    silent = true,                                desc = "[R]efactor code" },
			{ "<leader>r",  "<Plug>(coc-codeaction-refactor-selected)",                                                 silent = true, desc = "[R]efactor code" },
			-- Run the Code Lens actions on the current line
			{ "<leader>cl", "<Plug>(coc-codelens-action)",                                                              silent = true, nowait = true,                                desc = "Run [C]ode [L]ens actions on current line" },
			-- Remap <C-f> and <C-b> to scroll float windows/popups
			{ "<C-f>",      'coc#float#has_scroll() ? coc#float#scroll(1) : "<C-f>"',                                   silent = true, nowait = true,                                expr = true },
			{ "<C-b>",      'coc#float#has_scroll() ? coc#float#scroll(0) : "<C-b>"',                                   silent = true, nowait = true,                                expr = true },
			{ "<C-f>",      'coc#float#has_scroll() ? "<c-r>=coc#float#scroll(1)<cr>" : "<Right>"',                     mode = "i",    silent = true,                                nowait = true,                                                expr = true },
			{ "<C-b>",      'coc#float#has_scroll() ? "<c-r>=coc#float#scroll(0)<cr>" : "<Left>"',                      mode = "i",    silent = true,                                nowait = true,                                                expr = true },
			{ "<C-f>",      'coc#float#has_scroll() ? coc#float#scroll(1) : "<C-f>"',                                   mode = "v",    silent = true,                                nowait = true,                                                expr = true },
			{ "<C-b>",      'coc#float#has_scroll() ? coc#float#scroll(0) : "<C-b>"',                                   mode = "v",    silent = true,                                nowait = true,                                                expr = true },
		}
	},
	{
		"chentoast/marks.nvim",
		config = true
	},
	{
		"terrortylor/nvim-comment",
		config = function()
			require("nvim_comment").setup({ comment_empty = false })
		end
	},
	{
		"folke/zen-mode.nvim",
		opts = {
			window = {
				options = {
					signcolumn = "no",
					number = true,
					relativenumber = true
				}
			},
			plugins = {
				kitty = {
					enabled = true,
					font = "+4"
				}
			}
		}
	},
	{
		"kdheepak/lazygit.nvim",
		keys = {
			{ "<leader>lg", ":LazyGit<CR>", silent = true, desc = "Open [L]azy[G]it" }
		}
	},
	{
		"lewis6991/gitsigns.nvim",
		config = true
	},
	{
		"luukvbaal/nnn.nvim",
		opts = {
			explorer = {
				cmd = "nnn -o"
			},
		},
		config = function()
			local nnn = require("nnn")

			nnn.setup({
				mappings = {
					{ "<C-t>", nnn.builtin.open_in_tab },
					{ "<C-s>", nnn.builtin.open_in_split },
					{ "<C-v>", nnn.builtin.open_in_vsplit },
					{ "<C-p>", nnn.builtin.open_in_preview },
					{ "<C-y>", nnn.builtin.copy_to_clipboard },
				}
			})
		end,
		keys = {
			{ "<leader>nn", "<cmd>NnnPicker<CR>",       silent = true,  noremap = true,                       desc = "Open [Nn]n" },
			{ "<leader>np", "<cmd>NnnPicker %:p:h<CR>", noremap = true, desc = "Open [N]nn in current [P]ath" }
		}
	},
	{
		"windwp/nvim-autopairs",
		lazy = false,
		opts = {
			check_ts = true,
			ts_config = {
				lua = { 'string' }, -- it will not add a pair on that treesitter node
				javascript = { 'template_string' },
				java = false, -- don't check treesitter on java
			},
			map_cr = false
		},
		keys = {
			{
				"<CR>",
				function()
					if vim.fn["coc#pum#visible"]() ~= 0 then
						return vim.fn["coc#pum#confirm"]()
					else
						return require("nvim-autopairs").autopairs_cr()
					end
				end,
				mode = "i",
				expr = true,
				noremap = true
			}
		}
	},
	"windwp/nvim-ts-autotag",
	{
		"NvChad/nvim-colorizer.lua",
		name = "colorizer",
		opts = {
			user_default_options = {
				mode = "virtualtext",
				tailwind = true
			}
		}
	},
	"knubie/vim-kitty-navigator",
	{
		"kylechui/nvim-surround",
		version = "*",
		config = true
	},
	{
		"ggandor/leap.nvim",
		event = { 'BufReadPre', 'BufNewFile' },
		config = function()
			local leap = require("leap")

			leap.add_default_mappings()
			leap.opts.highlight_unlabeled_phase_one_targets = true

			vim.api.nvim_set_hl(0, "LeapBackdrop", { link = "Comment" }) -- Greying out the search area
		end
	},
	{
		"ggandor/flit.nvim",
		dependencies = {
			"ggandor/leap.nvim"
		},
		lazy = true,
		opts = {
			labeled_modes = "nv"
		}
	},
	"tpope/vim-repeat",
	{
		"andymass/vim-matchup",
		config = function()
			vim.g.loaded_matchit = 1 -- Slightly start-up time improvement
			vim.g.matchup_matchparen_offscreen = { method = "popup" }
			vim.g.matchup_surround_enabled = 1
		end
	}
})
