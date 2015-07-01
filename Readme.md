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

Plugin 'Valloric/YouCompleteMe' in ~/.vimrc

go to vim

:PluginInstall

install clang+llvm 3.6
=======================
copy clang to llvm_root/src/tools

cmake -G "Unix Makefiles" -DCMAKE_INSTALL_PREFIX=/g/g92/uswickra/ClangforVim/llvm-3.6.1/install/ -DCMAKE_C_COMPILER=/usr/apps/gnu/4.9.2/bin/gcc -DCMAKE_CXX_COMPILER=/usr/apps/gnu/4.9.2/bin/g++ -DCMAKE_BUILD_TYPE=Release ../

make && make install

install ycm support libs(use c++11/ 4.7+, python 2.7+)
=======================================================
Note : python library location / paths explicit due to a bug

cmake -G "Unix Makefiles" -DCMAKE_C_COMPILER=/usr/apps/gnu/4.9.2/bin/gcc -DCMAKE_CXX_COMPILER=/usr/apps/gnu/4.9.2/bin/g++ -DPATH_TO_LLVM_ROOT=/g/g92/uswickra/LLVM_ROOT  -DPYTHON_EXECUTABLE=/usr/local/tools/python-2.7.7/bin/python -DPYTHON_LIBRARY=/usr/local/tools/python-2.7.7/lib/libpython2.7.so -DPYTHON_INCLUDE_DIR=/usr/local/tools/python-2.7.7/include/python2.7/ . ~/.vim/bundle/YouCompleteMe/third_party/ycmd/cpp

make ycm_support_libs


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

Custom
=========
Shift + W = expand region
Shift + Q = code usage
Ctrl  + L = format code

