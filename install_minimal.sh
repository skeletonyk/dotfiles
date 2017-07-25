#! /bin/bash
# File:   install_minimal.sh
# Date:   Wed 23 Sep 2015 11:00:42 PM CEST
# Author: Fabian Wermelinger
# Tag:    Install minimal work environment.  Clone repo from
#         git clone fabianw@scratch-petros.ethz.ch:/home/fabianw/git-repos/dot-files.git
#
#         run with
#         source install_minimal.sh
# Copyright 2015 Fabian Wermelinger. All Rights Reserved.
init()
{
    if [ ! -d "$HOME/.rc" ]; then
        echo "Directory $HOME/.rc does not exist"
        exit 1
    fi

    # soft links to config files
    echo "SETTING CONFIGURATION FILES..."
    cd $HOME
    if [[ -e $HOME/.bashrc ]]; then
        mv $HOME/.bashrc $HOME/.bashrc.pre_install
    fi
    cp -f $HOME/.rc/.bashrc_wrapper $HOME/.bashrc
    ln -sf $HOME/.rc/.vimrc $HOME/.vimrc
    ln -sf $HOME/.rc/.vim $HOME/.vim
    ln -sf $HOME/.rc/.inputrc $HOME/.inputrc
    ln -sf $HOME/.rc/.ctags $HOME/.ctags
    ln -sf $HOME/.rc/.tmux.conf $HOME/.tmux.conf
    ln -sf $HOME/.rc/.gdbinit $HOME/.gdbinit
    ln -sf $HOME/.rc/bin/rg $HOME/bin
}

finalize()
{
    ln -sf $HOME/.rc/.liquidpromptrc $HOME/.liquidpromptrc
    ln -sf $HOME/.rc/.liquidprompt.theme $HOME/.liquidprompt.theme
}

wget_install_tarball()
{
    url="$1"; shift
    package="$1"; shift
    preconf="$1"; shift
    conf="$1"; shift
    postconf="$1"; shift

    echo "INSTALLING $url/${package}.tar.gz"
    cd $LOCAL
    wget --no-check-certificate "$url/${package}.tar.gz"
    tar xzf "${package}.tar.gz"
    rm -f "${package}.tar.gz"
    cd "$package"
    eval "$preconf"
    eval "$conf" "$@"
    eval "$postconf"
}

check_install_tarball_default()
{
    url="$1"; shift
    package="$1"; shift
    if [[ ! -d "$LOCAL/$package" ]]; then
        myredirect wget_install_tarball "$url" "$package" 'default_preconf' 'default_conf' 'default_postconf' "$@"
    else
        echo "Package $package already installed... OK"
    fi
}

git_install()
{
    repo="$1"; shift
    localname="$1"; shift
    preconf="$1"; shift
    conf="$1"; shift
    postconf="$1"; shift

    echo "CLONING $repo"
    cd $LOCAL
    git clone "$repo" "$localname"
    cd "$localname"
    eval "$preconf"
    eval "$conf" "$@"
    eval "$postconf"
}

myredirect() { eval "$@" 2>> $HOME/build_stderr; }
default_preconf() { return; }
default_conf() { ./configure --prefix=$LOCAL "$@"; }
default_postconf() { make -j2; make install; make clean; }

# check these also
AC_INCLUDE=''
if [[ -d '/usr/share/aclocal' ]]; then
    AC_INCLUDE=${AC_INCLUDE}' -I /usr/share/aclocal'
fi
if [[ -d '/usr/local/share/aclocal' ]]; then
    AC_INCLUDE=${AC_INCLUDE}' -I /usr/local/share/aclocal'
fi

# initialize $LOCAL and dot-files in $HOME
mkdir -p $HOME/bin

init
source $HOME/.bashrc # defines LOCAL & PATH
mkdir -p $LOCAL
mkdir -p $LOCAL/bin

GIT=$(command -v git)
if [[ -z "$GIT" ]]; then
    echo "GIT can not be found! Install manually and re-run"
    exit 1
fi

# install dependencies
check_install_tarball_default 'http://ftp.gnu.org/gnu/autoconf' 'autoconf-2.69'
check_install_tarball_default 'http://mirror.switch.ch/ftp/mirror/gnu/automake' 'automake-1.15'
check_install_tarball_default 'ftp://ftp.gnu.org/gnu/libtool' 'libtool-2.4.6'
check_install_tarball_default 'http://pkgconfig.freedesktop.org/releases' 'pkg-config-0.29' --with-internal-glib
check_install_tarball_default 'http://mirror.switch.ch/ftp/mirror/gnu/m4' 'm4-1.4.17'
check_install_tarball_default 'ftp://ftp.csx.cam.ac.uk/pub/software/programming/pcre' 'pcre-8.39'

