# EASY SETUP
In `master` and branch `05_19`, VIM is self contained with plugins -- so you don't need to install Vundle/plugins.
YCM is disabled because of too much overhead and time to fix it for each platform!
However, if you wish you may still setup vim from source, install plugins and YCM from below instructions (goto `Hard Setup`).

You have to setup syntastic for proper c/c++ syntax checking and clang library path for clang autocompletion support.

1. First Setup scripts for syntastic - For large projets syntastic scripts could generate `.syntastic_c_config` and `.syntastic_cpp_config` files. It will generate better config files if a `.syntastic_cbuild` file is available under project root directory. `.syntastic_cbuild` contains compile flags and options in one line. (i.e. use verbose option in `make` or `cmake` build to extract it) 
```bash
$ export PATH=~/.vim/scripts/:$PATH
$
$ mkproj
$ .syntastic_cbuild found! generating...done
$ 
$ cat .syntastic_cbuild
$ -fsyntax-only -std=gnu99 -I. -I.. -Iinclude -Iincludes -I../include -I../includes -I/mytrees/path/core/. -m64 -O1 -fomit-frame-pointer -fno-align-functions -fno-align-jumps -fno-align-loops -fno-align-labels -fno-reorder-blocks -fno-reorder-blocks-and-partition -fno-prefetch-loop-arrays -fno-tree-vect-loop-version -fno-inline-functions-called-once -fno-function-cse -fno-unsafe-loop-optimizations -Wchar-subscripts -Wcast-align -Wcomment -Wdisabled-optimization -Wextra -Wformat -Wno-unused-parameter -Wformat-security -Wimplicit -Winit-self -Wmain -Wmissing-braces -Wmissing-declarations -Wmissing-field-initializers -Wmissing-prototypes -Wnonnull -Wparentheses -Wpointer-sign -Wreturn-type -Wsequence-point -Wsign-compare -Wstrict-aliasing=2 -Wstrict-prototypes -Wswitch -Wunused-function -Wunused-label -Wunused-variable -Wvolatile-register-var -Wwrite-strings -W -Wdeclaration-after-statement -std=gnu89 -Wno-unused-parameter -Wpointer-arith -mcmodel=medium -mlarge-data-threshold=1073741824  -I../build/gobuild/path/
$
$ less .syntastic_c_config
-fsyntax-only
-std=gnu99
-I.
-I..
-Iinclude
...

```

2. In `.vimrc` set `let g:clang_library_path = '/path/to/libclang'`

3. For OSX set `let g:UltiSnipsExpandTrigger="<C-space>"`

### Debug `Syntastic` 
Use following commands inside vim for debugging.
```bash
:let g:syntastic_debug=3
:let g:syntastic_debug_file = "~/syntastic.log"
```

## Shortcuts

### `In-Editor`

