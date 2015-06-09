My vim settings


=====
SETUP
======

Install Python
===============
get python 2.7.x (ie:- 2.7.10)
./configure --prefix= --enable-unicode=ucs2 --enable-shared
make 
make install

install VIM 7.4
===============
download from ftp://ftp.vim.org/pub/vim/unix

configure with above  Python

./configure --with-features=huge --enable-multibyte --enable-rubyinterp --enable-pythoninterp --with-python-config-dir=/g/g92/uswickra/Python-2.7.10/install/lib/python2.7/config --enable-perlinterp --enable-luainterp --enable-gui=gtk2 --enable-cscope --prefix=/g/g92/uswickra/vim74/install/

make VIMRUNTIMEDIR=/g/g92/uswickra/vim74

(edit src/Makefile prefix variable if install location is not standard!)
make install

install Vundle
==============
follow git doc

install YCM
=============

cd ~/.vim/bundle/YouCompleteMe
./install.sh --clang-completer

go to vim

:PluginInstall



======================
Shortcuts
======================


Navigate 
=========

Ctrl + I = navigate fwd page/windw

Ctrl + O = navigate back page/windw

Shift + ] = scroll down page

Shift + [ = scroll up page


Tabs
==========

:tabe == open tab for edit

gt == go to next tab

gT = go to prev tab


Format code
=============

gg=G

Go to file
============

gf = go to file on the cursor


Split File
=============

:sp = horiz

:vsp = vertical

Ctrl + w + up/left/down/right arrow == navigate splits

Ctrl + wT = move split to own tab



