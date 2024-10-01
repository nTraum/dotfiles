-- lazy.nvim setup
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
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

-- Enable mouse mode, can be useful for resizing splits for example!
vim.opt.mouse = "a"

-- Enable break indent
vim.opt.breakindent = true

-- Don't show the mode, since it's already in the status line
vim.opt.showmode = false

-- Show line numbers
vim.opt.number = true

-- Search case-insensitively, except when term contains upper case chars
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Live show substituations in buffer
vim.opt.incsearch = true
--
-- Set highlight on search, but clear on pressing <Esc> in normal mode
vim.opt.hlsearch = true
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- command-line completion
vim.opt.wildmenu = true
-- Wildcard characters
vim.opt.wildmode = "longest:full,full"
-- Display the completion matches using the popup menu
vim.opt.wildoptions = "pum"

vim.opt.pumblend = 15

-- Persistent undo even when editor closes
vim.opt.undofile = true
vim.opt.undodir = vim.fn.stdpath("data") .. "/undodir"

-- TAB is 2 spaces
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
-- Expand tabs to spaces
vim.opt.expandtab = true

-- Scroll margin
vim.opt.scrolloff = 10

-- Leader key is SPACE
vim.g.mapleader = " "

vim.opt.termguicolors = true

-- Keep signcolumn on by default
vim.wo.signcolumn = "yes"

-- Use system clipboard
vim.opt.clipboard = "unnamedplus"

-- Highlight current line
vim.opt.cursorline = true

-- Set gruvbox theme
vim.o.background = "dark"

vim.opt.completeopt = "menu,menuone,noinsert"

-- Limit number of completion window
vim.opt.pumheight = 10

vim.opt.splitright = true
vim.opt.splitbelow = true

