set nocompatible              " be iMproved, required
filetype off                  " required
set backspace=indent,eol,start
set mouse=a

syntax on
color dracula
" ===========Vundle START
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
" "call vundle#begin('~/some/path/here')
"
" " let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'
Plugin 'tpope/vim-fugitive'

Plugin 'Rip-Rip/clang_complete'
"Plugin 'Valloric/YouCompleteMe'

Plugin 'SirVer/ultisnips'

" Snippets are separated from the engine. Add this if you want them:
Plugin 'honza/vim-snippets'
Plugin 'scrooloose/nerdtree'
Plugin 'scrooloose/nerdcommenter'

Plugin 'terryma/vim-expand-region'
"Plugin 'Chiel92/vim-autoformat'
Plugin 'rhysd/vim-clang-format'

Plugin 'octol/vim-cpp-enhanced-highlight'
Plugin 'scrooloose/syntastic'

"Plugin 'vim-scripts/cscope.vim'
Plugin 'vim-scripts/Conque-GDB'
"Plugin 'MarcWeber/vim-addon-mw-utils'
"Plugin 'tomtom/tlib_vim'
"Plugin 'garbas/vim-snipmate'
Plugin 'airblade/vim-gitgutter.git'
Plugin 'mhinz/vim-startify'
Plugin 'ctrlpvim/ctrlp.vim'
"Plugin 'ivalkeen/vim-ctrlp-tjump'
Plugin 'morhetz/gruvbox'
Plugin 'zenorocha/dracula-theme', {'rtp': 'vim/'}
Plugin 'jiangmiao/auto-pairs'
Plugin 'majutsushi/tagbar'
"Plugin 'vim-scripts/taglist.vim'
Plugin  'mrtazz/DoxygenToolkit.vim'
Plugin  'brooth/far.vim'

" " All of your Plugins must be added before the following line
call vundle#end()            " required
" ============Vundle END
" filetype plugin indent on    " required


" set the runtime path to include Vundle and initialize
syntax on
filetype plugin indent on

"=============SET COLOR SCHEME================
"colorscheme evening
"colorscheme github
"colorscheme gruvbox
"set background=dark 
" color dracula


set tags=./tags,./src/tags,tags;$HOME

":vimgrep 'get_path' ../Caliper/src/**/*.cpp
"let CURR_PROJ="/u/uswickra/hpx/libnbc-photon/libNBC-1.0.1/"
let CURR_PROJ="/u/uswickra/hpx/hpx-libnbc/sw_coll/hpx"

"=============Keyboard Shortcuts================
"====== Ctrl + g ==> jump to definition/declearation (uses ctags, do 'ctags -R . *'
"====== Shift + Q ==> usage
"====== Ctrl + F ==> refactor
"====== Shift + Up ==> move line up
"====== Shift + Down ==> move line down
"====== Ctrl + D ==> duplicate line
"
map <silent> <C-g> g<C-]>
map <silent> <C-h> <C-w><C-]><C-w>T
"nnoremap Q :vimgrep "<C-R><C-W>"/u/uswickra/hpx/libnbc-photon/libNBC-1.0.1/**/*.{c,h,cpp,hpp}<CR>:cw<CR>
"nnoremap Q :vimgrep "<C-R><C-W>"./**/*.{c,h}<CR>:cw<CR>
"nnoremap Q :Far "<C-R><C-W>" REPL ./**/*.{c,h}

" Far Search and replace
nnoremap <C-j> :Far <C-R><C-W> <C-R><C-W> ./**/*.*
nnoremap <C-k> :Far \<<C-R><C-W>\> \<<C-R><C-W>\> ./**/*.*
nnoremap Q :Fardo<CR>:cw<CR> 

nnoremap <C-f> :%s/\<<C-r><C-w>\>/
nnoremap <S-Down> ddp
nnoremap <S-Up> dd<Up>P
nnoremap <C-d> yyp

map <C-c> "+y<CR>
map <C-v> o<Esc>"+gP<CR>
"map nerd commenter
map ? \ci <Down>

nnoremap <S-n> :tabe<CR>
"nnoremap <S->m> :set number<CR>

"sessions
map <F2> :SSave <cr> " Quick write session with F2
map <F3> :SLoad <cr>     " And load session with F3
map <F4> :SDelete <cr>     " And delete with F4

autocmd VimEnter *
                \   if !argc()
                \ |   Startify
                \ |   NERDTree
                \ |   wincmd w
                \ | endif

"Ctrlp
nnoremap <c-]> :CtrlPBufTagAll<cr>
nnoremap <c-P> :CtrlPTag<cr>
"nnoremap <c-]> :CtrlPtjump<cr>
"vnoremap <c-]> :CtrlPtjumpVisual<cr>

"behave mswin
"set clipboard=unnamedplus
"smap <Del> <C-g>"_d
"smap <C-c> <C-g>y
"smap <C-x> <C-g>x
"imap <C-v> <Esc>pi
"smap <C-v> <C-g>p

"map Q :vimgrep "<C-R><C-W>" ../Caliper/src/**/*.{c,h,cpp,hpp}<CR>:cw<CR>

nnoremap F :/<C-R><C-W><CR>
set hlsearch

