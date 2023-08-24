syntax on

" Plugins will be downloaded under the specified directory.
"call plug#begin(has('nvim') ? stdpath('data') . '/plugged' : '~/.vim/plugged')
call plug#begin('~/.vim/plugged')

" all plugins.
Plug 'scrooloose/nerdtree', {'on': 'NERDTreeToggle'}
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'ARM9/arm-syntax-vim'

" rust
Plug 'rust-lang/rust.vim'

" trailing whitespace
Plug 'ntpeters/vim-better-whitespace'

" List ends here. Plugins become visible to Vim after this call.
call plug#end()

" plugin setup
nnoremap <C-t> :NERDTreeToggle<CR>

" strip all whitespace
nnoremap <leader>s :StripWhitespace<CR>

" tab view shortcut
nnoremap <C-Left> :tabprevious<CR>
nnoremap <C-Right> :tabnext<CR>

set wildmenu
set wildmode=longest:full,full

set backspace=indent,eol,start
set expandtab softtabstop=4 shiftwidth=4 tabstop=4

" file type setup
au FileType c,cpp,proto,cmake,asm set cindent autoindent tabstop=2 shiftwidth=2  softtabstop=2
au FileType fortran set autoindent smartindent tabstop=8 shiftwidth=8
au FileType python set autoindent tabstop=4 shiftwidth=4 softtabstop=4
au BufNewFile,BufRead *.cu set ft=cuda tabstop=2 shiftwidth=2  softtabstop=2
au BufNewFile,BufRead *.cuh set ft=cuda tabstop=2 shiftwidth=2  softtabstop=2

" assembly
au BufNewFile,BufRead *.nasm set ft=nasm autoindent
au BufNewFile,BufRead *.s,*.S set filetype=arm " arm = armv6/7

au BufNewFile,BufRead *.proto3 set ft=proto
au BufNewFile,BufRead *.m set ft=objc
au BufNewFile,BufRead *.metal set ft=cpp

" key maps
imap jk <esc>
imap <c-u> <esc>vbUea
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
noremap <C-L> <C-W><C-L>
noremap <C-H> <C-W><C-H>

" auto call clang-format
function FormatBuffer()
  if &modified && !empty(findfile('.clang-format', expand('%:p:h') . ';')) && executable('clang-format')
    let cursor_pos = getpos('.')
    :%!clang-format
    call setpos('.', cursor_pos)
  endif
endfunction

autocmd BufWritePre *.h,*.hpp,*.cuh,*.c,*.cpp,*.cc,*.cxx,*.cu,*.proto :call FormatBuffer()
