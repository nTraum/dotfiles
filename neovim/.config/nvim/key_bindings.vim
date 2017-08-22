" Map leader key to SPACE
let mapleader = "\<Space>"

" Use `Ctrl+{h,j,k,l}` to navigate between splits no matter if they are displaying a normal buffer or a terminal
" buffer in terminal mode.
nnoremap <C-h> <C-W><C-H>
nnoremap <C-j> <C-W><C-J>
nnoremap <C-k> <C-W><C-K>
nnoremap <C-l> <C-W><C-L>

tnoremap <C-h> <C-\><C-n><C-W>h
tnoremap <C-j> <C-\><C-n><C-W>j
tnoremap <C-k> <C-\><C-n><C-W>k
tnoremap <C-l> <C-\><C-n><C-W>l

nnoremap <C-Right> :vertical resize +2<CR>
nnoremap <C-Left> :vertical resize -2<CR>
nnoremap <C-Up> :resize +2<CR>
nnoremap <C-Down> :resize -2<CR>

" Use <Esc> to go to normal mode in terminal
:tnoremap <Esc> <C-\><C-n>

" fugitive bindings
nmap <leader>gb :Gblame<CR>
nmap <leader>gc :Gcommit<CR>
nmap <leader>gd :Gdiff<CR>
nmap <leader>gp :Gpush<CR>
nmap <leader>gs :Gstatus<CR>
nmap <leader>gw :Gwrite<CR>

" vim-test bindings
nmap <silent> <leader>tt :TestNearest<CR>
nmap <silent> <leader>tT :TestFile<CR>
nmap <silent> <leader>ta :TestSuite<CR>
nmap <silent> <leader>tl :TestLast<CR>
nmap <silent> <leader>tg :TestVisit<CR>

" Cycle buffers with <Tab> <S-Tab>
nnoremap <Tab> <C-w>w
nnoremap <S-Tab> <C-w>W

" Jump to tag on German keyboard
nnoremap ü g<C-]>
nnoremap Ü <C-O>

" Tagbar bindings
nmap <F8> :TagbarToggle<CR>

" File related bindings
nmap <leader>ff :FZF<CR>
nmap <leader>fs :Grepper<CR>
nmap <leader>fh :History<CR>