# install recent git
[[ "$($GIT --version)" =~ ([0-9][.][0-9]*) ]] && version="${BASH_REMATCH[1]}"
if [[ ! -d "$LOCAL/git" && ! "$(awk -v ver="$version" 'BEGIN { if (ver < 2.0) exit 1; }')" ]]; then
    mypreconf() { perl Makefile.PL PREFIX=$LOCAL; }
    myconf() { return; }
    export PERL5LIB=$LOCAL/share/perl5:$PERL5LIB
    myredirect wget_install_tarball 'http://search.cpan.org/CPAN/authors/id/B/BI/BINGOS' 'ExtUtils-MakeMaker-7.24' 'mypreconf' 'myconf' 'default_postconf'
    myredirect wget_install_tarball 'http://search.cpan.org/CPAN/authors/id/B/BI/BINGOS' 'ExtUtils-Command-1.20' 'mypreconf' 'myconf' 'default_postconf'

    mypreconf() { make configure; }
    mypostconf() { make -j2 all; make install; make clean; }
    myredirect git_install 'git://git.kernel.org/pub/scm/git/git.git' 'git' 'mypreconf' 'default_conf' 'mypostconf'
else
    echo "Package git already installed... OK"
fi

# --> managed by vim plugins
# # install fzf
# if [[ ! -d "$LOCAL/fzf" ]]; then
#     mypostconf() { ./install --all; }
#     myredirect git_install 'https://github.com/junegunn/fzf.git' 'fzf' 'default_preconf' 'default_conf' 'mypostconf'
# else
#     echo "Package fzf already installed... OK"
# fi

# install silver searcher
if [[ ! -d "$LOCAL/ag" ]]; then
    mypreconf() { aclocal $AC_INCLUDE; autoconf; autoheader; automake --add-missing; }
    myredirect git_install 'https://github.com/ggreer/the_silver_searcher.git' 'ag' 'mypreconf' 'default_conf' 'default_postconf' --disable-lzma
else
    echo "Package ag already installed... OK"
fi

# install recent vim
mkdir -p "$HOME/.vim/backup"
if [[ ! -d "$LOCAL/vim" ]]; then
    myredirect git_install 'https://github.com/vim/vim.git' 'vim' 'default_preconf' 'default_conf' 'default_postconf' --enable-pythoninterp=yes --with-features=huge

    if [[ ! -d "$HOME/.vim/bundle/vim-plug" ]]; then
        echo "SETTING UP VIM PLUGINS..."
        PLUGMANAGER="$HOME/.vim/bundle/vim-plug"
        myredirect git clone 'https://github.com/junegunn/vim-plug.git' "$PLUGMANAGER"
        cd "$HOME/.vim"
        mkdir -p "autoload"; cd "autoload"
        ln -s ../bundle/vim-plug/plug.vim
        cd
    fi
else
    echo "Package vim already installed... OK"
fi

# install libevent (dependency tmux)
if [[ ! -d "$LOCAL/libevent" ]]; then
    mypreconf() { aclocal -I m4; autoheader; libtoolize; autoconf; automake --add-missing --force-missing --copy; }
    myredirect git_install 'https://github.com/libevent/libevent.git' 'libevent' 'mypreconf' 'default_conf' 'default_postconf'
else
    echo "Package libevent already installed... OK"
fi

# install recent tmux
if [[ ! -d "$LOCAL/tmux" ]]; then
    mypreconf() { sh autogen.sh; mkdir -p etc; aclocal $AC_INCLUDE; automake --add-missing --force-missing --copy --foreign; }
    myredirect git_install 'https://github.com/tmux/tmux.git' 'tmux' 'mypreconf' 'default_conf' 'default_postconf'

    if [[ ! -d "$HOME/.tmux/plugins/tpm" ]]; then
        echo "SETTING UP TMUX PLUGINS..."
        myredirect git clone 'https://github.com/tmux-plugins/tpm' "$HOME/.tmux/plugins/tpm"
    fi
else
    echo "Package tmux already installed... OK"
fi

# install matcher
# if [[ ! -d "$LOCAL/matcher" ]]; then
#     myconf() { return; }
#     mypostconf() { make -j2; ln -s $LOCAL/matcher/matcher $LOCAL/bin; }
#     myredirect git_install 'https://github.com/burke/matcher.git' 'matcher' 'default_preconf' 'myconf' 'mypostconf'
# else
#     echo "Package matcher already installed... OK"
# fi

# setup bash prompt
if [[ ! -d "$HOME/.liquidprompt" ]]; then
    echo "SETTING UP BASH PROMPT..."
    cd $HOME
    myredirect git clone 'https://github.com/nojhan/liquidprompt.git' '.liquidprompt'
else
    echo "Package liquidprompt already installed... OK"
fi
# if [[ ! -d "$HOME/.bash-git-prompt" ]]; then
#     echo "SETTING UP BASH PROMPT..."
#     cd $HOME
#     git clone https://github.com/magicmonty/bash-git-prompt.git .bash-git-prompt
# else
#     echo "Package bash-git-prompt already installed... OK"
# fi

finalize

echo "DONE..."
exit 0
