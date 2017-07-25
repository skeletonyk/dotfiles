" File       : vimwiki.vim
" Date       : Mon Jun 13 08:05:52 2016
" Author     : Fabian Wermelinger
" Description: Vimwiki ft settings
" Copyright 2016 Fabian Wermelinger. All Rights Reserved.
setlocal shiftwidth=2
setlocal nowrap
setlocal fo=tqcrl
setlocal spell spelllang=en_us
setlocal spellfile=~/.vim/spell/en.utf-8.add
inoremap <C-E> <C-R>=UltiSnips#ExpandSnippet()<CR>
