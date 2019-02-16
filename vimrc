set nocompatible              " be iMproved, required

" To disable a plugin, add it's bundle name to the following list
let g:pathogen_disabled = []
call add(g:pathogen_disabled, 'html5')

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
set fileformat=unix

let g:solarized_termcolors=256
colorscheme desert

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
set smartindent "Smart indent
set nowrap "Wrap lines


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Windows, buffers
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" simpler moving between windows
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

if &diff
    set cursorline
    syntax off
    noremap ] ]c
    noremap [ [c

    "highlight DiffAdd    cterm=bold ctermfg=10 ctermbg=17 gui=none guifg=bg guibg=Red
    "#highlight DiffDelete cterm=bold ctermfg=10 ctermbg=17 gui=none guifg=bg guibg=Red
    "#highlight DiffChange cterm=bold ctermfg=10 ctermbg=17 gui=none guifg=bg guibg=Red
    "#highlight DiffText   cterm=bold ctermfg=10 ctermbg=88 gui=none guifg=bg guibg=Red
    "#hi DiffAdd guifg=NONE ctermfg=NONE guibg=#464632 ctermbg=238 gui=NONE cterm=NONE
    "#hi DiffChange guifg=NONE ctermfg=NONE guibg=#335261 ctermbg=239 gui=NONE cterm=NONE
    "#hi DiffDelete guifg=#f43753 ctermfg=203 guibg=#79313c ctermbg=237 gui=NONE cterm=NONE
    "#hi DiffText guifg=NONE ctermfg=NONE guibg=NONE ctermbg=NONE gui=reverse cterm=reverse

    map Q :cquite<CR>
    nnoremap 1 :diffget LOCAL<CR>
    nnoremap 2 :diffget BASE<CR>
    nnoremap 3 :diffget REMOTE<CR>
    nnoremap ` :diffupdateg<CR>
endif

"""""""""""""""""""""""""""""""""
" functions 
"""""""""""""""""""""""""""""""""
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

" Save and make current file.o
function! Make()
  let curr_dir = expand('%:h')
  if curr_dir == ''
    let curr_dir = '.'
  endif
  echo curr_dir
  execute 'lcd ' . curr_dir
  execute 'make %:r.o'
  execute 'lcd -'
endfunction

nnoremap <F4> :AsyncRun g++ -std=c++14 "%" -o "%<"<CR>
nnoremap <F7> :AsyncRun g++ -std=c++17 "%" -o "%<"<CR>


"""""""""""""""""""""""""""
"
" leader mapping - 
"      in alphabetical order
"
""""""""""""""""""""""""""

" a.vim switching cpp/header
nnoremap <leader>a  :A<CR>
nnoremap <leader>av :AV<CR>
nnoremap <leader>as :AS<CR>

" buffers gator
nnoremap <leader>b <NOP>
nnoremap <leader>be :BuffergatorToggle<CR>
nnoremap <leader>bp :bp<CR>
nnoremap <leader>bn :bn<CR>
nnoremap <leader>bd :bd<CR>

" cc errors in botome windwos 
nnoremap  <leader>ce :execute "copen \| resize 30" <cr>
nnoremap  <leader>cd :cclose<cr>

" edit new file
cnoremap %% <C-R>=expand('%:p:h').'/.'
" %% expands to the current file directory
nnoremap <leader>ee :e.<cr>
nnoremap <leader>ew :e %%<cr>
nnoremap <leader>es :sp %%<cr>
nnoremap <leader>ev :vsp %%<cr>
nnoremap <leader>et :tabe %%<cr>

" find it
nnoremap <leader>f :grep! <C-R>=expand("<cword>")<CR><CR>

" git - fugitive  
nnoremap <leader>gs :Gstatus<CR>
" ctrl-n, ctrl-p move up and down 
" - add/remove file from index ( also works with visual mode)
" <enter> open file
" p  git add --patch
" C  commit
" :Git add .

" compare working copy with index version
nnoremap <leader>gd :Gdiff<CR>
" do -> diff obtain
" dp -> diff put

"git review , staged with head
command Greview :Git! diff --staged
nnoremap <leader>gr :Greview<cr>

" edit index version of fiel
" :Gedit :<filename>
" :Gedit :0   edit current file

"nnoremap <leader>gc :Gcommit<CR>
"nnoremap <leader>gb :Gblame<CR>
"nnoremap <leader>gl :Glog<CR>
"nnoremap <leader>gp :Git push<CR>

":Gread<CR>
" when in working copy <- index file
" when in index copy <- working copy     

":Gwrite<CR>
" when in working copy -> index file
" when in index copy -> working copy     


" you complete me
nnoremap <leader>jj :YcmCompleter GoTo<CR>
nnoremap <leader>jd :YcmCompleter GoToDeclaration<CR>
nnoremap <leader>jt :YcmCompleter GetType<CR>
nnoremap <leader>ji :YcmCompleter GoToDefinition<CR>
"nnoremap <leader>jr :YcmCompleter GoToReferences<CR>
"nnoremap <leader>jf :YcmCompleter FixIt<CR>

" next/previous
nnoremap <leader>m :cn<CR>
nnoremap <leader><space> :cp<CR>

" nerdtree
"autocmd StdinReadPre * let s:std_in=1
"autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
nnoremap <leader>n :NERDTreeToggle<cr>

" paste mode
nnoremap <leader>pp :setlocal paste!<cr>

" ctrlp
let g:ctrlp_working_path_mode = 'ra'
nnoremap <leader>pb :CtrlPBuffer<cr>
nnoremap <leader>pf :CtrlP<cr>
nnoremap <leader>pm :CtrlPMixed<cr>
nnoremap <leader>ps :CtrlPMRU<cr>
nnoremap <leader>pd :CtrlPDir<cr>
nnoremap <leader>pt :CtrlPTag<cr>

" tabs
nnoremap <leader>te :tabnew<cr>
nnoremap <leader>tp :tabprevious<cr>
nnoremap <leader>tn :tabnext<cr>
nnoremap <leader>td :tabclose<cr>
nnoremap <leader>to :tabonly<cr>

" tag bar
nnoremap <leader>tt :TagbarToggle<CR>
let g:tagbar_type_go = {
    \ 'ctagstype' : 'go',
    \ 'kinds'     : [
        \ 'p:package',
        \ 'i:imports:1',
        \ 'c:constants',
        \ 'v:variables',
        \ 't:types',
        \ 'n:interfaces',
        \ 'w:fields',
        \ 'e:embedded',
        \ 'm:methods',
        \ 'r:constructor',
        \ 'f:functions'
    \ ],
    \ 'sro' : '.',
    \ 'kind2scope' : {
        \ 't' : 'ctype',
        \ 'n' : 'ntype'
    \ },
    \ 'scope2kind' : {
        \ 'ctype' : 't',
        \ 'ntype' : 'n'
    \ },
    \ 'ctagsbin'  : 'gotags',
    \ 'ctagsargs' : '-sort -silent'
    \ }

" vimrc management
nnoremap <leader>vs :source ~/.vim/vimrc<CR>
nnoremap <leader>ve :e ~/.vim/vimrc<CR>

nnoremap <leader>w :w!<cr>

nnoremap <F1> :YcmCompleter FixIt<CR>
nnoremap <F5> :YcmForceCompileAndDiagnostics<CR>


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
nnoremap <C-\>s :cs find s <C-R>=expand("<cword>")<CR><CR>	
nnoremap <C-\>g :cs find g <C-R>=expand("<cword>")<CR><CR>	
nnoremap <C-\>c :cs find c <C-R>=expand("<cword>")<CR><CR>	
nnoremap <C-\>t :cs find t <C-R>=expand("<cword>")<CR><CR>	
nnoremap <C-\>e :cs find e <C-R>=expand("<cword>")<CR><CR>	
nnoremap <C-\>f :cs find f <C-R>=expand("<cfile>")<CR><CR>	
nnoremap <C-\>i :cs find i ^<C-R>=expand("<cfile>")<CR><CR>
nnoremap <C-\>d :cs find d <C-R>=expand("<cword>")<CR><CR>	

" add any cscope database in current directory
if filereadable("cscope.out")
    cs add cscope.out  
elseif $CSCOPE_DB != ""
    cs add $CSCOPE_DB
endif
set csverb  " verbose connection info


command -bar -nargs=? ShowSpaces call ShowSpaces(<args>)
command -bar -nargs=0 -range=% TrimSpaces <line1>,<line2>call TrimSpaces()

nnoremap <F12>     :ShowSpaces 1<CR>
nnoremap <s-F12>   m`:TrimSpaces<CR>``
vnoremap <s-F12>   :TrimSpaces<CR>

let g:user_emmet_install_global = 0
autocmd FileType html,css EmmetInstall

let g:closetag_filenames = "*.html,*.xhtml,*.phtml"