Keys         | Description
------------ | -------------
F8           | Class/Structure View (code)
F4/5         | Copyright/Function definition
(Ctrl+x)+(Ctrl+o) |  auto complete
Ctrl + j | Search all files (Far)
Ctrl + f | Search/refactor
Ctrl + space | Auto code Snippets
Shift + W | expand region
Shift + Q |  code usage
Shift + Up |  move line up
Shift + Down |  move line down
Ctrl  + L |  format code  (gg=G for crude formatting)
Ctrl + g |  jump to definition/declearation (uses ctags, do 'ctags -R . *'
Ctrl + D |  duplicate line
Ctrl + c   |  copy/paste
Ctrl + v   | 

### `Navigate` 

Keys         | Description
------------ | -------------
Ctrl + I | navigate fwd page/windw
Ctrl + O | navigate back page/windw
Shift + ] | scroll down page
Shift + [ | scroll up page


### `Code-Complete`

Keys         | Description
------------ | -------------
Ctrl + g     | jump to definition/decl (ctags)
Ctrl + a     | find assignments to this symbol (cscope)
Ctrl + s     | find this symbol (cscope)
Ctrl + c     | find functions calling this func (cscope)
Ctrl + d     | find functions called by this func (cscope)
(Ctrl+Space) + &lt;cmd&gt;  | find with cscope; open in vertical plane (cscope)
(Ctrl+Space)(Ctrl+Space) + &lt;cmd&gt;  | find with cscope; open in horizontal plane (cscope)
(Ctrl+x)+(Ctrl+o) |  auto complete

To build ctags Database:
```bash
$ ctags -R *
```

To build Cscope Database:
```bash
$ csope -R 
```


### `Navigate-Nerd tree`

Keys         | Description
------------ | -------------
Shift + N | open new tab
Shift + R | update tree for any new files
t | open file under cursor in new tab
Enter | open in the same tab
Ctrl + W + arrow_key | navigate tabs

#### `Tabs`

Keys         | Description
------------ | -------------
:tabe | open tab for edit
gt | go to next tab
gT | go to prev tab


### `Format code`

Keys         | Description
------------ | -------------
Ctrl + L   | format code selection <visual mode> or whole panel

#### `depreicated`
gg=G

### `Go to file`

Keys         | Description
------------ | -------------
gf | go to file on the cursor


### `Split File`

Keys         | Description
------------ | -------------
:sp | horiz
:vsp | vertical
Ctrl + w + up/left/down/right arrow | navigate splits
Ctrl + wT | move split to own tab




# HARD SETUP
Following is a guide on how to setup Vim 7.4 with YCM/Syntastic and the usage

## Installing VIM 7.4
download from [VIM ftp][ftp://ftp.vim.org/pub/vim/unix]

```bash
$ wget ftp://ftp.vim.org/pub/vim/unix/vim-7.4.tar.bz2
$ tar -xvf vim-7.4.tar.bz2
$ cd vim74
$ ./configure --with-features=huge --enable-multibyte --enable-rubyinterp --enable-pythoninterp --enable-perlinterp --enable-luainterp --enable-gui=gtk2 --enable-cscope --prefix=$PWD//install/

$ make VIMRUNTIMEDIR=$PWD/runtime
$ export PATH=$PWD/src/
```

(edit src/Makefile prefix variable if install location is not standard!)

make install

## VIM with Python 3

./configure --with-features=huge --enable-tclinterp --enable-multibyte --enable-rubyinterp  --enable-luainterp --enable-gui=gtk2 --enable-python3interp --enable-cscope --enable-gnome-check --prefix=$PWD/BUILD

make -j 4 install

### Installing Python
get python 2.7.x (ie:- 2.7.10)

./configure --prefix= --enable-unicode=ucs2 --enable-shared

make 

make install


## Installing Vundle
follow [https://github.com/VundleVim/Vundle.vim] git doc

## Installing YCM


Plugin 'Valloric/YouCompleteMe' in ~/.vimrc

go to vim

:PluginInstall

## Installing clang+llvm 3.6
copy clang to llvm_root/src/tools

cmake -G "Unix Makefiles" -DCMAKE_INSTALL_PREFIX=/g/g92/uswickra/ClangforVim/llvm-3.6.1/install/ -DCMAKE_C_COMPILER=/usr/apps/gnu/4.9.2/bin/gcc -DCMAKE_CXX_COMPILER=/usr/apps/gnu/4.9.2/bin/g++ -DCMAKE_BUILD_TYPE=Release ../

make && make install

### Installing ycm support libs(use c++11/ 4.7+, python 2.7+)
Note : python library location / paths explicit due to a bug

cmake -G "Unix Makefiles" -DCMAKE_C_COMPILER=/usr/apps/gnu/4.9.2/bin/gcc -DCMAKE_CXX_COMPILER=/usr/apps/gnu/4.9.2/bin/g++ -DPATH_TO_LLVM_ROOT=/g/g92/uswickra/LLVM_ROOT  -DPYTHON_EXECUTABLE=/usr/local/tools/python-2.7.7/bin/python -DPYTHON_LIBRARY=/usr/local/tools/python-2.7.7/lib/libpython2.7.so -DPYTHON_INCLUDE_DIR=/usr/local/tools/python-2.7.7/include/python2.7/ . ~/.vim/bundle/YouCompleteMe/third_party/ycmd/cpp

make ycm_support_libs

## Bash Profile Entries
Include vim 7.4 / clang/llvm and python into PATH and LD_LIBRARY_PATH

//to fix backspace bug

```bash
$ stty erase '^?'
$ export PATH=/g/g92/uswickra/vim74/install/bin:$PATH
$ export PATH=/g/g92/uswickra/LLVM_ROOT/bin:$PATH
$ export PATH=/usr/local/tools/python-2.7.7/bin:$PATH
$ export LD_LIBRARY_PATH=/usr/local/tools/python-2.7.7/lib:$LD_LIBRARY_PATH
$ export LD_LIBRARY_PATH=/g/g92/uswickra/LLVM_ROOT/lib:$LD_LIBRARY_PATH
```

