set nocompatible              " be iMproved, required

execute pathogen#infect()
filetype plugin indent on
set ffs=unix,dos
syntax on

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" =>  General
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let mapleader = ","
let g:mapleader = ","

" Set to auto read when a file is changed from the outside
set autoread

" Turn on the WiLd menu
set wildmenu

" Ignore compiled files
set wildignore=*.o,*~,*.pyc

"Always show current position
set ruler

" No annoying sound on errors
set noerrorbells
set novisualbell
set t_vb=
set tm=500

let g:solarized_termcolors=256

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => searching
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" For regular expressions turn magic on
set magic

" Show matching brackets when text indicator is over them
set showmatch

" How many tenths of a second to blink when matching brackets
set mat=2

" When searching try to be smart about cases 
set smartcase

" Highlight search results
set hlsearch

" Makes search act like search in modern browsers
set incsearch

" Don't redraw while executing macros (good performance config)
set lazyredraw


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Text, tab and indent related
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Use spaces instead of tabs
set expandtab

" 1 tab == 4 spaces
set shiftwidth=4
set tabstop=4
set expandtab

set ai "Auto indent
set si "Smart indent
set nowrap "Wrap lines


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Windows, buffers
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Smart way to move between windows
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l


set diffopt+=vertical

"Return to last edit position when opening files (You want this!)
autocmd BufReadPost *
     \ if line("'\"") > 0 && line("'\"") <= line("$") |
     \   exe "normal! g`\"" |
     \ endif

" Remember info about open buffers on close
set viminfo^=%

" nerdtree
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
nmap <leader>n :NERDTreeToggle<cr>

" use silver searcher
" The Silver Searcher
if executable('ag')
   let g:ackprg = 'ag'

   " Use ag over grep
   set grepprg=ag\ --nogroup\ --nocolor

   " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
   let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'

   " ag is fast enough that CtrlP doesn't need to cache
   let g:ctrlp_use_caching = 0
endif

nnoremap K :grep! "\b<C-R><C-W>\b"<CR>:cw<CR>

let g:ctrlp_working_path_mode = 'ra'

" bind K to grep word under cursor
nnoremap K :grep! "\b<C-R><C-W>\b"<CR>:cw<CR>
nnoremap <leader>f :grep! <C-R>=expand("<cword>")<CR><CR>

nmap <leader>m :cn<CR>
nmap <leader><space> :cp<CR>

nmap <leader>pb :CtrlPBuffer<cr>
nmap <leader>pf :CtrlP<cr>
nmap <leader>pm :CtrlPMixed<cr>
nmap <leader>ps :CtrlPMRU<cr>
nmap <leader>pd :CtrlPDir<cr>
nmap <leader>pt :CtrlPTag<cr>

nnoremap <leader>b <NOP>
nmap <leader>be :BuffergatorToggle<CR>
nmap <leader>bp :bprevious<CR>
nmap <leader>bn :bnext<CR>
nmap <leader>bd :bd<CR>

nmap <leader>te :tabnew<cr>
nmap <leader>tp :tabprevious<cr>
nmap <leader>tn :tabnext<cr>
nmap <leader>td :tabclose<cr>
nmap <leader>to :tabonly<cr>

nmap <leader>sv :source ~/.vimrc<cr>
nmap <leader>ev :e ~/.vimrc<cr>

" a.vim switching cpp/header
nmap <leader>a  :A<CR>
nmap <leader>av :AV<CR>
nmap <leader>as :AS<CR>
map  <leader>cc :botright cope<cr>
nmap <leader>w :w!<cr>
nmap <leader>e :Explore<cr>

" paste mode
nmap <leader>pp :setlocal paste!<cr>


" fugitive
nmap <leader>gs :Gstatus<CR>
" ctrl-n, ctrl-p move up and down 
" - add/remove file from index ( also works with visual mode)
" <enter> open file
" p  git add --patch
" C  commit
" :Git add .

" compare working copy with index version
nmap <leader>gd :Gdiff<CR>
" do -> diff obtain
" dp -> diff put

