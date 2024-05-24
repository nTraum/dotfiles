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

-- Show line numbers
vim.opt.number = true

vim.opt.smartcase = true

-- Live show substituations in buffer
vim.opt.incsearch = true

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

vim.opt.completeopt = "menu,menuone,noselect"

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
			formatters_by_ft = { lua = { "stylua" } },
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
	{
		-- TODO
		"folke/which-key.nvim",
		event = "VeryLazy",
		init = function()
			vim.o.timeout = true
			vim.o.timeoutlen = 1000
		end,
	},
	{ "nvim-telescope/telescope.nvim", tag = "0.1.6", dependencies = { "nvim-lua/plenary.nvim" } },
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
	-- Status line
	{ "nvim-lualine/lualine.nvim", dependencies = { "nvim-tree/nvim-web-devicons" }, opts = { "gruvbox" } },
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
})

-- Set colorscheme
vim.cmd([[colorscheme gruvbox]])

-- Setup called here so neogit picks up the colorscheme, but it still does not look nice
require("neogit").setup({})

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
	cmd = { "/home/ntraum/coding/elixir-ls/v0.21.3/language_server.sh" },
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

-- Telescope keymaps
local builtin = require("telescope.builtin")
vim.keymap.set("n", "<leader>ff", builtin.find_files, { noremap = true })
vim.keymap.set("n", "<leader>fr", builtin.oldfiles, { noremap = true })
vim.keymap.set("n", "<leader>fg", builtin.live_grep, { noremap = true })
vim.keymap.set("n", "<leader>bb", builtin.buffers, { noremap = true })

local cmp = require("cmp")

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
		{ name = "nvim_lsp" },
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
})

vim.keymap.set("n", "Ü", ":bp<CR>", { noremap = true })
vim.keymap.set("n", "<leader>wh", "<C-w>h", { noremap = true })
vim.keymap.set("n", "<leader>wl", "<C-w>l", { noremap = true })
vim.keymap.set("n", "<leader>wj", "<C-w>j", { noremap = true })
vim.keymap.set("n", "<leader>wk", "<C-w>k", { noremap = true })
vim.keymap.set("n", "<leader><Tab>", "<C-w>p", { noremap = true })

vim.keymap.set("n", "gs", ":Neogit<CR>", { noremap = true })
