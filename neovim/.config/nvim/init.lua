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

-- views can only be fully collapsed with the global statusline
vim.opt.laststatus = 3
--
-- New UI opt-in
require("vim._core.ui2").enable({})

require("lazy").setup({
	{
		"saghen/blink.cmp",
		-- use a release tag to download pre-built binaries
		version = "1.*",
		---@module 'blink.cmp'
		---@type blink.cmp.Config
		opts = {
			-- 'default' (recommended) for mappings similar to built-in completions (C-y to accept)
			-- 'super-tab' for mappings similar to vscode (tab to accept)
			-- 'enter' for enter to accept
			-- 'none' for no mappings
			--
			-- All presets have the following mappings:
			-- C-space: Open menu or open docs if already open
			-- C-n/C-p or Up/Down: Select next/previous item
			-- C-e: Hide menu
			-- C-k: Toggle signature help (if signature.enabled = true)
			--
			-- See :h blink-cmp-config-keymap for defining your own keymap
			-- keymap = { preset = "default" },

			-- appearance = {
			-- 	-- 'mono' (default) for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
			-- 	-- Adjusts spacing to ensure icons are aligned
			-- 	nerd_font_variant = "mono",
			-- },

			-- (Default) Only show the documentation popup when manually triggered
			completion = { documentation = { auto_show = true }, ghost_text = { enabled = true } },

			-- Default list of enabled providers defined so that you can extend it
			-- elsewhere in your config, without redefining it, due to `opts_extend`
			-- sources = {
			-- 	default = { "lsp", "path", "snippets", "buffer" },
			-- },

			signature = { enabled = true },

			fuzzy = { implementation = "prefer_rust_with_warning" },
		},
		opts_extend = { "sources.default" },
	},

	{
		-- Auto format on save
		"stevearc/conform.nvim",
		opts = {
			format_on_save = { timeout_ms = 2000, lsp_fallback = true },
			formatters = {
				stylua = {
					command = "/home/ntraum/bin/stylua",
				},
			},
			formatters_by_ft = {
				lua = { "stylua" },
				javascript = { "prettier" },
				json = { "jq" },
				fish = { "fish_indent" },
			},
		},
	},

	{ "L3MON4D3/LuaSnip", version = "v2.*" },
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
		dependencies = { "nvim-lua/plenary.nvim" },
		opts = {
			defaults = {
				layout_config = {
					horizontal = {
						preview_cutoff = 120,
					},
				},
			},
		},
	},
	{
		"nvim-treesitter/nvim-treesitter",
		branch = "main",
		lazy = false,
		build = ":TSUpdate",

		config = function()
			require("nvim-treesitter").install({
				"lua",
				"vim",
				"vimdoc",
				"query",
				"elixir",
				"heex",
				"javascript",
				"html",
			})

			vim.api.nvim_create_autocmd("FileType", {
				callback = function()
					pcall(vim.treesitter.start)

					vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
				end,
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
					{ vim.lsp.status },
				},
			},
		},
	},
	-- Git signs next to line numbers
	{ "lewis6991/gitsigns.nvim", config = true },
	-- Auto-highlight references to symbol under cursor
	{ "RRethy/vim-illuminate" },
	-- Collection of QoL utilities
	{
		"folke/snacks.nvim",
		opts = {
			input = { enabled = true },
			notifier = { enabled = true },
			indent = { enabled = true, only_scope = true },
			scroll = { enabled = true },
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
	-- Navigate between tmux and neovim windows
	{ "christoomey/vim-tmux-navigator" },
	-- Pictograms in completions
	{ "onsails/lspkind.nvim" },
	-- Git client
	{ "tpope/vim-fugitive" },
	-- Enables :GBrowse for to open GH urls in fugitive
	{ "tpope/vim-rhubarb" },
	-- Resolve git merge conflicts
	{ "akinsho/git-conflict.nvim", version = "*", config = true },
	{ "ThePrimeagen/harpoon", dependencies = { "nvim-lua/plenary.nvim" }, branch = "harpoon2", config = true },
	-- Highlight TODO / FIXME comments
	{ "folke/todo-comments.nvim", dependencies = { "nvim-lua/plenary.nvim" }, config = true },
	{
		"f-person/git-blame.nvim",
		-- Because of the keys part, you will be lazy loading this plugin.
		-- The plugin wil only load once one of the keys is used.
		-- If you want to load the plugin at startup, add something like event = "VeryLazy",
		-- or lazy = false. One of both options will work.
		opts = {
			-- your configuration comes here
			-- for example
			enabled = true, -- if you want to enable the plugin
			virtual_text_column = 80,
			highlight_group = "CursorLine",
			--
			--
			-- message_template = " <summary> • <date> • <author> • <<sha>>", -- template for the blame message, check the Message template section for more options
			-- date_format = "%m-%d-%Y %H:%M:%S", -- template for the date, check Date format section for more options
			-- virtual_text_column = 1, -- virtual text start column, check Start virtual text at column section for more options
		},
	},
	{
		"stevearc/oil.nvim",
		---@module 'oil'
		---@type oil.SetupOpts
		opts = {},
		-- Optional dependencies
		dependencies = { { "echasnovski/mini.icons", opts = {} } },
		-- dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if you prefer nvim-web-devicons
		-- Lazy loading is not recommended because it is very tricky to make it work correctly in all situations.
		lazy = false,
	},
	{
		"folke/trouble.nvim",
		opts = {},
		cmd = "Trouble",
		keys = {
			{
				"<leader>xx",
				"<cmd>Trouble diagnostics toggle<cr>",
				desc = "Diagnostics (Trouble)",
			},
			{
				"<leader>xX",
				"<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
				desc = "Buffer Diagnostics (Trouble)",
			},
			{
				"<leader>cs",
				"<cmd>Trouble symbols toggle focus=false<cr>",
				desc = "Symbols (Trouble)",
			},
			{
				"<leader>cl",
				"<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
				desc = "LSP Definitions / references / ... (Trouble)",
			},
			{
				"<leader>xL",
				"<cmd>Trouble loclist toggle<cr>",
				desc = "Location List (Trouble)",
			},
			{
				"<leader>xQ",
				"<cmd>Trouble qflist toggle<cr>",
				desc = "Quickfix List (Trouble)",
			},
		},
	},
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

-- Redraw statusline on LSP progress updates
vim.api.nvim_create_autocmd("LspProgress", {
	callback = function()
		vim.cmd.redrawstatus()
	end,
})

vim.lsp.set_log_level("warn")

-- Add nvim-lspconfig plugin
local lspconfig = require("lspconfig")

vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(args)
		local client = vim.lsp.get_client_by_id(args.data.client_id)
		if not client then
			return
		end

		local attach_opts = { silent = true, buffer = args.buf }
		vim.keymap.set("n", "ü", vim.lsp.buf.definition, attach_opts)
		vim.keymap.set("n", "K", vim.lsp.buf.hover, attach_opts)
		vim.keymap.set("n", "<C-s>", vim.lsp.buf.signature_help, attach_opts)
	end,
})

