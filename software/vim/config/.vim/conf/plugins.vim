" PLUGINS ---------------------------------------------------------------- {{{
" Plugin manager: https://github.com/junegunn/vim-plug


" BEFORE LOADING PLUGINS
" Do some stuff here...


" LOADING PLUGINS
" type :PlugInstall to download and install the plugins
call plug#begin('~/.vim/plugged')

    " Universal set of defaults that (hopefully) everyone can agree on
    Plug 'tpope/vim-sensible'

    " Syntax
    Plug 'sheerun/vim-polyglot'

    " Light and configurable statusline/tabline plugin for Vim
    Plug 'itchyny/lightline.vim'

    "  " Tree
    "  Plug 'scrooloose/nerdtree'

    "  IDE
    Plug 'editorconfig/editorconfig-vim'
    Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
    Plug 'junegunn/fzf.vim'
    Plug 'mhinz/vim-signify'

    "  Git
    Plug 'tpope/vim-fugitive'

call plug#end()


" AFTER LOADING PLUGINS
" Do some stuff here...

" CONF: itchyny/lightline.vim
let g:lightline = {
      \ 'colorscheme': 'molokai',
      \ }

" CONF: editorconfig/editorconfig-vim
let g:EditorConfig_exclude_patterns = ['fugitive://.*', 'scp://.*']
au FileType gitcommit let b:EditorConfig_disable = 1

" CONF: mhinz/vim-signify
set updatetime=100 " default updatetime 4000ms is not good for async update

" ------------------------------------------------------------------------ }}}
