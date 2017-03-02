" Map leader key to SPACE
let mapleader = "\<Space>"

" Use `Alt+{h,j,k,l}` to navigate between splits no matter if they are displaying a normal buffer or a terminal
" buffer in terminal mode.
nnoremap º <C-W>j
nnoremap ∆ <C-W><C-K>
nnoremap @ <C-W><C-L>
nnoremap ª <C-W><C-H>

:tnoremap º <C-\><C-n><C-W>h
:tnoremap ∆ <C-\><C-n><C-W>j
:tnoremap @ <C-\><C-n><C-W>k
:tnoremap ª <C-\><C-n><C-W>l

" Use <Esc> to go to normal mode in terminal
:tnoremap <Esc> <C-\><C-n>

" fugitive bindings
nmap <leader>ga :Gwrite<CR>
nmap <leader>gb :Gblame<CR>
nmap <leader>gc :Gcommit<CR>
nmap <leader>gd :Gdiff<CR>
nmap <leader>gs :Gstatus<CR>

" vim-test bindings
nmap <silent> <leader>t :TestNearest<CR>
nmap <silent> <leader>T :TestFile<CR>
nmap <silent> <leader>a :TestSuite<CR>
nmap <silent> <leader>l :TestLast<CR>
nmap <silent> <leader>g :TestVisit<CR>

" Cycle buffers with <Tab> <S-Tab>
nnoremap <Tab> <C-w>w
nnoremap <S-Tab> <C-w>W

" Jump to tag on German keyboard
nnoremap ü g<C-]>
nnoremap Ü <C-O>

" Ag bindings
nmap <leader>s :Ack!<Space>

" FZF bindings
nmap <C-p> :FZF<ENTER>

" Tagbar bindings
nmap <F8> :TagbarToggle<CR>
