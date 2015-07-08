set nocompatible              " be iMproved, required
filetype off                  " required
set backspace=indent,eol,start

" ===========Vundle START
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
" "call vundle#begin('~/some/path/here')
"
" " let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'
Plugin 'Valloric/YouCompleteMe'

Plugin 'SirVer/ultisnips'

" Snippets are separated from the engine. Add this if you want them:
Plugin 'honza/vim-snippets'
Plugin 'scrooloose/nerdtree'

Plugin 'terryma/vim-expand-region'
Plugin 'Chiel92/vim-autoformat'

Plugin 'octol/vim-cpp-enhanced-highlight'
Plugin 'scrooloose/syntastic'

"Plugin 'MarcWeber/vim-addon-mw-utils'
"Plugin 'tomtom/tlib_vim'
"Plugin 'garbas/vim-snipmate'
"
" " All of your Plugins must be added before the following line
call vundle#end()            " required
" ============Vundle END
" filetype plugin indent on    " required


" set the runtime path to include Vundle and initialize
syntax on
filetype plugin indent on

"=============SET COLOR SCHEME================
colorscheme evening

set tags=./tags,./src/tags,tags;$HOME

":vimgrep 'get_path' ../Caliper/src/**/*.cpp
let CURR_PROJ="/g/g92/uswickra/Caliper"

"=============Keyboard Shortcuts================
"====== Ctrl + g ==> jump to definition/declearation (uses ctags, do 'ctags -R . *'
"====== Shift + Q ==> usage
"====== Ctrl + F ==> refactor
"====== Shift + Up ==> move line up
"====== Shift + Down ==> move line down
"====== Ctrl + D ==> duplicate line
"
map <silent> <C-g> g<C-]>
nnoremap Q :vimgrep "<C-R><C-W>" /g/g92/uswickra/Caliper/src/**/*.{c,h,cpp,hpp}<CR>:cw<CR>
nnoremap <C-f> :%s/\<<C-r><C-w>\>/
nnoremap <S-Down> ddp
nnoremap <S-Up> dd<Up>P
nnoremap <C-d> yyp

map <C-c> "+y<CR>
map <C-v> o<Esc>"+gP<CR>

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

" ===========YCM START
let g:ycm_global_ycm_extra_conf = "~/.vim/ycm_extra_conf.py"
let g:ycm_collect_identifiers_from_tags_files = 1
" ===========Snipmate
"let g:snips_trigger_key = '<C-Space>'
"imap <C-Space> <Plug>snipMateTrigger
"imap <C-Space> <Plug>snipMateNextOrTrigger

"let g:snips_trigger_key = '<Space>'
"let g:snips_trigger_key_backwards = '<Space-B>'
"
" ===========Ultisnips
"
let g:UltiSnipsExpandTrigger="<c-space>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"

" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"

"
" ===========Nerdtree
let NERDTreeDirArrows=0
nmap <silent> <c-n> :NERDTreeToggle<CR>
autocmd VimEnter * NERDTreeToggle


"
" ===========expand region
map <S-W> <Plug>(expand_region_expand)
map <S-E> <Plug>(expand_region_shrink)

"
" ===========AutoFormat
noremap <C-L> :Autoformat<CR>

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
let g:syntastic_cpp_compiler = 'g++'
let g:syntastic_cpp_compiler_options = ' -std=c++11'                                                                                                                                                                                                                                                                                                                      
"
let g:syntastic_cpp_include_dirs = ['/g/g92/uswickra/Caliper/src/**']
let g:syntastic_cpp_check_header = 1


