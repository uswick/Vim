set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" " alternatively, pass a path where Vundle should install plugins
" "call vundle#begin('~/some/path/here')
"
" " let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

Plugin 'https://github.com/vim-scripts/OmniCppComplete.git'
Plugin 'octol/vim-cpp-enhanced-highlight'
Plugin 'scrooloose/syntastic'
"
" " The following are examples of different formats supported.
" " Keep Plugin commands between vundle#begin/end.
" " plugin on GitHub repo
" Plugin 'tpope/vim-fugitive'
" " plugin from http://vim-scripts.org/vim/scripts.html
" Plugin 'L9'
" " Git plugin not hosted on GitHub
" Plugin 'git://git.wincent.com/command-t.git'
" " git repos on your local machine (i.e. when working on your own plugin)
" Plugin 'file:///home/gmarik/path/to/plugin'
" " The sparkup vim script is in a subdirectory of this repo called vim.
" " Pass the path to set the runtimepath properly.
" Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
" " Avoid a name conflict with L9
" Plugin 'user/L9', {'name': 'newL9'}
"
" " All of your Plugins must be added before the following line
call vundle#end()            " required
" filetype plugin indent on    " required
" " To ignore plugin indent changes, instead use:
" "filetype plugin on
" "
" " Brief help
" " :PluginList       - lists configured plugins
" " :PluginInstall    - installs plugins; append `!` to update or just
" :PluginUpdate
" " :PluginSearch foo - searches for foo; append `!` to refresh local cache
" " :PluginClean      - confirms removal of unused plugins; append `!` to
" auto-approve removal
" "
syntax on
filetype plugin indent on

" configure tags - add additional tags here or comment out not-used ones
set tags+=~/.vim/tags/cpp
set tags+=~/.vim/tags/gl
set tags+=~/.vim/tags/sdl
set tags+=~/.vim/tags/qt4
" " build tags of your own project with Ctrl-F12
map <C-F12> :!ctags -R --sort=yes --c++-kinds=+p --fields=+iaS --extra=+q .<CR>
"
" " OmniCppComplete
let OmniCpp_NamespaceSearch = 1
let OmniCpp_GlobalScopeSearch = 1
let OmniCpp_ShowAccess = 1
let OmniCpp_ShowPrototypeInAbbr = 1 " show function parameters
let OmniCpp_MayCompleteDot = 1 " autocomplete after .
let OmniCpp_MayCompleteArrow = 1 " autocomplete after ->
let OmniCpp_MayCompleteScope = 1 " autocomplete after ::
let OmniCpp_DefaultNamespaces = ["std", "_GLIBCXX_STD"]
" " automatically open and close the popup menu / preview window
au CursorMovedI,InsertLeave * if pumvisible() == 0|silent! pclose|endif
set completeopt=menuone,menu,longest,preview

let g:cpp_class_scope_highlight = 1
let g:cpp_experimental_template_highlight = 1

" Syntastic
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
"let g:syntastic_check_on_open = 1
" let g:syntastic_check_on_wq = 0

let g:syntastic_cpp_compiler = 'g++'
let g:syntastic_cpp_compiler_options = ' -std=c++11'

let g:syntastic_cpp_include_dirs = ['/N/u/uswickra/Karst/boost/boost_1_52_0/install/include','/N/u/uswickra/Karst/MRNet/mrnet_4.1.0/xplat/include/','/N/u/uswickra/Karst/MRNet/mrnet_4.1.0/include','/N/u/uswickra/Karst/MRNet/mrnet_4.1.0/include/xplat', '/N/u/uswickra/Karst/MRNet/mrnet_4.1.0/include/xplat/include', '/N/u/uswickra/Karst/MRNet/mrnet_4.1.0/build/x86_64-unknown-linux-gnu']
let g:syntastic_cpp_check_header = 1
"let b:syntastic_cpp_cflags = '-I/N/u/uswickra/Karst/boost/boost_1_52_0/install/include -I/N/u/uswickra/Karst/MRNet/mrnet_4.1.0/include -I/N/u/uswickra/Karst/MRNet/mrnet_4.1.0/include/xplat  -I/N/u/uswickra/Karst/MRNet/mrnet_4.1.0/xplat/include -I/N/u/uswickra/Karst/MRNet/mrnet_4.1.0/build/x86_64-unknown-linux-gnu/' 

