" File:   .vimrc
" Date:   Sun 12 Oct 2014 02:17:57 PM CEST
" Author: Fabian Wermelinger
" Tag:    Vim runtime configuration... RUN, RUN!!
" Copyright © 2014 Fabian Wermelinger. All Rights Reserved.

set nocompatible " be iMproved, required
set encoding=utf-8

" Plugin management {{{1
call plug#begin('~/.vim/bundle')

" self management
Plug 'junegunn/vim-plug'
Plug 'scrooloose/nerdtree'
" GitHub repos {{{2
Plug 'chriskempson/base16-vim'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-speeddating'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-abolish'
Plug 'tpope/vim-obsession'
Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-vinegar'
" Plug 'tpope/vim-markdown'
Plug 'plasticboy/vim-markdown'
" Plug 'nelstrom/vim-markdown-folding'
" Plug 'jceb/vim-orgmode'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'Lokaltog/vim-easymotion'
" Plug 'MarcWeber/vim-addon-mw-utils'
" Plug 'tomtom/tlib_vim'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'rbonvall/snipmate-snippets-bib'
Plug 'octol/vim-cpp-enhanced-highlight'
Plug 'godlygeek/tabular'
Plug 'junegunn/vim-easy-align'
Plug 'junegunn/fzf', { 'dir': '~/local/fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'vim-scripts/gnuplot.vim'
" Plug 'kien/ctrlp.vim'
" Plug 'rking/ag.vim'
" Plug 'scrooloose/syntastic'
" Plug 'fab4100/TeX-9'
"
" This is new by Ke
Plug 'pseewald/vim-anyfold'
Plug 'Konfekt/FastFold'
" Plug 'Konfekt/FoldText'
Plug 'lervag/vimtex'
Plug 'majutsushi/tagbar'
" Plug 'ajh17/VimCompletesMe'
Plug 'tmux-plugins/vim-tmux'
Plug 'qpkorr/vim-bufkill'
Plug 'airblade/vim-gitgutter'
Plug 'fab4100/vim-operator-highlight'
Plug 'vhdirk/vim-cmake'
" Plug 'vimwiki/vimwiki'
" Plug 'vim-pandoc/vim-pandoc'
" Plug 'vim-pandoc/vim-pandoc-syntax'
" Plug 'tbabej/taskwiki'
" Plug 'mattn/webapi-vim'
" Plug '7kfpun/finance.vim' " depends on webapi-vim

" Git repos not on GitHub {{{2
" Plug 'git://git.code.sf.net/p/vim-latex/vim-latex'

" scripts from http://vim-scripts.org/vim/scripts.html {{{2
" Plug 'L9'
" Plug 'FuzzyFinder'
" }}}2

" Add plugins to &runtimepath
call plug#end()

filetype plugin indent on " already done by plug#end() above...
" To ignore plugin indent changes, instead use:
" filetype plugin on

" Color scheme & syntax highlighting {{{1
" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
    " new Ke
    filetype plugin indent on
    syntax on
    let anyfold_activate=1
    set foldlevel=0

    set background=dark
    "let base16colorspace=256
    " colorscheme base16-eighties
    colorscheme base16-monokai
endif

" redefine cterm groups for spell checks
highlight SpellBad   cterm=bold,underline ctermfg=15 ctermbg=18
highlight SpellCap   cterm=bold,underline ctermfg=15 ctermbg=18
highlight SpellRare  cterm=bold,underline ctermfg=15 ctermbg=18
highlight SpellLocal cterm=bold,underline ctermfg=15 ctermbg=18

" highlight CursorLine term=underline ctermbg=19
" highlight CursorColumn term=reverse ctermbg=19
" highlight ColorColumn term=reverse ctermbg=19
" highlight Folded term=standout cterm=bold ctermfg=8 ctermbg=18
" highlight Folded term=standout ctermfg=18 ctermbg=20
" highlight FoldColumn term=standout ctermfg=6 ctermbg=20

" redefine cterm groups for incremental search
highlight IncSearch ctermfg=18 ctermbg=9

" c++ macro highlighting
hi link cCppOut2 PreProc

" Environment variables {{{1
"  tabbing & indent {{{2
set textwidth=79
set expandtab
set tabstop=4
set softtabstop=4
set shiftwidth=4
set autoindent
set smartindent

"  general editing & look {{{2
" set cpoptions+=J "sentence ends with 2x space
set cinoptions=g0,+0,t0
set cursorline
set scrolloff=3
set list
set listchars=tab:▸\ ,eol:¬
set backspace=indent,eol,start
set hidden
set incsearch
set ignorecase
set smartcase
set hlsearch
set showmatch
set history=50
set laststatus=2 " air-line
set ttimeoutlen=50
set previewheight=18
set printoptions=number:y
set ruler
set showcmd
set colorcolumn=+1
set relativenumber
set number
set backup
set backupdir=~/.vim/backup,.
" set backupdir=/tmp
set swapfile
set diffopt=filler,context:4,vertical
" set nofoldenable                  " disable code folding
if $TMUX == ''
    set clipboard+=unnamed
endif
set wildmenu                      " enable bash style tab completion
set wildmode=list:longest,full
set tags=./tags;
runtime! macros/matchit.vim        " use % to jump between start/end of methods

" Mappings {{{1
let mapleader = ","
let maplocalleader = "`"
" All modes {{{2
noremap ; :

" Normal mode {{{2
nnoremap J 5j
nnoremap K 5k
nnoremap <silent> <C-l> :nohlsearch<CR><C-l>
nnoremap <leader>ct :call MakeCTags()<CR>
nnoremap <leader>cd :cd %:p:h<CR>:pwd<CR>
nnoremap <leader>ev :edit $HOME/.rc/.vimrc<CR>
nnoremap <leader>sv :source $MYVIMRC<CR>
nnoremap <leader>pwd :echo expand('%:p')<CR>
nnoremap <leader>l :setlocal list!<CR>
nnoremap <leader>w :setlocal wrap!<CR>
nnoremap <leader>sp :set paste<CR>
nnoremap <leader>snp :set nopaste<CR>
nnoremap <silent> <C-k> :bn<CR>
nnoremap <silent> <C-j> :bp<CR>
nnoremap <silent> <C-p> :b #<CR>
" nnoremap <silent> <leader>p :b #<CR>

" Insert mode {{{2
inoremap <C-U> <C-G>u<C-U>
inoremap <C-a> <Esc>la

" Abbreviations {{{1
" Insert mode {{{2
iabbrev teh the
iabbrev hte the
iabbrev taht that
iabbrev waht what
iabbrev accross across

" Plugin settings {{{1
" fzf.vim {{{2
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:fzf_buffers_jump = 1

" This is the default extra key bindings
let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-x': 'split',
  \ 'ctrl-v': 'vsplit' }

