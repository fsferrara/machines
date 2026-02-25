" MAPPINGS --------------------------------------------------------------- {{{

" Better window movement
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-h> <c-w>h
nnoremap <c-l> <c-w>l

" Resize with arrows
noremap <c-up> <c-w>+
noremap <c-down> <c-w>-
noremap <c-left> <c-w>>
noremap <c-right> <c-w><

" Press \P to print the current file to the default printer from a Linux operating system.
" View available printers:   lpstat -v
" Set default printer:       lpoptions -d <printer_name>
" <silent> means do not display output.
nnoremap <silent> <leader>P :%w !lp<CR>

" \p toggles paste mode
nmap <leader>p :set paste!<BAR>set paste?<CR>

" Press the space bar to type the : character in command mode.
nnoremap <space> :

" Turn off search highlighting by pressing \\.
nnoremap <leader>\ :nohlsearch<CR>

" ------------------------------------------------------------------------ }}}

" FZF.VIM ---------------------------------------------------------------- {{{


" Files (runs $FZF_DEFAULT_COMMAND if defined)
nnoremap <leader>f :Files<CR>
" Git files (git ls-files)
nnoremap <leader>gf :GFiles<CR>
" Git files (git status)
nnoremap <leader>gs :GFiles?<CR>
" Git commits (requires fugitive.vim)
nnoremap <leader>gc :Commits<CR>
" Git commits for the current buffer; visual-select lines to track changes in the range
nnoremap <leader>gC :BCommits<CR>
" Open buffers
nnoremap <leader>b :Buffers<CR>
" ag search result (ALT-A to select all, ALT-D to deselect all)
nnoremap <leader>S :Ag<CR>
" rg search result (ALT-A to select all, ALT-D to deselect all)
nnoremap <leader>s :Rg<CR>
" Lines in loaded buffers
nnoremap <leader>l :Lines<CR>
" Lines in the current buffer
nnoremap <leader>L :BLines<CR>
" Marks
nnoremap <leader>m :Marks<CR>
" Windows
nnoremap <leader>w :Windows<CR>
" v:oldfiles and open buffers
nnoremap <leader>h :History<CR>
" Command history
nnoremap <leader>H :History:<CR>
" Search history
nnoremap <leader>/ :History/<CR>
" Commands
nnoremap <leader>c :Commands<CR>
" Normal mode mappings
nnoremap <leader>? :Maps<CR>

" ------------------------------------------------------------------------ }}}

" TERMINAL --------------------------------------------------------------- {{{
" Terminal in split window
map <c-\> :term ++close<cr>
" Terminal to Normal mode
tmap <c-\> <C-w>N
" ------------------------------------------------------------------------ }}}
