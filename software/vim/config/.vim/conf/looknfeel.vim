" LOOKNFEEL -------------------------------------------------------------- {{{
colorscheme molokai
set noshowmode      " Do not show the mode you are on the last line.
set showcmd         " Show partial command you type in the last line of the screen.
set nocursorline    " Highlight cursor line underneath the cursor horizontally.
set nocursorcolumn  " Highlight cursor line underneath the cursor vertically.
set number          " Add numbers to the file.

if !has('gui_running')
  set t_Co=256
endif
" ------------------------------------------------------------------------ }}}

" GUI -------------------------------------------------------------------- {{{
if has('gui_running') " If GUI version of Vim is running set these options.
    set background=dark " Set the background tone.
    colorscheme molokai " Set the color scheme.
endif
" ------------------------------------------------------------------------ }}}
