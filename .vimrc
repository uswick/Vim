set nocompatible              " be iMproved, required
filetype off                  " required
set backspace=indent,eol,start
set mouse=a
set list
set listchars=tab:>-
set colorcolumn=80


"Use 24-bit (true-color) mode in Vim/Neovim when outside tmux.
"If you're using tmux version 2.2 or later, you can remove the outermost $TMUX check and use tmux's 24-bit color support
"(see < http://sunaku.github.io/tmux-24bit-color.html#usage > for more information.)
if (empty($TMUX))
  if (has("nvim"))
    "For Neovim 0.1.3 and 0.1.4 < https://github.com/neovim/neovim/pull/2198 >
    let $NVIM_TUI_ENABLE_TRUE_COLOR=1
  endif
  "For Neovim > 0.1.5 and Vim > patch 7.4.1799 < https://github.com/vim/vim/commit/61be73bb0f965a895bfb064ea3e55476ac175162 >
  "Based on Vim patch 7.4.1770 (`guicolors` option) < https://github.com/vim/vim/commit/8a633e3427b47286869aa4b96f2bfc1fe65b25cd >
  " < https://github.com/neovim/neovim/wiki/Following-HEAD#20160511 >
  if (has("termguicolors"))
    set termguicolors
  endif
endif

syntax on
"color dracula
color onedark
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
"Plugin 'vim-scripts/Conque-GDB'
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
"map <silent> <C-h> <C-w><C-]><C-w>T
"nnoremap Q :vimgrep "<C-R><C-W>"/u/uswickra/hpx/libnbc-photon/libNBC-1.0.1/**/*.{c,h,cpp,hpp}<CR>:cw<CR>
"nnoremap Q :vimgrep "<C-R><C-W>"./**/*.{c,h}<CR>:cw<CR>
"nnoremap Q :Far "<C-R><C-W>" REPL ./**/*.{c,h}

" Far Search and replace
nnoremap <C-j> :Far <C-R><C-W> <C-R><C-W> ./**/*.*
"nnoremap <C-k> :Far \<<C-R><C-W>\> \<<C-R><C-W>\> ./**/*.*
"nnoremap Q :Fardo<CR>:cw<CR> 

nnoremap <C-f> :%s/\<<C-r><C-w>\>/
nnoremap <S-Down> ddp
nnoremap <S-Up> dd<Up>P
"nnoremap <DOWN> ddp
nnoremap <C-d> yyp
"nnoremap <UP> dd<Up>P

map <C-c> "+y<CR>
map <C-v> o<Esc>"+gP<CR>
"map nerd commenter
map ? \ci <Down>

nnoremap <S-n> :tabe %<CR>
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
"nnoremap <c-P> :CtrlPTag<cr>
"map <c-p> :CtrlPMixed<CR>:echo "CtrlPMixed Executed..."<CR>
"nnoremap <c-P> :CtrlPMixed<CR>:echo "CtrlPMixed Executed..."<CR>
"nnoremap <c-]> :CtrlPtjump<cr>
"vnoremap <c-]> :CtrlPtjumpVisual<cr>
"let g:ctrlp_cmd = 'CtrlPMixed'
"let g:ctrlp_root_markers = ['build']
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\.git$|vendor\|\.hg$\|\.svn$\|\.yardoc\|public\/images\|build\|data\|log\|tmp$',
  \ 'file': '\.d$\|\.so$\|\.dat$'
  \ }

"let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
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
" ===========EnhancedCPPHighlight
let g:cpp_class_scope_highlight = 1
let g:cpp_experimental_template_highlight = 1

" ===========Syntastic
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

"let g:syntastic_always_populate_loc_list = 1
"let g:syntastic_auto_loc_list = 1
"let g:syntastic_check_on_open = 1
"let g:syntastic_check_on_wq = 0
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 0
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_auto_jump = 0

"
let g:syntastic_c_compiler = 'gcc'
"let g:syntastic_c_compiler = 'x86_64-vmk-linux-gnu-gcc'
"let g:syntastic_c_compiler_options = ' -std=c11'
"let g:syntastic_c_compiler_options = ' -std=c11'
let g:syntastic_c_remove_include_errors = 0

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
"let g:clang_library_path = '/usr/lib/x86_64-linux-gnu'
let g:clang_library_path = '/usr/lib/x86_64-linux-gnu/'
"let g:clang_library_path = '/dbc/sc-dbc1221/wickramasinu/LLVM-clang/llvm-project/build/lib'
" fix bug on press to Enter
let g:AutoPairsMapCR = 0
imap <silent><CR> <CR><Plug>AutoPairsReturn

"==================== gitglutter
"autocmd VimEnter * GitGutterLineHighlightsEnable
"nmap <C-c> :GitGutterRevertHunk<CR>

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

if executable('ag')
	  "set grepprg=ag\ --nogroup\ --nocolor\ --ignore\ '*.out*'\ --ignore\ '*.ld*'\ --ignore\ '*.log*'\ --ignore\ '*.map*'\ --ignore\ '*.patch*'\ --ignore\ '*tags*'\ --ignore\ '*.gdbout*'
	  set grepprg=ag\ --ignore\ '*.out*'\ --ignore\ '*.ld*'\ --ignore\ '*.log*'\ --ignore\ '*.map*'\ --ignore\ '*.patch*'\ --ignore\ '*tags*'\ --ignore\ '*.gdbout*'
	  "set grepprg=ag\ --nogroup\ --nocolor
