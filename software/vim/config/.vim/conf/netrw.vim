" NETRW FILE TREE -------------------------------------------------------- {{{
let g:netrw_winsize = 25 " Change the size of the Netrw window
let g:netrw_keepdir = 0 " Keep the current directory and the browsing directory synced
let g:netrw_winsize = 25 " Change the size of the Netrw window
let g:netrw_banner = 0 " Hide the banner
let g:netrw_list_hide = '\(^\|\s\s\)\zs\S\+\.swp' " Hide swp files on load
let g:netrw_liststyle = 3
let g:netrw_browse_split = 4
let g:netrw_altv = 1

" Will open Netrw in the directory of the current file
nnoremap <leader>ef :Lexplore %:p:h<CR>
" Will open Netrw in the current working directory
nnoremap <Leader>e  :Lexplore<CR>
" ------------------------------------------------------------------------ }}}
