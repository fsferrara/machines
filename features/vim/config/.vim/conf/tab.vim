" TAB SETTING ------------------------------------------------------------ {{{

set expandtab                           " replace <TAB> with spaces
au FileType Makefile set noexpandtab    " except for Makefiles
set softtabstop=4
set shiftwidth=4
set tabstop=4

" If the current file type is HTML, set indentation to 2 spaces.
autocmd Filetype html setlocal tabstop=2 shiftwidth=2 expandtab

" ------------------------------------------------------------------------ }}}
