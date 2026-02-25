" FOLDING ---------------------------------------------------------------- {{{
set foldmethod=indent       " automatically fold by indent level
set nofoldenable            " ... but have folds open by default

" Enable the marker method of folding.
augroup filetype_vim
    autocmd!
    autocmd FileType vim setlocal foldmethod=marker
augroup END

" zc (close)    " zC (close all)
" zo (open)     " zO (open all)
" za (toggle)   " zA (toggle all)
" zR to open all folds.
" zM to close all folds.
" ------------------------------------------------------------------------ }}}