vim.lsp.config("expert", {
	cmd = { "/home/ntraum/coding/expert/expert_linux_amd64", "--stdio" },
	-- flags = {
	-- 	-- https://github.com/elixir-lang/expert/issues/110
	-- 	allow_incremental_sync = false,
	-- },
})

vim.lsp.enable("expert")
vim.lsp.enable("bashls")

vim.lsp.config("lua_ls", {
	on_init = function(client)
		if client.workspace_folders then
			local path = client.workspace_folders[1].name
			if
				path ~= vim.fn.stdpath("config")
				and (vim.uv.fs_stat(path .. "/.luarc.json") or vim.uv.fs_stat(path .. "/.luarc.jsonc"))
			then
				return
			end
		end

		client.config.settings.Lua = vim.tbl_deep_extend("force", client.config.settings.Lua, {
			runtime = {
				-- Tell the language server which version of Lua you're using (most
				-- likely LuaJIT in the case of Neovim)
				version = "LuaJIT",
				-- Tell the language server how to find Lua modules same way as Neovim
				-- (see `:h lua-module-load`)
				path = {
					"lua/?.lua",
					"lua/?/init.lua",
				},
			},
			-- Make the server aware of Neovim runtime files
			workspace = {
				checkThirdParty = false,
				library = {
					vim.env.VIMRUNTIME,
				},
			},
		})
	end,
	settings = {
		Lua = {},
	},
})

vim.lsp.enable("lua_ls")
vim.lsp.enable("pyright")
vim.lsp.enable("svelte")
vim.lsp.enable("yamlls")
vim.lsp.enable("ts_ls")

-- Enable inlay hints
vim.lsp.inlay_hint.enable()

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

local lspkind = require("lspkind")

-- LuaSnip snippets
local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node

ls.add_snippets("elixir", {
	s("pry", {
		t({ "require IEx; IEx.pry()" }),
	}),
	s("dbg", {
		t("dbg("),
		i(1, "expression"),
		t(")"),
	}),
})

-- Jump to previous buffer
vim.keymap.set("n", "Ü", ":bp<CR>")

-- Window navigation
vim.keymap.set("n", "<C-h>", ":TmuxNavigateLeft<CR>", { silent = true })
vim.keymap.set("n", "<C-l>", ":TmuxNavigateRight<CR>", { silent = true })
vim.keymap.set("n", "<C-j>", ":TmuxNavigateDown<CR>", { silent = true })
vim.keymap.set("n", "<C-k>", ":TmuxNavigateUp<CR>", { silent = true })
vim.keymap.set("n", "<C-Tab>", ":TmuxNavigatePrevious<CR>", { silent = true })

vim.keymap.set("n", "<leader>gs", ":Git<CR>")

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

-- Oil.nvim
vim.keymap.set("n", "<leader>-", "<CMD>Oil<CR>", { desc = "Open parent directory" })

-- Diagnostics

vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Go to previous [D]iagnostic message" })
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Go to next [D]iagnostic message" })
vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, { desc = "Show diagnostic [E]rror messages" })

-- Harpoon

local harpoon = require("harpoon")

vim.keymap.set("n", "<leader>A", function()
	harpoon:list():add()
end)

vim.keymap.set("n", "<leader>AA", function()
	harpoon.ui:toggle_quick_menu(harpoon:list())
end)

vim.keymap.set("n", "<C-1>", function()
	harpoon:list():select(1)
end)
vim.keymap.set("n", "<C-2>", function()
	harpoon:list():select(2)
end)
vim.keymap.set("n", "<C-3>", function()
	harpoon:list():select(3)
end)
vim.keymap.set("n", "<C-4>", function()
	harpoon:list():select(4)
end)
