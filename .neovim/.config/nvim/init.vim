let mapleader=","
call plug#begin()
" The default plugin directory will be as follows:
"   - Vim (Linux/macOS): '~/.vim/plugged'
"   - Vim (Windows): '~/vimfiles/plugged'
"   - Neovim (Linux/macOS/Windows): stdpath('data') . '/plugged'
" You can specify a custom plugin directory by passing it as the argument
"   - e.g. `call plug#begin('~/.vim/plugged')`
"   - Avoid using standard Vim directory names like 'plugin'

" Make sure you use single quotes
Plug 'mr-ubik/vim-hackerman-syntax'
Plug 'google/vim-searchindex'
Plug 'itchyny/lightline.vim'
Plug 'mengelbrecht/lightline-bufferline'
Plug 'ryanoasis/vim-devicons'
Plug 'honza/vim-snippets'
Plug 'frazrepo/vim-rainbow'
" Plugins with hotkeys
Plug 'preservim/nerdtree'
Plug 'preservim/tagbar'
Plug 'junegunn/vim-easy-align'
Plug 'tpope/vim-commentary'
Plug 'mg979/vim-visual-multi'
Plug 'ycm-core/YouCompleteMe'
Plug 'SirVer/ultisnips'
Plug 'tpope/vim-surround'
" Initialize plugin system
call plug#end()
" Enable % to jump between matching keywords
runtime macros/matchit.vim
" YCM settings
let g:ycm_key_list_select_completion   = ['<C-n>', '<Down>']
let g:ycm_key_list_previous_completion = ['<C-p>', '<Up>']
" Ultisnips settings
let g:UltiSnipsJumpForwardTrigger = '<tab>'
" vim-visual-multi settings
let g:VM_maps = {}
let g:VM_maps['Find Under']         = '<C-d>'
let g:VM_maps['Find Subword Under'] = '<C-d>'
let g:VM_maps["Select Cursor Down"] = '<C-j>'
let g:VM_maps["Select Cursor Up"]   = '<C-k>' 
" EasyAlign settings
vmap <cr> <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)
" Tagbar
" Start Tagbar
autocmd VimEnter * Tagbar
nmap <leader>t :TagbarToggle<CR>
" NERDTree
" Start NERDTree. If a file is specified, move the cursor to its window.
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * NERDTree | if argc() > 0 || exists("s:std_in") | wincmd p | endif
" Close the tab if NERDTree is the only window remaining in it.
autocmd BufEnter * if winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif
nnoremap <leader>n :NERDTreeToggle<CR>
nnoremap <leader>f :NERDTreeFind<CR>
" Use ctrl+hjkl to move cursor in insert mode
inoremap <C-h> <Left>
inoremap <C-j> <Down>
inoremap <C-k> <Up>
inoremap <C-l> <Right>
" Some insert mode hotkeys
inoremap (( ()<Esc>i
inoremap [[ []<Esc>i
inoremap {{ {}<Esc>i
inoremap {<CR> {<CR>}<Esc>ko
inoremap "" ""<Esc>i
inoremap '' ''<Esc>i
" Toggle hightlight search
nnoremap <C-h> :set hlsearch!<CR>
" Switching buffer hotkeys
nnoremap <C-n> :bn<CR>
nnoremap <C-p> :bp<CR>
" Edit vimrc
nnoremap <leader>ev :vs $MYVIMRC<cr>
" Source vimrc
nnoremap <leader>sv :source $MYVIMRC<cr>
" Rainbow parentheses settings
let g:rainbow_active = 1
" Line number settings
" Toggle absolute line number in insert mode. Otherwise, toggle relative line
" number.
set number relativenumber
autocmd InsertEnter * :set norelativenumber
autocmd InsertLeave * :set relativenumber
" Relpace tab and shift width with 2 space
set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab
" Other default settings
set hlsearch
set ruler
set backspace=2
set foldmethod=syntax
" nvim theme
colorscheme hackerman
" lightline settings
set laststatus=2
set showtabline=2
set noshowmode " lightline has already shown the mode
let g:lightline = {
      \ 'colorscheme': 'landscape',
      \ 'component': {
      \   'lineinfo': ' %3l:%-2v',
      \ },
      \ 'tabline': {
      \   'left': [['buffers']]
      \ },
      \ 'component_expand': {
      \   'buffers': 'lightline#bufferline#buffers'
      \ },
      \ 'component_type': {
      \   'buffers': 'tabsel'
      \ },
      \ 'component_function': {
      \   'readonly': 'LightlineReadonly',
      \   'fugitive': 'LightlineFugitive'
      \ },
      \ 'separator': { 'left': '', 'right': '' },
      \ 'subseparator': { 'left': '', 'right': '' }
      \ }
let g:lightline#bufferline#show_number  = 1
let g:lightline#bufferline#shorten_path = 0
let g:lightline#bufferline#unnamed      = '[No Name]'
function! LightlineReadonly()
  return &readonly ? '' : ''
endfunction
function! LightlineFugitive()
  if exists('*fugitive#head')
    let branch = fugitive#head()
    return branch !=# '' ? ''.branch : ''
  endif
  return ''
endfunction
