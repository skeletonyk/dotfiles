" File:   tex.vim
" Date:   Sat Jul 18 11:10:18 2015
" Author: Fabian Wermelinger
" Tag:    Bug fixed version of the TeX-9 repo
" Copyright 2015 Fabian Wermelinger. All Rights Reserved.

" Disable system wide indentation
let b:did_indent = 1

" Control TeX-9 indentation
if exists("b:did_my_tex_nine_indent") | finish
endif
let b:did_my_tex_nine_indent = 1

setlocal indentexpr=MyTeXNineIndent()
setlocal nolisp
setlocal nosmartindent
setlocal autoindent
setlocal indentkeys+=},=\\item,=\\bibitem

" Only define the function once
if exists("*MyTeXNineIndent") | finish
endif

function s:MySearchBack(lnumStart, pattern)
    let l:uplnum = prevnonblank(a:lnumStart - 1)
    let l:ind    = indent(a:lnumStart)
    let l:pind   = indent(l:uplnum)
    while l:pind >= l:ind
        let l:uplnum = prevnonblank(l:uplnum - 1)
        let l:pind  = indent(l:uplnum)
    endwhile
    let l:pline = getline(l:uplnum)
    return (l:pline =~ a:pattern) ? 1 : 0
endfunction

function MyTeXNineIndent()

    " Find a non-blank line above the current line.
    let lnum = prevnonblank(v:lnum - 1)

    " At the start of the file use zero indent.
    if lnum == 0 | return 0
    endif

    let ind = indent(lnum)
    let pline = getline(lnum)   " first line in the current uprange (previous line)
    let cline = getline(v:lnum) " current line

    " always set zero indent for begin/end{document}, part and chapter
    if cline =~ '^\s*\\\(begin{document}\|end{document}\|chapter\*\=\|part\*\=\|section\*\=\|paragraph\*\=\)\(\[.\+\]\)\={\(.*\)}'
        return 0
    endif

    " Add/remove a 'shiftwidth' for these special rules
    let openingpat = '^\s*\\\(begin\|chapter\*\=\|part\*\=\|section\*\=\|paragraph\*\=\)\(\[.\+\]\)\={\(.*\)}'
    let endpat = '^\s*\\\(end\|section\*\=\|paragraph\*\=\)\(\[.\+\]\)\={\(.*\)}'
    let excluded = '^\s*\\\(begin{document}\|end{document}\|begin{verbatim}\|end{verbatim}\)'

    " special treatments
    let special = '^\s*\\\(bib\)\=item' " \item and \bibitem

    " adjust indentation to previous line
    if pline =~ '^\s*%' && (cline !~ endpat && cline !~ special)
        return ind " Do not change indentation of commented lines.
    endif

    if pline =~ openingpat && pline !~ excluded
        let ind += &sw
    endif

    if cline =~ endpat && cline !~ excluded
        let ind -= &sw
    endif

    if pline =~ special && cline !~ endpat
        let ind += &sw
    endif

    if cline =~ special && pline !~ openingpat
        let ind -= &sw
    endif

    if cline =~ endpat && s:MySearchBack(lnum, special)
        let ind -= &sw
    endif

    return ind
endfunction

" vim: fdm=marker