require("lazy").setup({
	{
		-- Auto format on save
		"stevearc/conform.nvim",
		opts = {
			format_on_save = { timeout_ms = 500, lsp_fallback = true },
			formatters = {
				stylua = {
					command = "/home/ntraum/bin/stylua",
				},
			},
			formatters_by_ft = { lua = { "stylua" }, javascript = { "prettier" } },
		},
	},

	-- Snippets, somehow required for nvim-cmp?
	{ "L3MON4D3/LuaSnip", version = "v2.*" },
	{ "saadparwaiz1/cmp_luasnip" },
	-- Completion via LSP
	{ "hrsh7th/cmp-nvim-lsp" },
	-- Buffer conten completion
	{ "hrsh7th/cmp-buffer" },
	-- Path completion
	{ "hrsh7th/cmp-path" },
	-- Commandline completion
	{ "hrsh7th/cmp-cmdline" },
	-- Completions
	{
		"hrsh7th/nvim-cmp",
	},
	-- Gruvbox Theme
	-- Bold is just too much, disabled
	{ "ellisonleao/gruvbox.nvim", priority = 1000, opts = { bold = false } },
	-- Easily install and manage LSP servers
	{
		"williamboman/mason.nvim",
		config = true,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		opts = { ensure_installed = { "lua_ls" } },
	},
	{
		"neovim/nvim-lspconfig",
	},
	-- Shows which keys to press olol
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		init = function()
			vim.o.timeout = true
			vim.o.timeoutlen = 1000
		end,
	},
	-- Fuzzy finder over lists
	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.6",
		dependencies = { "nvim-lua/plenary.nvim" },
		opts = {
			defaults = {
				layout_config = {
					horizontal = {
						preview_cutoff = 20,
					},
				},
			},
		},
	},
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",

		config = function()
			local configs = require("nvim-treesitter.configs")

			configs.setup({
				ensure_installed = { "lua", "vim", "vimdoc", "query", "elixir", "heex", "javascript", "html" },
				sync_install = false,
				highlight = { enable = true },
				indent = { enable = true },
			})
		end,
	},
	{
		"nvim-treesitter/nvim-treesitter-textobjects",
		config = function()
			require("nvim-treesitter.configs").setup({
				textobjects = {
					select = {
						enable = true,
						lookahead = true,
						keymaps = {
							["af"] = "@function.outer",
							["if"] = "@function.inner",
							["ia"] = "@parameter.inner",
							["aa"] = "@parameter.outer",
						},
					},
				},
			})
		end,
	},
	-- Status line
	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		opts = {
			theme = "gruvbox",
			sections = {
				lualine_c = {
					{ "filename", path = 1 },
					function()
						return require("lsp-progress").progress()
					end,
				},
			},
		},
	},
	-- LSP status
	{
		"linrongbin16/lsp-progress.nvim",
		config = function()
			require("lsp-progress").setup()
		end,
	},
	-- Git signs next to line numbers
	{ "lewis6991/gitsigns.nvim", config = true },
	-- Show LSP signature on hover
	{ "ray-x/lsp_signature.nvim", opts = { hint_enable = false } },
	-- Git client, magit like
	{
		"NeogitOrg/neogit",
		dependencies = {
			"nvim-lua/plenary.nvim", -- required
			"sindrets/diffview.nvim", -- optional - Diff integration

			-- Only one of these is needed, not both.
			"nvim-telescope/telescope.nvim", -- optional
		},
	},
	{
		-- surround motion
		"kylechui/nvim-surround",
		version = "*", -- Use for stability; omit to use `main` branch for the latest features
		event = "VeryLazy",
		config = function()
			require("nvim-surround").setup({})
		end,
	},
	{
		-- Tests
		"nvim-neotest/neotest",
		dependencies = {
			"nvim-neotest/nvim-nio",
			"nvim-lua/plenary.nvim",
			"nvim-treesitter/nvim-treesitter",
			"jfpedroza/neotest-elixir",
		},

		config = function()
			require("neotest").setup({
				adapters = { require("neotest-elixir") },
			})
		end,
	},
	{
		-- Auto pairs
		"windwp/nvim-autopairs",
		dependencies = { "hrsh7th/nvim-cmp" },
		event = "InsertEnter",
		config = function()
			require("nvim-autopairs").setup({})
			-- If you want to automatically add `(` after selecting a function or method
			local cmp_autopairs = require("nvim-autopairs.completion.cmp")
			local cmp = require("cmp")
			cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
		end,
	},
	-- Navigate between tmux and neovim windows
	{ "christoomey/vim-tmux-navigator" },
	-- Pictograms in completions
	{ "onsails/lspkind.nvim" },
	-- Git client
	{ "tpope/vim-fugitive" },
	-- Resolve git merge conflicts
	{ "akinsho/git-conflict.nvim", version = "*", config = true },
})

-- Set colorscheme
vim.cmd([[colorscheme gruvbox]])

-- Strip trailing whitespace on save
vim.api.nvim_create_autocmd({ "BufWritePre" }, {
	pattern = { "*" },
	command = [[%s/\s\+$//e]],
})

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})
--
-- listen lsp-progress event and refresh lualine
vim.api.nvim_create_augroup("lualine_augroup", { clear = true })
vim.api.nvim_create_autocmd("User", {
	group = "lualine_augroup",
	pattern = "LspProgressStatusUpdated",
	callback = require("lualine").refresh,
})

-- Add nvim-lspconfig plugin
local lspconfig = require("lspconfig")
local on_attach = function(_, bufnr)
	local attach_opts = { silent = true, buffer = bufnr }
	vim.keymap.set("n", "ü", vim.lsp.buf.definition, attach_opts)
	vim.keymap.set("n", "K", vim.lsp.buf.hover, attach_opts)
	vim.keymap.set("n", "<C-s>", vim.lsp.buf.signature_help, attach_opts)
end

-- nvim-cmp supports additional completion capabilities
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

-- Elixir LS
lspconfig.elixirls.setup({
	capabilities = capabilities,
	on_attach = on_attach,
	cmd = { "/home/ntraum/coding/elixir-ls/v0.22.1/language_server.sh" },
})

-- Lua LS
lspconfig.lua_ls.setup({
	capabilities = capabilities,
	on_attach = on_attach,
	settings = {
		Lua = {
			diagnostics = {
				globals = { "vim" },
			},
		},
	},
})

-- pyright LS (Python)
lspconfig.pyright.setup({
	capabilities = capabilities,
	on_attach = on_attach,
})

