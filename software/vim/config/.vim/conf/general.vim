" GENERAL ---------------------------------------------------------------- {{{
set nocompatible    " Disable compatibility with vi which can cause unexpected issues.
filetype on         " Enable type file detection. Vim will be able to try to detect the type of file is use.
filetype plugin on  " Enable plugins and load plugin for the detected file type.
filetype indent on  " Load an indent file for the detected file type.
syntax on           " Turn syntax highlighting on.
set nobackup        " Do not save *~ backup files.
set scrolloff=10    " Do not let cursor scroll below or above N number of lines when scrolling.
set nowrap          " Do not wrap lines. Allow long lines to extend as far as the line goes.
set copyindent      " copy the previous indentation on autoindenting
" ------------------------------------------------------------------------ }}}
