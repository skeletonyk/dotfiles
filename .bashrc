# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
    *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=5000
HISTFILESIZE=10000
HISTTIMEFORMAT="[%F %T] "

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
#[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
        # We have color support; assume it's compliant with Ecma-48
        # (ISO/IEC-6429). (Lack of such support is extremely rare, and such
        # a case would tend to support setf rather than setaf.)
        color_prompt=yes
    else
        color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
    xterm*|rxvt*)
        PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
        ;;
    *)
        ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    #alias grep='grep --color=auto'
    #alias fgrep='fgrep --color=auto'
    #alias egrep='egrep --color=auto'
fi

# some more ls aliases
#alias ll='ls -l'
#alias la='ls -A'
#alias l='ls -CF'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [[ "$(uname)" == 'Linux' ]]; then
    if ! shopt -oq posix; then
        if [ -f /usr/share/bash-completion/bash_completion ]; then
            . /usr/share/bash-completion/bash_completion
        elif [ -f /etc/bash_completion ]; then
            . /etc/bash_completion
        fi
    fi
elif [[ "$(uname)" == 'Darwin' ]]; then
    if ! shopt -oq posix; then
        if [ -f `brew --prefix`/share/bash-completion/bash_completion ]; then
            . `brew --prefix`/share/bash-completion/bash_completion
        elif [ -f `brew --prefix`/etc/bash_completion ]; then
            . `brew --prefix`/etc/bash_completion
        fi
    fi
fi

# my stuff
###############################################################################
# some tmux helpers
if [ -n "$(which tmux 2>/dev/null)" ]; then
    function tmux() {
    local tmux=$(type -fp tmux)
    case "$1" in
        reorder-windows|reorder|defrag)
            local i=$(tmux show-option -g |awk '/^base-index/ {print $2}')
            local w
            for w in $(tmux lsw | awk -F: '{print $1}'); do
                if [ $w -gt $i ]; then
                    echo "Moving $w -> $i"
                    $tmux movew -d -s $w -t $i
                fi
                (( i++ ))
            done
            ;;
        update-environment|update-env|env-update|envup)
            local v
            while read v; do
                if [[ $v == -* ]]; then
                    unset ${v/#-/}
                else
                    # Add quotes around the argument
                    v=${v/=/=\"}
                    v=${v/%/\"}
                    eval export $v
                fi
            done < <(tmux show-environment)
            ;;
        *)
            $tmux "$@"
            ;;
    esac
}
fi

# toggle XON such that Ctrl-s can be used
[[ $- == *i* ]] && stty -ixon

if [[ "$(uname)" == 'Darwin' ]]; then
    # MAC color support
    export CLICOLOR=1
    # export LSCOLORS=ExFxCxDxBxegedabagacad
    # export LSCOLORS=gxBxhxDxfxhxhxhxhxcxcx
    export LSCOLORS=ExGxbxDxcxdxdxchchBxBx
fi

# support 256 colors
# export TERM=xterm-256color
# export TERM=screen-256color

# Base16 Shell
BASE16_SCHEME="monokai"
# BASE16_SCHEME="eighties"
BASE16_SHELL="$HOME/.config/base16-shell/base16-$BASE16_SCHEME.dark.sh"
[[ -s $BASE16_SHELL ]] && . $BASE16_SHELL

# news reader for SLRN
export NNTPSERVER='news2.informatik.uni-stuttgart.de'

# prompt
HAVE_LIQ_PROMP="$HOME/.liquidprompt"
if [ -d "$HAVE_LIQ_PROMP" ]; then
    # git clone https://github.com/nojhan/liquidprompt.git .liquidprompt
    [[ $- = *i* ]] && source ~/.liquidprompt/liquidprompt
else
    # export PS1="\e[1;32m(\u@\h:\e[m\e[0;32m\w\e[m\e[1;32m)\e[m\n\$>> "
    # export PS1="\e[1;32m(\u@\h:\e[m\e[0;32m\w\e[m\e[1;32m)\e[m\n\!$ "
    export PS1="\e[1;32m(\D{%T}; \u@\h:\e[m\e[0;32m\w\e[m\e[1;32m)\e[m\n\$ "
fi
# HAVE_GIT_PROMP="$HOME/.bash-git-prompt"
# if [ -d "$HAVE_GIT_PROMP" ]; then
#     # https://github.com/magicmonty/bash-git-prompt
#     GIT_PROMPT_FETCH_REMOTE_STATUS=1
#     source "$HAVE_GIT_PROMP/gitprompt.sh"
# else
#     # export PS1="\e[1;32m(\u@\h:\e[m\e[0;32m\w\e[m\e[1;32m)\e[m\n\$>> "
#     # export PS1="\e[1;32m(\u@\h:\e[m\e[0;32m\w\e[m\e[1;32m)\e[m\n\!$ "
#     export PS1="\e[1;32m(\D{%T}; \u@\h:\e[m\e[0;32m\w\e[m\e[1;32m)\e[m\n\$ "
# fi
