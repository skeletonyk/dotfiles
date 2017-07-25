" this is mostly a matter of taste. but LaTeX looks good with just a bit
" of indentation.
setlocal sw=2
" TIP: if you write your \label's as \label{fig:something}, then if you
" type in \ref{fig: and press <C-n> you will automatically cycle through
" all the figure labels. Very useful!
setlocal iskeyword+=:

setlocal tw=79
setlocal fo=tqcr
setlocal spell spelllang=en_us
setlocal spellfile=~/.vim/spell/en.utf-8.add
setlocal completeopt=longest,menuone,preview

source ~/.vim/myscripts/myTexMappings.vim

" set compiler
if exists('b:vimtex')
    setlocal errorformat=%f:%l:%m
    let s:texMaster = b:vimtex.tex
    " let s:command = 'pdflatex -file-line-error -interaction=nonstopmode -shell-escape '
    let s:command = 'pdflatex -file-line-error -interaction=nonstopmode '
    let &l:makeprg = s:command . s:texMaster . ' && mupdf -C FFFAF0 ' . fnamemodify(s:texMaster, ":r") . '.pdf'
endif
