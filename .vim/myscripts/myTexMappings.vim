" File       : myTexMappings.vim
" Date       : Thu Mar  9 09:44:32 2017
" Author     : Fabian Wermelinger
" Description: Insert mode TeX mappings
" Copyright 2017 Fabian Wermelinger. All Rights Reserved.

inoremap <buffer> <LocalLeader><CR> \nonumber\\<CR>
inoremap <buffer> <LocalLeader>/  \frac{}{}<Esc>F}i
inoremap <buffer> <LocalLeader>~  \tilde{}<Left>
inoremap <buffer> <LocalLeader>^  \hat{}<Left>
inoremap <buffer> <LocalLeader>_  \bar{}<Left>
inoremap <buffer> <LocalLeader>.  \dot{}<Left>
inoremap <buffer> <LocalLeader>.. \ddot{}<Left>
inoremap <buffer> <LocalLeader>-  \bigcap
inoremap <buffer> <LocalLeader>+  \bigcup
inoremap <buffer> <LocalLeader>@  \circ
inoremap <buffer> <LocalLeader>&  \wedge
inoremap <buffer> <LocalLeader>v  \vee
inoremap <buffer> <LocalLeader>0  \emptyset
inoremap <buffer> <LocalLeader>6  \partial
inoremap <buffer> <LocalLeader>8  \infty
inoremap <buffer> <LocalLeader>=  \equiv
inoremap <buffer> <LocalLeader>\  \setminus
inoremap <buffer> <LocalLeader>*  \times
inoremap <buffer> <LocalLeader><  \langle
inoremap <buffer> <LocalLeader>>  \rangle
inoremap <buffer> <LocalLeader><= \leq
inoremap <buffer> <LocalLeader>>= \geq
inoremap <buffer> <LocalLeader>[  \subseteq
inoremap <buffer> <LocalLeader>]  \supseteq
inoremap <buffer> <LocalLeader>(  \subset
inoremap <buffer> <LocalLeader>)  \supset
inoremap <buffer> <LocalLeader>A  \forall
inoremap <buffer> <LocalLeader>N  \nabla
inoremap <buffer> <LocalLeader>E  \exists
inoremap <buffer> <LocalLeader>qj \downarrow
inoremap <buffer> <LocalLeader>qJ \Downarrow
inoremap <buffer> <LocalLeader>qk \uparrow
inoremap <buffer> <LocalLeader>qK \Uparrow
inoremap <buffer> <LocalLeader>qh \leftarrow
inoremap <buffer> <LocalLeader>qH \Leftarrow
inoremap <buffer> <LocalLeader>ql \rightarrow
inoremap <buffer> <LocalLeader>qL \Rightarrow
inoremap <buffer> <LocalLeader>a  \alpha
inoremap <buffer> <LocalLeader>b  \beta
inoremap <buffer> <LocalLeader>c  \chi
inoremap <buffer> <LocalLeader>d  \delta
inoremap <buffer> <LocalLeader>e  \epsilon
inoremap <buffer> <LocalLeader>f  \phi
inoremap <buffer> <LocalLeader>g  \gamma
inoremap <buffer> <LocalLeader>h  \eta
inoremap <buffer> <LocalLeader>i  \iota
inoremap <buffer> <LocalLeader>k  \kappa
inoremap <buffer> <LocalLeader>l  \lambda
inoremap <buffer> <LocalLeader>m  \mu
inoremap <buffer> <LocalLeader>n  \nu
inoremap <buffer> <LocalLeader>p  \pi
inoremap <buffer> <LocalLeader>q  \theta
inoremap <buffer> <LocalLeader>r  \rho
inoremap <buffer> <LocalLeader>s  \sigma
inoremap <buffer> <LocalLeader>t  \tau
inoremap <buffer> <LocalLeader>y  \psi
inoremap <buffer> <LocalLeader>u  \upsilon
inoremap <buffer> <LocalLeader>w  \omega
inoremap <buffer> <LocalLeader>z  \zeta
inoremap <buffer> <LocalLeader>x  \xi
inoremap <buffer> <LocalLeader>G  \Gamma
inoremap <buffer> <LocalLeader>D  \Delta
inoremap <buffer> <LocalLeader>F  \Phi
inoremap <buffer> <LocalLeader>G  \Gamma
inoremap <buffer> <LocalLeader>L  \Lambda
inoremap <buffer> <LocalLeader>P  \Pi
inoremap <buffer> <LocalLeader>Q  \Theta
inoremap <buffer> <LocalLeader>S  \Sigma
inoremap <buffer> <LocalLeader>U  \Upsilon
inoremap <buffer> <LocalLeader>W  \Omega
inoremap <buffer> <LocalLeader>X  \Xi
inoremap <buffer> <LocalLeader>Y  \Psi
inoremap <buffer> <LocalLeader>ve \varepsilon
inoremap <buffer> <LocalLeader>vf \varphi
inoremap <buffer> <LocalLeader>vk \varkappa
inoremap <buffer> <LocalLeader>vq \vartheta
inoremap <buffer> <LocalLeader>vr \varrho

" Neat insertion of various LaTeX constructs by tapping keys (TeX-9 goodness)
function! IsLeft(lchar)
    let left = getline('.')[col('.')-2]
    return left == a:lchar ? 1 : 0
endfunction
inoremap <buffer><expr> _ IsLeft('_') ? '{}<Left>' : '_'
inoremap <buffer><expr> ^ IsLeft('^') ? '{}<Left>' : '^'
inoremap <buffer><expr> = IsLeft('=') ? '<BS>&=' : '='
inoremap <buffer><expr> ~ IsLeft('~') ? '<BS>\approx' : '~'
inoremap <buffer><expr> $ IsLeft('$') ? '$<Left>' : '$'