endif

" Search examples  ==>
" Enter search term: \#\#[.]*_start
" This will find all strings with ##[any char 0-more times]_start ;
" capitalization ignored
" Enter search term: \#\#[.]*_START ==> similar to above but upper case sensitive
function! MyCustomSearch()
  echo "special chars escape with \\ and regex in []"
  echo "i.e. Enter search term: \\#\\#[.]*_start"
  let path_term = input("Enter search path (leave blank for current): ")
  let file_type = input("Enter file type for exclusive type search (leave blank for any) : ")
  let grep_term = input("Enter search term: ")

  if !empty(file_type)
    let group = "-G \'\." . file_type . "$\' "
    echo group
  else 
    let group = ""
  endif  

  if !empty(path_term)
    echo "Vim searching default path"
  endif

  if !empty(grep_term)
    "execute 'silent grep' grep_term path_term group  | copen
    let cmd = "silent grep " . grep_term . " " . path_term . " " . group
    execute cmd | copen
  else
    echo "Empty search term"
    let cmd = "silent grep <cword>" . " " . path_term . " " . group
    echo cmd
    execute cmd | copen
    "execute 'silent grep <cword>'  path_term group | copen
    "execute 'silent grep' <C-R><C-W> | copen
  endif
  redraw!
endfunction

function! TestFunc()
  let file_type = input("Enter file type for exclusive type search (leave blank for any) : ")
  let  group = "-G \'\." . file_type . "$\' "
  echo "This is a test func"
  echo group
  redraw!
endfunction

function! CloseAllWindowsButCurrent()
   let tabnr= tabpagenr()
   let tabinfo=gettabinfo(tabnr)
   let windows=tabinfo[0]['windows']

   for winid in windows
      let curwin=winnr() "could change
      let winnr=win_id2win(winid)
      if winnr!=curwin
         execute ':'.winnr.'q!'
      endif
   endfor
endfunction"


function! LocalHighlightTrails()
  "exec "norm ="
  highlight ExtraWhitespace ctermbg=red guibg=red
  match ExtraWhitespace /\s\+$/
  "redraw!
endfunction


nnoremap <C-1> :call CloseAllBuffersButCurrent()<CR>
"nnoremap <C-h> :call MyCustomSearch() \| copen<CR><C-l>
nnoremap <C-h> :call MyCustomSearch()<CR>
"nnoremap <C-k> :call LocalHighlightTrails()<CR>
nnoremap <C-k> :call LocalHighlightTrails()<CR>
vmap <C-k> =:call LocalHighlightTrails()<CR>:echo "Vim Indent Formatting Done!"<CR>
"
" ===========AutoFormat
"let g:clang_format#style_options = {
            "\ "AccessModifierOffset" : -4,
		 "\ "AlignAfterOpenBracket": "Align",
		 "\ "AlignConsecutiveAssignments": "true",
		 "\ "AlignConsecutiveDeclarations": "true",
		 "\ "AlignEscapedNewlinesLeft": "true",
            "\ "ColumnLimit" : 80,
            "\ "IndentWidth" : 2,
            "\ "BasedOnStyle" : "Google",
            "\ "AllowShortIfStatementsOnASingleLine" : "true",
            "\ "AlwaysBreakTemplateDeclarations" : "true",
            "\ "Standard" : "C++11"}

let g:clang_format#detect_style_file = 1
"noremap <C-L> :ClangFormat<CR>
autocmd FileType c,cpp,objc,h,hpp,C nnoremap <C-l> :ClangFormat<CR>:call LocalHighlightTrails()<CR>
autocmd FileType c,cpp,objc,h,hpp,C vnoremap <C-l> :ClangFormat<CR>:call LocalHighlightTrails()<CR>


highlight ColorColumn ctermbg=lightgrey guibg=red

set smartindent
set tabstop=3
set shiftwidth=3
set expandtab

" Airline/one-dark theme
let g:airline_theme='onedark'
let g:airline_section_c = '%<%F%m %#__accent_red#%{airline#util#wrap(airline#parts#readonly(),0)}%#__restore__#'

" create NOTES window
" use 'cp' to copy current file path
set splitright
nmap cp :let @" = expand("%")<cr>"
nmap notes :vsplit notes.vim<cr>
nmap no :vsplit notes.vim<cr>

"FZF
map <c-\> :FZF<CR>
"
" An action can be a reference to a function that processes selected lines
"function! s:build_quickfix_list(lines)
   "call setqflist(map(copy(a:lines), '{ "filename": v:val  }'))
   "copen
   "cc
"endfunction

"let g:fzf_action = {
  "\ 'c-u': function('s:build_quickfix_list'),
  "\ 'ctrl-t': 'tab split',
  "\ 'ctrl-x': 'split',
  "\ 'ctrl-v': 'vsplit' }