" Default fzf layout
" - down / up / left / right
let g:fzf_layout = { 'down': '~40%' }

" Customize fzf colors to match your color scheme
let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }

" Enable per-command history.
" CTRL-N and CTRL-P will be automatically bound to next-history and
" previous-history instead of down and up. If you don't like the change,
" explicitly bind the keys to down and up in your $FZF_DEFAULT_OPTS.
let g:fzf_history_dir = '~/.local/share/fzf-history'

nnoremap <silent> <leader><space> :Files<CR>
nnoremap <silent> <leader>j :Buffers<CR>
nnoremap <silent> <leader>i :Marks<CR>
nnoremap <silent> <leader>k :Windows<CR>
nnoremap <silent> <leader>bl :BLines<CR>
nnoremap <silent> <leader>t :Tags<CR>
nnoremap <silent> <leader>bt :BTags<CR>
nnoremap <silent> <leader>? :History<CR>
nnoremap <silent> <leader>/ :execute 'Ag ' . input('Ag/')<CR>
nnoremap <silent> <leader>ai :AgIn

nnoremap <silent> <leader>a :Ag<CR>
nnoremap <silent> <leader>A :call SearchWordWithAg()<CR>
vnoremap <silent> <leader>A :call SearchVisualSelectionWithAg()<CR>
nnoremap <silent> <leader>c :Commits<CR>
nnoremap <silent> <leader>bc :BCommits<CR>
nnoremap <silent> <leader>ft :Filetypes<CR>

imap <C-x><C-s> <plug>(fzf-complete-file-ag)
imap <C-x><C-l> <plug>(fzf-complete-line)

function! SearchWordWithAg()
    execute 'Ag' expand('<cword>')
endfunction

