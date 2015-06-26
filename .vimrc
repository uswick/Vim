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

set tags=./tags,tags;$HOME
map <silent> <C-g> g<C-]>

":vimgrep 'get_path' ../Caliper/src/**/*.cpp
let CURR_PROJ="/g/g92/uswickra/Caliper"

nnoremap Q :vimgrep "<C-R><C-W>" /g/g92/uswickra/Caliper/src/**/*.{c,h,cpp,hpp}<CR>:cw<CR>

"map Q :vimgrep "<C-R><C-W>" ../Caliper/src/**/*.{c,h,cpp,hpp}<CR>:cw<CR>


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

