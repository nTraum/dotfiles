function! DoRemote(arg)
    UpdateRemotePlugins
endfunction

" vim-plug
call plug#begin()
Plug 'xolox/vim-misc' | Plug 'xolox/vim-easytags'
Plug 'majutsushi/tagbar'
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-bundler'
Plug 'raimondi/delimitmate'
Plug 'itchyny/lightline.vim'
Plug 'mileszs/ack.vim'
Plug 'Shougo/deoplete.nvim', { 'do': function('DoRemote') }
Plug 'nathanaelkane/vim-indent-guides'
Plug 'ntpeters/vim-better-whitespace'
Plug 'elixir-lang/vim-elixir'
Plug 'chriskempson/base16-vim'
Plug 'airblade/vim-rooter'
Plug 'SirVer/ultisnips'
Plug 'janko-m/vim-test'
Plug 'vim-ruby/vim-ruby'
Plug 'scrooloose/nerdcommenter'
Plug 'neomake/neomake'
Plug 'terryma/vim-multiple-cursors'
Plug '/usr/local/opt/fzf' | Plug 'junegunn/fzf.vim'
Plug 'SirVer/ultisnips'
call plug#end()

source ~/.config/nvim/key_bindings.vim
source ~/.config/nvim/lightline.vim
source ~/.config/nvim/tagbar.vim

" Enable smartsearch
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

" Enable predawn colorscheme & dark background
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

" Strip trailing whitespace on save
autocmd BufWritePre * :StripWhitespace

" Use deoplete.
let g:deoplete#enable_at_startup=1

" Increase cache size to 5Mib
let deoplete#tag#cache_limit_size = 5000000

let g:ackprg = 'rg --vimgrep --hidden'

" Neomake configuration
autocmd! BufWritePost * Neomake

let g:neomake_open_list = 2
let g:neomake_ruby_enabled_makers = ['mri']

" Update ctags async
let g:easytags_async=1

" Create tags file in current working directory
let g:easytags_dynamic_files=2
set cpoptions+=d
set tags=./.tags

" Do not automatically highlight tags
let g:easytags_auto_highlight = 0

" Always show gitgutter column
let g:gitgutter_sign_column_always=1

" Use neovim terminal as test strategy
let test#strategy = "neovim"

let g:UltiSnipsSnippetsDir = "~/.config/nvim/UltiSnips"
