" Map leader key to SPACE
let mapleader = "\<Space>"

function! DoRemote(arg)
    UpdateRemotePlugins
endfunction

" vim-plug
call plug#begin()
Plug 'kien/ctrlp.vim'
Plug 'xolox/vim-misc' | Plug 'xolox/vim-easytags'
Plug 'majutsushi/tagbar'
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-fugitive'
Plug 'raimondi/delimitmate'
Plug 'itchyny/lightline.vim'
Plug 'rking/ag.vim'
Plug 'Shougo/deoplete.nvim', { 'do': function('DoRemote') }
Plug 'nathanaelkane/vim-indent-guides'
Plug 'ntpeters/vim-better-whitespace'
Plug 'elixir-lang/vim-elixir'
Plug 'archSeer/elixir.nvim'
Plug 'chriskempson/base16-vim'
Plug 'SirVer/ultisnips'
call plug#end()

nmap <F8> :TagbarToggle<CR>

" Enable Line numbers
set number
set relativenumber

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

" Strip trailing whitespace on save
autocmd BufWritePre * :StripWhitespace

" Use deoplete.
let g:deoplete#enable_at_startup=1

"
let g:ctrlp_user_command = 'ag %s --files-with-matches --nocolor --hidden -g ""'
" Show hidden files
let g:ctrlp_dotfiles=1
" Don't sync results size with window height
let g:ctrlp_match_window = 'results:50'

" Cycle buffers with <Tab> <S-Tab>
nnoremap <Tab> <C-w>w
nnoremap <S-Tab> <C-w>W

" Update ctags async
let g:easytags_async=1

" Create tags file in current working directory
let g:easytags_dynamic_files=2
set cpoptions+=d
set tags=./.tags

" Do not automatically highlight tags
let g:easytags_auto_highlight = 0

" Add support for Elixir
let g:tagbar_type_elixir = {
    \ 'ctagstype' : 'elixir',
    \ 'kinds' : [
        \ 'f:functions',
        \ 'functions:functions',
        \ 'c:callbacks',
        \ 'd:delegates',
        \ 'e:exceptions',
        \ 'i:implementations',
        \ 'a:macros',
        \ 'o:operators',
        \ 'm:modules',
        \ 'p:protocols',
        \ 'r:records'
    \ ]
\ }