-- Telescope keymaps
local builtin = require("telescope.builtin")
vim.keymap.set("n", "<leader>ff", function()
	builtin.find_files({ hidden = true })
end)
vim.keymap.set("n", "<leader>fr", builtin.oldfiles)
vim.keymap.set("n", "<leader>fg", builtin.live_grep)
vim.keymap.set("n", "<leader>bb", function()
	builtin.buffers({ sort_mru = true })
end)
vim.keymap.set("n", "<leader>fh", builtin.help_tags)
vim.keymap.set("n", "<leader>fl", builtin.lsp_workspace_symbols)

local cmp = require("cmp")
local lspkind = require("lspkind")

cmp.setup({
	snippet = {
		expand = function(args)
			require("luasnip").lsp_expand(args.body)
		end,
	},
	mapping = {
		["<C-d>"] = cmp.mapping.scroll_docs(-4),
		["<C-f>"] = cmp.mapping.scroll_docs(4),
		["<C-e>"] = cmp.mapping.close(),
		["<CR>"] = cmp.mapping.confirm({ select = true }),
		["<C-n>"] = cmp.mapping(cmp.mapping.select_next_item(), { "i", "c" }),
		["<C-p>"] = cmp.mapping(cmp.mapping.select_prev_item(), { "i", "c" }),
	},
	completion = {
		keyword_length = 2,
	},
	sources = {
		{ name = "nvim_lsp", keyword_length = 2 },
		{
			name = "buffer",
			option = {
				-- Complete from other buffers too
				get_bufnrs = function()
					return vim.api.nvim_list_bufs()
				end,
			},
		},
		{ name = "path" },
		{ name = "cmdline" },
		{ name = "luasnip" },
	},
	formatting = {
		format = lspkind.cmp_format({
			mode = "symbol", -- show only symbol annotations
			maxwidth = 50, -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
			-- can also be a function to dynamically calculate max width such as
			-- maxwidth = function() return math.floor(0.45 * vim.o.columns) end,
			ellipsis_char = "...", -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead (must define maxwidth first)
			show_labelDetails = true, -- show labelDetails in menu. Disabled by default
		}),
	},
})

-- Jump to previous buffer
vim.keymap.set("n", "Ü", ":bp<CR>")

-- Window navigation
vim.keymap.set("n", "C-h", ":TmuxNavigateLeft<CR>")
vim.keymap.set("n", "C-l", ":TmuxNavigateRight<CR>")
vim.keymap.set("n", "C-j", ":TmuxNavigateDown<CR>")
vim.keymap.set("n", "C-k", ":TmuxNavigateUp<CR>")
vim.keymap.set("n", "C-<Tab>", ":TmuxNavigatePrevious<CR>")

vim.keymap.set("n", "gs", ":Git<CR>")

-- Quickfix list                                                                      t
-- Toggle on q
-- vim.keymap.set("n", "q", function()
-- 	local qf_winid = vim.fn.getqflist({ winid = 0 }).winid
-- 	local action = qf_winid > 0 and "cclose" or "copen"
-- 	vim.cmd("botright " .. action)
-- end, { noremap = true, silent = true })
vim.keymap.set("n", "[q", vim.diagnostic.goto_prev, { desc = "Go to previous [D]iagnotstic message" })
vim.keymap.set("n", "]q", vim.diagnostic.goto_next, { desc = "Go to next [D]iagnostict message" })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

-- Tests
vim.keymap.set("n", "<leader>tt", require("neotest").run.run)
vim.keymap.set("n", "<leader>to", function()
	require("neotest").output.open({ enter = true })
end)
vim.keymap.set("n", "<leader>tT", function()
	require("neotest").run.run(vim.fn.expand("%"))
end)
vim.keymap.set("n", "<leader>tl", require("neotest").run.run_last)

-- Git

vim.keymap.set(
	"n",
	"fe",
	":edit  /home/ntraum/coding/nTraum/dotfiles/neovim/.config/nvim/init.lua<CR>",
	{ noremap = true }
)

-- Diagnostics

vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Go to previous [D]iagnostic message" })
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Go to next [D]iagnostic message" })
vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, { desc = "Show diagnostic [E]rror messages" })
