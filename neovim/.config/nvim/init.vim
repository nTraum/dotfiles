function! DoRemote(arg)
  UpdateRemotePlugins
endfunction

" vim-plug
call plug#begin()
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'ncm2/ncm2'
Plug 'roxma/nvim-yarp'
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
Plug 'scrooloose/nerdcommenter' " Mappings for commenting code
Plug 'tpope/vim-bundler'
Plug 'tpope/vim-fugitive' " Git wrapper
Plug 'tpope/vim-rhubarb' " GitHub extension for fugitive
Plug 'tpope/vim-surround' " Delete, change and add surroundings
Plug 'tpope/vim-repeat' " Extends repeatable commands using the . command
Plug 'vim-ruby/vim-ruby' " Ruby configuration files
Plug 'kopischke/vim-fetch' " Handle line numbers in filenames (like foo.rb:8)
Plug 'nelstrom/vim-textobj-rubyblock' | Plug 'kana/vim-textobj-user' " Ruby text objects
Plug 'machakann/vim-highlightedyank' " Highlight yanked text
Plug 'vim-airline/vim-airline' " Status line
Plug 'vim-airline/vim-airline-themes' " Status line
Plug 'ludovicchabant/vim-gutentags' " Tags
Plug 'vimwiki/vimwiki' " Personal wiki
Plug 'easymotion/vim-easymotion'
Plug 'slim-template/vim-slim'
call plug#end()

source ~/.config/nvim/key_bindings.vim
source ~/.config/nvim/tagbar.vim

" Strip leading WhiteSpace automatically
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
"colorscheme base16-default-dark
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

" Use ripgrepper for file search
let g:grepper = {}
let g:grepper.tools = ['rg']

" Automatically quote search string
let g:grepper.prompt_quote = 1

" Disable word wrap set by fugitive
autocmd FileType gitcommit setlocal textwidth=0

" Color theme
let g:airline_theme='base16'

" Use Powerline fonts in airline's status
let g:airline_powerline_fonts = 1

" Use rubocop to ale fix ruby files
" Use autopep8 to ale fix python files
let g:ale_fixers = {
\   'ruby': ['rubocop'],
\   'json': ['jq'],
\   'python': ['autopep8'],
\   'slim': ['slim-lint'],
\}

" Delay ALE linting for 1 second
let g:ale_lint_delay = 1000

" Python 3 autopep8 is not in PATH
let g:ale_python_autopep8_executable = '/Users/ntraum/Library/Python/3.6/bin/autopep8'


let g:vimwiki_list = [{'path': '~/vimwiki/',
                      \ 'syntax': 'markdown', 'ext': '.md'}]

" enable ncm2 for all buffers
autocmd BufEnter * call ncm2#enable_for_buffer()

" Easy motion f search
nmap s <Plug>(easymotion-overwin-f)

" Turn on case insensitive feature
let g:EasyMotion_smartcase = 1

" JK motions: Line motions
map <Leader>j <Plug>(easymotion-j)
map <Leader>k <Plug>(easymotion-k)

highlight SpellCap ctermbg=10