"git review , staged with head
command Greview :Git! diff --staged
nnoremap <leader>gr :Greview<cr>

" edit index version of fiel
" :Gedit :<filename>
" :Gedit :0   edit current file

"nmap <leader>gc :Gcommit<CR>
"nmap <leader>gb :Gblame<CR>
"nmap <leader>gl :Glog<CR>
"nmap <leader>gp :Git push<CR>

":Gread<CR>
" when in working copy <- index file
" when in index copy <- working copy     

":Gwrite<CR>
" when in working copy -> index file
" when in index copy -> working copy     

" tag bar
nmap <leader>tt :TagbarToggle<CR>

"<c-n> autocomplete

"cscope
" :cs find e blah - egrep
" :cs find t blah - text
" :cs add cscope.out
"
"   's'   symbol: find all references to the token under cursor
"   'g'   global: find global definition(s) of the token under cursor
"   'c'   calls:  find all calls to the function name under cursor
"   't'   text:   find all instances of the text under cursor
"   'e'   egrep:  egrep search for the word under cursor
"   'f'   file:   open the filename under cursor
"   'i'   includes: find files that include the filename under cursor
"   'd'   called: find functions that function under cursor calls
set csto=0  " search cscope tags first
set cscopequickfix=s-,g-,c-,d-,i-,t-,e- " use quick fix window
set cst     " use cscope for ctrl-] 
set cspc=3  " display 3 components of file path

" look for tags in current folder then go up to root 
set tags=./tags;/

let g:ackhighlight = 1
"let g:ack_default_options = " -s --max-count=200 --with-filename --nocolumn --smart-case --follow "

" let g:ackpreview = 1
nmap <C-\>s :cs find s <C-R>=expand("<cword>")<CR><CR>	
nmap <C-\>g :cs find g <C-R>=expand("<cword>")<CR><CR>	
nmap <C-\>c :cs find c <C-R>=expand("<cword>")<CR><CR>	
nmap <C-\>t :cs find t <C-R>=expand("<cword>")<CR><CR>	
nmap <C-\>e :cs find e <C-R>=expand("<cword>")<CR><CR>	
nmap <C-\>f :cs find f <C-R>=expand("<cfile>")<CR><CR>	
nmap <C-\>i :cs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
nmap <C-\>d :cs find d <C-R>=expand("<cword>")<CR><CR>	

" add any cscope database in current directory
if filereadable("cscope.out")
    cs add cscope.out  
elseif $CSCOPE_DB != ""
    cs add $CSCOPE_DB
endif
set csverb  " verbose connection info

if &diff
    set cursorline
    syntax off
    noremap ] ]c
    noremap [ [c
    "#hi DiffAdd    ctermfg=233 ctermbg=LightGreen guifg=#003300 guibg=#DDFFDD gui=none cterm=none
    "#hi DiffChange ctermbg=white  guibg=#ececec gui=none   cterm=none
    "#hi DiffText   ctermfg=233  ctermbg=yellow  guifg=#000033 guibg=#DDDDFF gui=none cterm=none
    map Q :cquite<CR>
endif

function ShowSpaces(...)
  let @/='\v(\s+$)|( +\ze\t)'
  let oldhlsearch=&hlsearch
  if !a:0
    let &hlsearch=!&hlsearch
  else
    let &hlsearch=a:1
  end
  return oldhlsearch
endfunction

function TrimSpaces() range
  let oldhlsearch=ShowSpaces(1)
  execute a:firstline.",".a:lastline."substitute ///gec"
  let &hlsearch=oldhlsearch
endfunction

command -bar -nargs=? ShowSpaces call ShowSpaces(<args>)
command -bar -nargs=0 -range=% TrimSpaces <line1>,<line2>call TrimSpaces()
nnoremap <F12>     :ShowSpaces 1<CR>
nnoremap <s-F12>   m`:TrimSpaces<CR>``
vnoremap <s-F12>   :TrimSpaces<CR>

let g:user_emmet_install_global = 0
autocmd FileType html,css EmmetInstall

let g:closetag_filenames = "*.html,*.xhtml,*.phtml"
