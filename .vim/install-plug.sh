mkdir -p bundle; cd bundle;
git clone 'https://github.com/junegunn/vim-plug.git'
cd ..
mkdir -p autoload; cd autoload
ln -s ../bundle/vim-plug/plug.vim