function! SearchVisualSelectionWithAg() range
    let old_reg = getreg('"')
    let old_regtype = getregtype('"')
    let old_clipboard = &clipboard
    set clipboard&
    normal! ""gvy
    let selection = getreg('"')
    call setreg('"', old_reg, old_regtype)
    let &clipboard = old_clipboard
    execute 'Ag' selection
endfunction

function! SearchWithAgInDirectory(...)
    call fzf#vim#ag(join(a:000[1:], ' '), extend({'dir': a:1}, g:fzf#vim#default_layout))
endfunction
command! -nargs=+ -complete=dir AgIn call SearchWithAgInDirectory(<f-args>)

" " ctrlp {{{2
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" " nnoremap <silent> <leader>t :CtrlPTag<CR>
" " let g:ctrlp_map = '<leader>f'
" let g:ctrlp_match_window = 'bottom,order:ttb,min:1,max:10,results:50'
" let g:ctrlp_working_path_mode = 'ra'
" let g:ctrlp_open_multiple_files = 'i'
" let g:ctrlp_open_new_file = 'r'
" let g:ctrlp_mruf_default_order = 1
" let g:ctrlp_follow_symlinks = 1
" let g:ctrlp_show_hidden = 1
" let g:ctrlp_extensions = ['tag', 'buffertag']
" " let g:ctrlp_extensions = ['line', 'tag', 'buffertag', 'mixed', 'dir',
" "             \ 'quickfix', 'rtscript', 'undo', 'changes', 'bookmarkdir']
" let g:ctrlp_use_caching = 1
" let g:ctrlp_clear_cache_on_exit = 0
" let g:ctrlp_cache_dir = $HOME.'/.cache/ctrlp'
" " let g:ctrlp_max_files = 0
" let g:ctrlp_user_command = {
"     \ 'types': {
"     \ 1: ['.git', 'cd %s && git ls-files . --cached --exclude-standard --others'],
"     \ 2: ['.hg', 'hg --cwd %s locate -I .'],
"     \ },
"     \ 'fallback': 'find %s -type f'}

" " use silver searcher for ctrlp
" if executable('ag')
"   " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
"   let g:ctrlp_user_command.fallback = 'ag %s -l -f -S --noaffinity --hidden --nocolor --nogroup -g ""'
"   " let g:ctrlp_use_caching = 0
" endif

" if executable('matcher')
"     let g:ctrlp_match_func = { 'match': 'GoodMatch' }

"     function! GoodMatch(items, str, limit, mmode, ispath, crfile, regex)
"       " Create a cache file if not yet exists
"       let cachefile = ctrlp#utils#cachedir().'/matcher.cache'
"       if !( filereadable(cachefile) && a:items == readfile(cachefile) )
"         call writefile(a:items, cachefile)
"       endif
"       if !filereadable(cachefile)
"         return []
"       endif

"       " a:mmode is currently ignored. In the future, we should probably do
"       " something about that. the matcher behaves like "full-line".
"       let cmd = 'matcher --limit '.a:limit.' --manifest '.cachefile.' '
"       if !( exists('g:ctrlp_show_hidden') && g:ctrlp_show_hidden )
"         let cmd = cmd.'--no-dotfiles '
"       endif
"       let cmd = cmd.a:str

"       return split(system(cmd), "\n")

"     endfunction
" end

" " let g:ctrlp_buffer_func = { 'enter': 'MyCtrlPMappings' }
" " func! MyCtrlPMappings()
" "     nnoremap <buffer> <silent> <c-m> :call <sid>DeleteBuffer()<cr>
" " endfunc

" " func! s:DeleteBuffer()
" "     let line = getline('.')
" "     let bufid = line =~ '\[\d\+\*No Name\]$' ? str2nr(matchstr(line, '\d\+'))
" "         \ : fnamemodify(line[2:], ':p')
" "     exec "bd" bufid
" "     exec "norm \<F5>"
" " endfunc

" " ag {{{2
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" if executable('ag')
"   " Use ag over grep
"   set grepprg=ag\ --nogroup\ --nocolor

"   let g:ag_prg="ag -S -f -F --column --noaffinity"
"   map <leader>a :Ag!<space>

"   " search for word under cursor with Silver Searcher
"   map <leader>A :Ag! "<C-r>=expand('<cword>')<CR>"
" endif

" UltiSnips {{{2
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:UltiSnipsEditSplit = "vertical"

" Airline {{{2
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#fnamemod = ':t'
let g:airline#extensions#tabline#buffer_nr_show = 1

if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif

" default theme
let g:airline_theme='base16'

" unicode symbols
let g:airline_left_sep = '»'
let g:airline_right_sep = '«'
" let g:airline_symbols.linenr = '␤'
" let g:airline_symbols.branch = '⎇'
" let g:airline_symbols.paste = 'Þ'
let g:airline_symbols.notexists = '∄'
" let g:airline_symbols.whitespace = 'Ξ'

" " Syntastic {{{2
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" set passive
" let g:syntastic_mode_map = { "mode": "passive",
"             \ "active_filetypes": [],
"             \ "passive_filetypes": [] }

" LaTeX {{{2
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:tex_flavor = 'latex'
let g:tex_comment_nospell = 1
let g:tex_fold_enabled = 1

" bufkill {{{2
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:BufKillOverrideCtrlCaret = 1

" vim-fugitive {{{2
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nnoremap <leader>gs :Gstatus<CR>
nnoremap <leader>gc :Gcommit<CR>
nnoremap <leader>ga :Gwrite<CR>
nnoremap <leader>gac :Gwrite<CR>:Gcommit<CR>
nnoremap <leader>gl :silent Glog -n 25 --<CR>
nnoremap <leader>glf :silent Glog -n 35 -- %<CR>
nnoremap <leader>gd :Gdiff<CR>
nnoremap <leader>gb :Gblame<CR>
nnoremap <leader>gp :Gpush<CR>
nnoremap <leader>gpl :Gpull<CR>

" vim-dispatch {{{2
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nnoremap <leader>d :silent Dispatch<CR>

" tagbar {{{2
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nnoremap <silent> <leader>tb :TagbarToggle<CR>

" GitGutter {{{2
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:gitgutter_signs = 0
let g:gitgutter_max_signs = 1000
let g:gitgutter_highlight_lines = 0

" " vimwiki {{{2
" """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" map <Leader>tt <Plug>VimwikiToggleListItem
" let g:vimwiki_hl_headers = 1
" let g:vimwiki_hl_cb_checked = 1
" let g:vimwiki_global_ext = 0
" " let g:vimwiki_folding = 'expr'

" let mywiki = {}
" let mywiki.syntax = 'markdown'
" " let mywiki.ext = '.md'
" let mywiki.path = '~/wiki/'
" let mywiki.path_html = '~/wiki/html/'
" let mywiki.template_path = '~/wiki/templates/'
" let mywiki.template_default = 'def_template'
" let mywiki.template_ext = '.html'
" let mywiki.auto_toc = 1
" let mywiki.auto_tags = 1
" let g:vimwiki_list = [mywiki]

" function! VimwikiLinkHandler(link)
"     " Use Vim to open external files with the 'vfile:' scheme.  E.g.:
"     "   1) [[vfile:~/Code/PythonProject/abc123.py]]
"     "   2) [[vfile:./|Wiki Home]]
"     let link = a:link
"     if link =~# '^vfile:'
"         let link = link[1:]
"     else
"         return 0
"     endif
"     let link_infos = vimwiki#base#resolve_link(link)
"     if link_infos.filename == ''
"         echomsg 'Vimwiki Error: Unable to resolve link!'
"         return 0
"     else
"         exe 'edit ' . fnameescape(link_infos.filename)
"         return 1
"     endif
" endfunction

" " finance {{{2
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" let g:finance_watchlist = ['USDCHF=X', 'EURCHF=X', 'EURUSD=X', 'GCQ16.CMX', 'CLN16.NYM',
"             \ 'DIA', '^IXIC', '^GSPC', '^RUA', '^TNX', 'RTS.RS', '000001.SS', '^VIX', '^VXD', '^VXN',
"             \ 'MXL.V', 'KNT.V']
" let g:finance_format = '{symbol}: {LastTradePriceOnly} '.
"             \ '({PreviousClose} {Change} [{ChangeinPercent}])'
" let g:finance_separator = "\n"

" operator highlighting {{{2
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:ophigh_colorA = 1
let g:ophigh_colorB = 6
" let g:ophigh_colorB = 17
" let g:ophigh_colorA = 20

" " YouCompleteMe {{{2
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" set completeopt-=preview
" let g:ycm_add_preview_to_completeopt = 0
" let g:ycm_key_list_select_completion = ['<C-n>']
" let g:ycm_key_list_previous_completion = ['<C-p>']
" let g:ycm_cache_omnifunc = 1
" let g:ycm_key_invoke_completion = '<C-h>'

" TODO: (fabianw@mavt.ethz.ch; Mon Dec 12 21:19:43 2016) migh not be needed
" anymore later on when vimtex is ste up (also some stuff in after/)
" let g:ycm_semantic_triggers =  {
"             \   'tex' : ['re!{(.*,\s*|\s*)*}?[^, ]']
"             \ }

" vimtex {{{2
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:vimtex_mappings_enabled = 1
let g:vimtex_echo_ignore_wait = 1
let g:vimtex_disable_version_warning = 1
let g:vimtex_compiler_latexmk = {
            \ 'background' : 0,
            \ 'callback' : 0,
            \ 'continuous' : 0}

" " vimtex plugin setting for YouCompleteMe
" if !exists('g:ycm_semantic_triggers')
"     let g:ycm_semantic_triggers = {}
" endif
" let g:ycm_semantic_triggers.tex = [
"             \ 're!\\[A-Za-z]*cite[A-Za-z]*(\[[^]]*\]){0,2}{[^}]*',
"             \ 're!\\[A-Za-z]*ref({[^}]*|range{([^,{}]*(}{)?))',
"             \ 're!\\hyperref\[[^]]*',
"             \ 're!\\includegraphics\*?(\[[^]]*\]){0,2}{[^}]*',
"             \ 're!\\(include(only)?|input){[^}]*',
"             \ 're!\\\a*(gls|Gls|GLS)(pl)?\a*(\s*\[[^]]*\]){0,2}\s*\{[^}]*',
"             \ 're!\\includepdf(\s*\[[^]]*\])?\s*\{[^}]*',
"             \ 're!\\includestandalone(\s*\[[^]]*\])?\s*\{[^}]*',
"             \ ]

" easy-align {{{2
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

" vim-markdown {{{2
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nnoremap <leader>toc :Toc<CR>
let g:vim_markdown_math = 1
let g:vim_markdown_conceal = 0
" let g:vim_markdown_no_default_key_mappings = 1
let g:vim_markdown_folding_disabled = 0
let g:vim_markdown_override_foldtext = 0
let g:vim_markdown_toc_autofit = 1
let g:vim_markdown_new_list_item_indent = 2
" let g:vim_markdown_folding_style_pythonic = 1

" Functions {{{1
function! CommentStart()
    let [L, R] = split(substitute(substitute(get(b:, 'commentary_format', &commentstring),'\S\zs%s',' %s','') ,'%s\ze\S', '%s ', ''), '%s', 1)
    return L
endfunction

function! CommentEnd()
    let [L, R] = split(substitute(substitute(get(b:, 'commentary_format', &commentstring),'\S\zs%s',' %s','') ,'%s\ze\S', '%s ', ''), '%s', 1)
    return R
endfunction

function! CustomFoldText(delim)
  " https://github.com/Konfekt/FoldText
  let fs = v:foldstart
  while getline(fs) =~ '^\s*$' | let fs = nextnonblank(fs + 1)
  endwhile
  if fs > v:foldend
      let line = getline(v:foldstart)
  else
      let line = substitute(getline(fs), '\t', repeat(' ', &tabstop), 'g')
  endif

  " indent foldtext corresponding to foldlevel
  let indent = repeat(' ',shiftwidth())
  let foldLevelStr = repeat(indent, v:foldlevel-1)
  let foldLineHead = substitute(line, '^\s*', foldLevelStr, '') . ' '

  " size foldtext according to window width
  let w = winwidth(0) - &foldcolumn - (&number ? &numberwidth : 0)
  let foldSize = 1 + v:foldend - v:foldstart

  " estimate fold length
  let foldSizeStr = " " . foldSize . " lines "
  let lineCount = line("$")
  if has("float")
    try
      let foldPercentage = "[" . printf("%4s", printf("%.1f", (foldSize*1.0)/lineCount*100)) . "%] "
    catch /^Vim\%((\a\+)\)\=:E806/  " E806: Using Float as String
      let foldPercentage = printf("[of %d lines] ", lineCount)
    endtry
  endif

  " build up foldtext
  let foldLineTail = foldSizeStr . foldPercentage
  let lengthTail = strwidth(foldLineTail)
  let lengthHead = w - (lengthTail + indent)

  if strwidth(foldLineHead) > lengthHead
    let foldLineHead = strpart(foldLineHead, 0, lengthHead-2) . '..'
  endif

  let lengthMiddle = w - strwidth(foldLineHead.foldLineTail)

  " truncate foldtext according to window width
  let expansionString = repeat(a:delim, lengthMiddle)

  let foldLine = foldLineHead . expansionString . foldLineTail
  return foldLine
endfunction

set foldtext=CustomFoldText('-')


function! <SID>IndentCurrentBuffer()
    " Preparation: save last search, and cursor position.
    let _s=@/
    let l = line(".")
    let c = col(".")
    normal H
    let topline = line(".")
    normal gg=G
    " Clean up: restore previous search history, and cursor position
    let @/=_s
    call cursor(topline, 0)
    normal zt
    call cursor(l, c)
endfunction

function! <SID>StripTrailingWhitespaces()
    " Preparation: save last search, and cursor position.
    let _s=@/
    let l = line(".")
    let c = col(".")
    " Do the business:
    %s/\s\+$//e
    " Clean up: restore previous search history, and cursor position
    let @/=_s
    call cursor(l, c)
endfunction

let s:vcs_targets = ['.git', '.hg', '.svn', '.bzr']
function! FindRootVCS(parent,returnEmpty)
    " Find 'targets' in upwards direction starting from 'start'
    let l:start = expand('%:p:h')
    if empty(l:start)
        let l:start = getcwd()
    endif
    for target in s:vcs_targets
        let l:pfound = finddir(target, l:start . ';')
        if !empty(l:pfound)
            if a:parent == 1
                let l:pfound = fnamemodify(l:pfound, ':h')
                return fnamemodify(l:pfound, ':p:h')
            else
                return fnamemodify(l:pfound, ':p:h')
            endif
        endif
    endfor
    if a:returnEmpty == 1
        return ''
    else
        return l:start
    endif
endfunction

function! MakeCTags()
    " first priority
    let l:root = FindRootVCS(0,1)
    if empty(l:root)
        if exists('b:vimtex')
            let l:root = b:vimtex.root
        else
            let l:root = getcwd()
        endif
        let l:tags = l:root . '/tags'
    else
        let l:tags = l:root . '/tags'
        let l:root = FindRootVCS(1,1)
    endif
    execute ":silent !" . "ctags --tag-relative -R -f " . l:tags . " --languages=-javascript,sql " . l:root . " >/dev/null 2>&1 &"
    execute ":redraw!"
endfunction

function! MyPostPlugins()
    if exists(":Files")
        delcommand Files
        command! -bang -nargs=? -complete=dir Files call fzf#vim#files(FindRootVCS(1,0), <bang>0)
        command! -bang -nargs=? -complete=dir FFiles call fzf#vim#files(<q-args>, <bang>0)
        command! -bang -nargs=? -complete=dir TFiles call fzf#vim#files($HOME.'/code/tools', <bang>0)
    endif
"    if exists(":Ag")
"        delcommand Ag
"        command! -bang -nargs=* Ag call fzf#vim#ag(<q-args>, extend({'dir': FindRootVCS(1,0)}, g:fzf#vim#default_layout), <bang>0)
"        command! -bang -nargs=* AAg call fzf#vim#ag(<q-args>, <bang>0)
"        command! -bang -nargs=* TAg call fzf#vim#ag(<q-args>, extend({'dir': $HOME.'/code/tools'}, g:fzf#vim#default_layout), <bang>0)
"    endif
endfunction

" Old functions {{{2
" function! FindTeXMaster(parent)
"     " Find the TeX master file in a multi-file project
"     let l:root = FindRoot("*.tex.master", a:parent)
"     if empty(l:root)
"         return ''
"     else
"         return l:root . fnamemodify(glob(fnamemodify(a:parent, ':p') . l:root . '*.master'), ':t:r')
"     endif
" endfunction

" function! AddTeXMaster(parent)
"     " Add modeline for TeX master file
"     let l:master = FindTeXMaster(a:parent)
"     if empty(l:master)
"         return
"     else
"         let l:fail = append(line('$'), '% mainfile: ' . l:master)
"         if l:fail
"             echoe "Can't add TeX master modeline"
"         endif
"     endif
" endfunction

" function! OpenTeXMaster(parent)
"     " Open TeX master file if there
"     let l:must_open = 0
"     if exists('g:TeXmaster_name')
"         let l:must_open = bufloaded(g:TeXmaster_name)
"     endif
"     if l:must_open == 0
"         let l:texmaster = FindTeXMaster(a:parent)
"         if empty(l:texmaster)
"             return
"         else
"             execute "edit " . a:parent . "/" . l:texmaster
"             setlocal filetype=tex
"             let g:TeXmaster_name = bufname('%')
"             execute "buffer #"
"         endif
"     endif
" endfunction

" Autocommands {{{1
" Only do this part when compiled with support for autocommands.
if has("autocmd")

    " vimrcEx {{{2
    " Put these in an autocmd group, so that we can delete them easily.
    augroup vimrcEx
        au!
        autocmd FileType text setlocal textwidth=79
        autocmd FileType netrw setlocal bufhidden=delete

        " When editing a file, always jump to the last known cursor position.
        " Don't do it when the position is invalid or when inside an event handler
        " (happens when dropping a file on gvim).
        " Also don't do it when the mark is in the first line, that is the default
        " position when opening a file.
        autocmd BufReadPost *
                    \ if line("'\"") > 1 && line("'\"") <= line("$") |
                    \   exe "normal! g`\"" |
                    \ endif
    augroup END

    " postPlugins {{{2
    augroup postPlugins
        autocmd!
        autocmd VimEnter * call MyPostPlugins()
    augroup END

    " myFileTypeMods {{{2
    augroup myFileTypeMods
        au!
        autocmd FileType vim setlocal foldmethod=marker
        autocmd FileType c,cpp setlocal formatoptions-=o
        autocmd FileType python let b:dispatch = 'python %'  " vim-dispatch
        autocmd BufEnter * if &filetype == "" | setlocal ft=text | endif
        autocmd BufNewFile,BufFilePre,BufRead *.md setlocal filetype=markdown
        " autocmd BufEnter *.cu,*.cuh nested setlocal ft=cuda.cpp.c
    augroup END

    " TeX {{{2
    augroup TeX
        au!
        " TeX stuff
        autocmd BufRead,BufNewFile *.tikz setlocal filetype=tex
        autocmd BufWritePre,FileWritePre *.tex call <SID>IndentCurrentBuffer()
        autocmd BufWritePost *.tex call MakeCTags()
    augroup END

    " stripWhiteTail {{{2
    augroup stripWhiteTail
        au!
        " Remove trailing white space when saving a file
        autocmd BufWritePre,FileWritePre * call <SID>StripTrailingWhitespaces()
    augroup END

    " Not related to a group {{{2
    " not related to a group
    autocmd BufReadPost fugitive://* setlocal bufhidden=delete

endif " has("autocmd")

" Miscellaneous {{{1
" DiffOrig {{{2
" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
    command DiffOrig vert new | set bt=nofile | r ++edit # | 0d_ | diffthis
                \ | wincmd p | diffthis
endif

" Notes {{{2
" Stuff for note taking
function! s:EditMRUNote()
    let mrufile = expand("$DIARY") . '/00_latest'
    let diary_mru = readfile(mrufile,'',1)[0]
    execute ":redraw!"
    execute ":edit " diary_mru
endfunction

command! NewNote execute ':silent !diarymakenote' | call s:EditMRUNote()
command! MRUNote call s:EditMRUNote()
command! UpdateDiaryIndex execute ':silent !diarymakeindex' | execute ':redraw!'
command! -nargs=+ -complete=dir SearchNotes call SearchWithAgInDirectory($DIARY, <f-args>)

nnoremap <leader>nn :NewNote<CR>
nnoremap <leader>en :MRUNote<CR>
nnoremap <leader>ei :edit $DIARY/index.md<CR>
nnoremap <leader>ed :edit $DIARY/diary.md<CR>
nnoremap <leader>ud :UpdateDiaryIndex<CR>
