" File       : markdown.vim
" Date       : Thu Feb 23 09:26:15 2017
" Author     : Fabian Wermelinger
" Description: markdown shit
" Copyright 2017 Fabian Wermelinger. All Rights Reserved.
au! stripWhiteTail
setlocal comments=fb:*,fb:-,fb:+,n:> commentstring=<!--%s-->

" use TeX insert mode maps
source ~/.vim/myscripts/myTexMappings.vim
