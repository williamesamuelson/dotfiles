syntax on

set belloff=all
set tabstop=4 softtabstop=4
set shiftwidth=4
set expandtab
set smartindent
set number
set nowrap
set incsearch
set hlsearch
set scrolloff=8
set undofile
set undodir=~/.vim/undodir
set confirm
set directory^=$HOME/.vim/swap//

set colorcolumn=80
highlight ColorColumn ctermbg=238
set background=dark
set t_Co=256

filetype on             " enable filetype detection
filetype plugin on      " load file-specific plugins
filetype indent on      " load file-specific indentation

set encoding=utf-8

nnoremap ö <esc>
inoremap ö <esc>
vnoremap ö <esc>
xnoremap ö <esc>
snoremap ö <esc>
cnoremap ö <C-C>
onoremap ö <esc>

let &t_SI = "\<Esc>[6 q"
let &t_SR = "\<Esc>[3 q"
let &t_EI = "\<Esc>[2 q"

let g:UltiSnipsExpandTrigger       = '<Tab>'    " use Tab to expand snippets
let g:UltiSnipsJumpForwardTrigger  = '<Tab>'    " use Tab to move forward through tabstops
let g:UltiSnipsJumpBackwardTrigger = '<S-Tab>'  " use Shift-Tab to move backward through tabstops
let g:UltiSnipsSnippetDirectories=[$HOME.'/.vim/UltiSnips']

call plug#begin()
Plug 'morhetz/gruvbox'
Plug 'davidhalter/jedi-vim'
Plug 'vim-syntastic/syntastic'
Plug 'lervag/vimtex'
Plug 'SirVer/ultisnips'
Plug 'JuliaEditorSupport/julia-vim'
call plug#end()

set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_loc_list_height = 3

let g:gruvbox_guisp_fallback = "bg"
colorscheme gruvbox
