call plug#begin('~/.vim/plugged')

Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'} "vscode like language servers
Plug 'morhetz/gruvbox' "colorscheme
Plug 'scrooloose/nerdtree' "explorer inside vim
Plug 'Xuyuanp/nerdtree-git-plugin' "git status in nredtree
Plug 'ryanoasis/vim-devicons' "icons
Plug 'airblade/vim-gitgutter' "git status in line number and also preview of the change 
"Plug 'ctrlpvim/ctrlp.vim' " fuzzy find files
Plug 'scrooloose/nerdcommenter' "commenter
Plug 'prettier/vim-prettier', { 'do': 'yarn install' } "prettier like vscode
Plug 'christoomey/vim-tmux-navigator' "tmux navigator
Plug 'HerringtonDarkholme/yajs.vim' " JS syntax
Plug 'vim-airline/vim-airline' " shows all the buffers open
Plug 'vim-airline/vim-airline-themes'
Plug 'jiangmiao/auto-pairs' "adds bracket and also indents automatically afte return
Plug 'sheerun/vim-polyglot' "syntax highlight for soo many langs
Plug 'Yggdroot/indentLine' "adds vertical lines for each indentation

" telescope requirments
Plug 'nvim-lua/popup.nvim' "for telescope fuzzy finder
Plug 'nvim-lua/plenary.nvim' "for telescope fuzzy finder
Plug 'nvim-telescope/telescope.nvim' "for telescope fuzzy finder
Plug 'nvim-telescope/telescope-fzy-native.nvim' "recommended by theprimeagen 

call plug#end()

syntax on

set nocompatible
set noerrorbells
set tabstop=4 softtabstop=4
set shiftwidth=4
set expandtab
set smartindent
set nu
set nowrap
set smartcase
set noswapfile
set nobackup
set undodir=~/.vim/undodir
set undofile
set incsearch
set encoding=utf-8
set wildmenu " for list and autocompletion in vi command

" transparent bg
autocmd vimenter * hi Normal guibg=NONE ctermbg=NONE
" For Vim<8, replace EndOfBuffer by NonText
autocmd vimenter * hi EndOfBuffer guibg=NONE ctermbg=NONE

set colorcolumn=80
highlight ColorColumn ctermbg=0 guibg=lightgrey

" my configs
set relativenumber " the line numbers
set termguicolors " makes the colors better

nmap ev :e $MYVIMRC<CR> " to open the vimrc

"for compile and run with filetype
autocmd filetype cpp nnoremap <F9> :w <bar> !cls && g++ -std=c++14 % -o %:r -Wl,--stack,268435456<CR>
autocmd filetype cpp nnoremap <F10> :!%:r<CR>
autocmd filetype python nnoremap <buffer> <F9> :w <bar> !python3 %<CR>

" keybindings
nmap <C-n> :NERDTreeToggle<CR>
vmap ++ <plug>NERDCommenterToggle
nmap ++ <plug>NERDCommenterToggle

" coc config
let g:coc_global_extensions = [
  \ 'coc-snippets',
  \ 'coc-pairs',
  \ 'coc-tsserver',
  \ 'coc-eslint', 
  \ 'coc-prettier', 
  \ 'coc-json', 
  \ ]

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh() " like vscode

" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

" sync open file with NERDTree
" " Check if NERDTree is open or active
function! IsNERDTreeOpen()        
  return exists("t:NERDTreeBufName") && (bufwinnr(t:NERDTreeBufName) != -1)
endfunction

" Call NERDTreeFind iff NERDTree is active, current window contains a modifiable
" file, and we're not in vimdiff
function! SyncTree()
  if &modifiable && IsNERDTreeOpen() && strlen(expand('%')) > 0 && !&diff
    NERDTreeFind
    wincmd p
  endif
endfunction

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

colorscheme gruvbox

"ctrlp
"setting to ignore certain folders and files mentioned in the mentioned
"files
let g:ctrlp_user_command = ['.git/', 'git --git-dir=%s/.git ls-files -oc --exclude-standard']

" vim-prettier
"let g:prettier#quickfix_enabled = 0
"let g:prettier#quickfix_auto_focus = 0
" prettier command for coc
command! -nargs=0 Prettier :CocCommand prettier.formatFile
" run prettier on save
let g:prettier#autoformat = 0
autocmd BufWritePre *.js,*.jsx,*.mjs,*.ts,*.tsx,*.css,*.less,*.scss,*.json,*.graphql,*.md,*.vue,*.yaml,*.html PrettierAsync

" airline
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#formatter = 'unique_tail' "This is the formatter of the file name that is displayed
let g:airline_powerline_fonts = 1
let g:airline_section_b = '%{getcwd()}'

" indentLine
let g:indentLine_char_list = ['|', '¦', '┆', '┊']
let g:indentLine_first_char = '|' 
let g:indentLine_showFirstIndentLevel = 1
let g:indentLine_setColors = 1

" set the leader varibel default='\'
let mapleader = ' '

" Find files using Telescope command-line sugar.
nnoremap <C-p> <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>

