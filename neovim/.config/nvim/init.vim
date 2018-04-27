function! DoRemote(arg)
  UpdateRemotePlugins
endfunction

" vim-plug
call plug#begin()
Plug 'roxma/nvim-completion-manager'
Plug 'roxma/ncm-rct-complete'
Plug '/usr/local/opt/fzf' | Plug 'junegunn/fzf.vim'
Plug 'Chiel92/vim-autoformat'
Plug 'w0rp/ale' " Async linting engine
Plug 'SirVer/ultisnips' " Snippets
Plug 'honza/vim-snippets' " Snippets
Plug 'airblade/vim-gitgutter' " Gutter with line modification icons
Plug 'airblade/vim-rooter' " Automatically set pwd to git repo root
Plug 'chriskempson/base16-vim' " Color scheme
Plug 'elixir-lang/vim-elixir' " General Elixir language support
Plug 'janko-m/vim-test' " General test runner
Plug 'majutsushi/tagbar' " Show tags in a side bar
Plug 'mhinz/vim-grepper'
Plug 'nathanaelkane/vim-indent-guides'
Plug 'ntpeters/vim-better-whitespace'
Plug 'raimondi/delimitmate'
Plug 'scrooloose/nerdcommenter'
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
Plug 'ludovicchabant/vim-gutentags'
call plug#end()

source ~/.config/nvim/key_bindings.vim
source ~/.config/nvim/tagbar.vim

autocmd BufEnter * EnableStripWhitespaceOnSave

set undofile
set undodir=$HOME/.tmp/vim/undo

set ignorecase
set smartcase
" Preview incremental updates like s/foo/bar
set inccommand=nosplit
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

let g:airline_theme='base16'

let g:airline_powerline_fonts = 1

" Use rubocop to ale fix ruby files
let g:ale_fixers = {
\   'ruby': ['rubocop'],
\}

" Delay ALE linting for 1 second
let g:ale_lint_delay = 1000
