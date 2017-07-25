#!/bin/bash
# uninstall packages
# soft links to config files
cd $HOME
if [[ -e $HOME/.bashrc ]]; then
    mv $HOME/.bashrc $HOME/.bashrc.pre_uninstall
fi
# cp -f /etc/skel/.bashrc $HOME/.bashrc
rm -f $HOME/.bash_aliases
rm -f $HOME/.vimrc
rm -rf $HOME/.vim
rm -f $HOME/.gdbinit
rm -f $HOME/.inputrc
rm -f $HOME/.ctags
rm -f $HOME/.tmux.conf
rm -f $HOME/.dircolors
rm -f $HOME/.gitconfig
rm -f $HOME/.git_template
# rm -f $HOME/.git-prompt-colors.sh
rm -f $HOME/.liquidpromptrc
rm -f $HOME/.liquidprompt.theme
rm -f $HOME/.gdbinit
rm -f $HOME/bin/rg

# rm -rf $HOME/.bash-git-prompt
# rm -rf $HOME/.liquidprompt
# rm -rf $HOME/.tmux

exit 0
