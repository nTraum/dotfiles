function! DoRemote(arg)
  UpdateRemotePlugins
endfunction

" vim-plug
call plug#begin()
Plug '/usr/local/opt/fzf' | Plug 'junegunn/fzf.vim'
Plug 'Chiel92/vim-autoformat'
Plug 'Shougo/deoplete.nvim', { 'do': function('DoRemote') }
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'airblade/vim-gitgutter'
Plug 'airblade/vim-rooter'
Plug 'chriskempson/base16-vim'
Plug 'elixir-lang/vim-elixir'
Plug 'janko-m/vim-test'
Plug 'majutsushi/tagbar'
Plug 'mhinz/vim-grepper'
Plug 'nathanaelkane/vim-indent-guides'
Plug 'neomake/neomake'
Plug 'ntpeters/vim-better-whitespace'
Plug 'raimondi/delimitmate'
Plug 'scrooloose/nerdcommenter'
Plug 'terryma/vim-multiple-cursors'
Plug 'tpope/vim-bundler'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'vim-ruby/vim-ruby'
Plug 'kopischke/vim-fetch'
Plug 'nelstrom/vim-textobj-rubyblock' | Plug 'kana/vim-textobj-user'
Plug 'machakann/vim-highlightedyank'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
call plug#end()

source ~/.config/nvim/key_bindings.vim
source ~/.config/nvim/tagbar.vim

autocmd BufEnter * EnableStripWhitespaceOnSave

set ignorecase
set smartcase

" Enable Line numbers
set number
set relativenumber

" Keep 5 lines above / below cursor
set scrolloff=5

" Indentation
set expandtab
set shiftwidth=2
set softtabstop=2

" Disable last line that shows current mode
set noshowmode

" Enable base16 colorscheme on dark background
colorscheme base16-ocean
set background=dark

" Highlight current line
set cursorline

" Highlight column 120
set colorcolumn=120

" Always use System clipboard
set clipboard+=unnamed

" Open new splits on the right side / on the bottom
set splitbelow
set splitright

" Show completion window when multiple commands match
set wildmode=longest,list

" Undo always works
set hidden

" Use deoplete.
let g:deoplete#enable_at_startup=1

" Increase cache size to 5Mib
let deoplete#tag#cache_limit_size = 5000000

call deoplete#custom#set('ultisnips', 'matchers', ['matcher_fuzzy'])

" Neomake configuration
autocmd! BufWritePost * Neomake

let g:neomake_open_list = 2
let g:neomake_ruby_enabled_makers = ['mri']

" Create tags file in current working directory
set cpoptions+=d
set tags=./tags

" Always show gitgutter column
set signcolumn=yes

" Use neovim terminal as test strategy
let test#strategy = "neovim"

let g:UltiSnipsSnippetsDir = "~/.config/nvim/UltiSnips"

let g:grepper = {}
let g:grepper.tools = ['rg']

" Disable word wrap set by fugitive
autocmd FileType gitcommit setlocal textwidth=0

let g:airline_theme='base16_tomorrow'
