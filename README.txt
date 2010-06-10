In order to make these files usable, execute the following commands:

$ cd $HOME
$ echo "source $HOME/init-config/bashrc" >> $HOME/.bashrc
$ ln -s init-config/inputrc .inputrc
$ ln -s init-config/vimrc .vimrc
$ ln -s init-config/gitignore .gitignore
$ ln -s init-config/gitconfig .gitconfig
$ ln -s init-config/guile .guile
$ cp fix-avi.sh /usr/local/bin