" ===== CSCOPE========
"map <C-u> :call cscope#findInteractive(expand('<cword>'))<CR>
" Not using cscope plugin anymore ; instead plugins/cscope_maps.vim
"
" <Ctl-Space> + s = find symbol under cur
" <Ctl-Space> + c = find callers under cur
" <Ctl-Space> + d = find called funcs under cur
" <Ctl-Space> + i = find included under cur
"
" <Ctrl-\> s ==> not in a split window, but same window
" <Ctrl-Space> <Ctrl-Space> s ==> not in a vertical window, but horiz window
" ===========Ultisnips
"
"let g:UltiSnipsExpandTrigger="<C-space>"
let g:UltiSnipsExpandTrigger="<NUL>"
let g:UltiSnipsJumpForwardTrigger="<C-b>"
let g:UltiSnipsJumpBackwardTrigger="<C-z>"

" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"

"
" ===========Nerdtree
let NERDTreeDirArrows=0
nmap <silent> <c-n> :NERDTreeToggle<CR>
autocmd VimLeave * NERDTreeClose
autocmd VimEnter * NERDTreeToggle
let NERDTreeShowLineNumbers=1

"
" ===========expand region
map <S-W> <Plug>(expand_region_expand)
map <S-E> <Plug>(expand_region_shrink)

"
" ===========AutoFormat
let g:clang_format#style_options = {
            \ "AccessModifierOffset" : -4,
	    \ "AlignAfterOpenBracket": "Align",
	    \ "AlignConsecutiveAssignments": "true",
	    \ "AlignConsecutiveDeclarations": "true",
	    \ "AlignEscapedNewlinesLeft": "true",
            \ "ColumnLimit" : 80,
            \ "IndentWidth" : 2,
            \ "BasedOnStyle" : "Google",
            \ "AllowShortIfStatementsOnASingleLine" : "true",
            \ "AlwaysBreakTemplateDeclarations" : "true",
            \ "Standard" : "C++11"}

"noremap <C-L> :ClangFormat<CR>
autocmd FileType c,cpp,objc,h,hpp,C nnoremap <C-L> :ClangFormat<CR>
autocmd FileType c,cpp,objc,h,hpp,C vnoremap <C-L> :ClangFormat<CR>
"
" ===========EnhancedCPPHighlight
let g:cpp_class_scope_highlight = 1
let g:cpp_experimental_template_highlight = 1

" ===========Syntastic
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
"
let g:syntastic_c_compiler = 'gcc'
"let g:syntastic_c_compiler = 'x86_64-vmk-linux-gnu-gcc'
"let g:syntastic_c_compiler_options = ' -std=c11'
"let g:syntastic_c_compiler_options = ' -std=c11'
let g:syntastic_c_remove_include_errors = 1

let g:syntastic_cpp_compiler = 'g++'
"let g:syntastic_cpp_compiler_options = ' -std=c++11' 
let g:syntastic_cpp_remove_include_errors = 1
"
let g:syntastic_cpp_include_dirs = ['/mytrees/uwickramasin-main-1/bora/vmcore/**']
"let g:syntastic_c_include_dirs = ['/mytrees/uwickramasin-main-1/bora/vmcore/**', '/mytrees/testc/frobos/lib']
"let g:syntastic_c_include_dirs = ['/mytrees/uwickramasin-main-1/bora/vmcore/**', '/mytrees/testc/frobos/lib']
"let g:syntastic_cpp_include_dirs = ['/u/uswickra/hpx/hpx-libnbc/hpx/include/**']
"let g:syntastic_cpp_check_header = 1

let g:syntastic_quiet_messages = {"file:p":  ['include/hpx/builtins.h'] }
let g:syntastic_cpp_config_file = '.syntastic_cpp_config'
let g:syntastic_c_config_file = '.syntastic_c_config'


" Autoformat
"let g:formatdef_clangformat_objc = '"clang-format -style=~/.vim/clang_format2"'

"===========clang complete
"let g:clang_library_path = '/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/lib/'
"let g:clang_library_path = '/usr/lib/clang/3.8.0/lib/'
let g:clang_library_path = '/usr/lib/x86_64-linux-gnu'
" fix bug on press to Enter
let g:AutoPairsMapCR = 0
imap <silent><CR> <CR><Plug>AutoPairsReturn

"==================== gitglutter
"autocmd VimEnter * GitGutterLineHighlightsEnable
nmap <C-c> :GitGutterRevertHunk<CR>

"=================== startify 
autocmd User Startified setlocal buftype=

"==================== taglist
nmap <F8> :TagbarToggle<CR>
"nmap <F8> :TlistToggle<CR>
"let Tlist_Use_Right_Window   = 1
set number

set statusline+=%F
"================== Doxygen
let g:DoxygenToolkit_briefTag_pre="@brief "
let g:DoxygenToolkit_paramTag_pre="@param "
let g:DoxygenToolkit_returnTag="@return \n* @see \n* @note"
let g:DoxygenToolkit_blockHeader="-------------------------------"
let g:DoxygenToolkit_blockFooter="---------------------------------"
let g:DoxygenToolkit_authorName="Udayanga Wickramasinghe"
"let g:DoxygenToolkit_licenseTag="@uswick license" <-- !!! Does not end with "\<enter>"

noremap <F5> :Dox<CR>
noremap <F6> :DoxLic<CR>:DoxAuthor<CR>

"================= Mapping keys for copy/pasting to/from registers
vnoremap 1 "ay
vnoremap 2 "by
vnoremap 3 "cy
vnoremap 4 "dy
vnoremap 5 "ey
vnoremap 6 "fy
vnoremap 7 "gy
vnoremap 8 "hy
vnoremap 9 "iy
vnoremap 0 "jy

noremap 1p "ap
noremap 2p "bp
noremap 3p "cp
noremap 4p "dp
noremap 5p "ep
noremap 6p "fp
noremap 7p "gp
noremap 8p "hp
noremap 9p "ip
noremap 0p "jp
