" MY PERSONAL VIM SETTINGS FILE

" This setting must go first because it changes other options as side effect
set nocompatible            " Make Vim behave in a more useful way instead of being Vi-compatible.

set autowrite               " Write the contents of the file, if it has been modified, when changing buffers.
set nobackup                " Don't make a backup before overwriting a file.
set noswapfile              " Don't use a swapfile for the buffer.  Don't use this for big files!
set autoread                " Automatically read files changed outside of vim
set hidden                  " Change buffer without saving

set nowrap                  " Don't wrap lines longer than the width of the window on the next line.
set scrolloff=2             " Minimal number of screen lines to keep above and below the cursor.
set laststatus=2            " Always have status line for each window.
set statusline=%f%m%r%h%w\ %y\ %=[buf\ %n]\ %l,%c/%L\ %p%%   " information to show in status line
"set ruler                   " Show the line and column number of the cursor position (commented out since this info was set in statusline)
set cursorline              " Highlight the screen line of the cursor.
set number                  " Print the line number in front of each line.
set listchars=tab:▸\ ,eol:$ " Modify tab char when set list
set background=dark         " Vim will try to use colors that look good on a dark background.

set wildmenu                " Possible matches are shown just above the command line
set wildmode=list:longest   " Complete longest common string, then list alternatives
set wildignore=*.o,*.obj,*.swp,*.bak,*.pyc,*.class  " A file that matches these patterns is ignored when completing file or directory names.
set shellslash              " Use a forward slash when expanding file names.

set backspace=indent,eol,start  " Influences the working of <BS>, <Del>, CTRL-W and CTRL-U in Insert mode.
set expandtab               " Use the appropriate number of spaces to insert a <Tab>
set shiftwidth=4            " Number of spaces to use for each step of (auto)indent.
set tabstop=4               " Number of spaces that a <Tab> in the file counts for. 
set softtabstop=4           " Number of spaces that a <Tab> counts for while performing editing operations, like inserting a <Tab> or using <BS>. 

set ignorecase              " Case is ignored for searches
set smartcase               " Override the ignorecase option if the search pattern contains upper case characters.
set hlsearch                " When there is a previous search pattern, highlight all its matches.
set incsearch               " While typing a search command, show where the pattern, as it was typed so far, matches. 
set nowrapscan              " Searches wrap around the end of the file.
set showcmd                 " Show (partial) command in the last line of the screen.
set showmatch               " When a bracket is inserted, briefly jump to the matching one.

set formatprg=par           " Use par as the external text formatting program
set makeprg=make\ %<        " Program to use for the :make command.
"set makeprg=make distcc=n ccache=n
"set makeprg=make
set tags=~/devel/src/**/tags,/usr/include/tags
set cindent                 " Enables automatic C program indenting.

set mouse=a                 " Enable the use of the mouse for all modes (normal, visual, insert, command

" mappings for restricting search to visual selection
"vnoremap <M-/> <Esc>/\%V
"nnoremap <M-/> /\%V

filetype on                 " Enable file type detection
filetype plugin on          " Enable filetype plugins.
filetype indent on
syntax enable               " Turn on syntax highlighting

let mapleader = ","         " set <Leader> value for mappings

colorscheme slate

" The following highlights must go after the colorscheme to avoid being overriden.
highlight LineNr ctermfg=darkgrey guifg=darkgrey 
highlight CursorLine ctermbg=darkblue term=bold cterm=bold guibg=Grey25
highlight CursorColumn ctermbg=darkblue term=bold cterm=bold guibg=Grey17
" override slate colorscheme for PreProc
highlight PreProc guibg=black   

" when I save my ~/.vimrc file, it is sourced automatically.
autocmd! BufWritePost .vimrc nested source % 
autocmd! BufWritePost _vimrc nested source %  

" Set omni completion function for python files
autocmd FileType python set omnifunc=pythoncomplete#Complete
" Set cursorcolumn for python files
autocmd FileType python setlocal cursorcolumn

" Add lilypond syntax file
autocmd BufReadPre *.ly set runtimepath+=/usr/share/lilypond/2.12.3/vim/

" autocommands for file types
autocmd Filetype plaintex source ~/.vim/source/latex.vim
autocmd Filetype tex source ~/.vim/source/latex.vim
autocmd Filetype html source ~/.vim/source/html.vim
"autocmd Filetype cpp source ~/.vim/source/cpp.vim

" disable comment autocomplete
autocmd FileType * setlocal formatoptions-=c
autocmd FileType * setlocal formatoptions-=r
autocmd FileType * setlocal formatoptions-=o

nnoremap <Leader>; ;
nnoremap ; :

" move 4 spaces to the right with tab
nmap <Tab> 4l
" move 4 spaces to the left with shift-tab
nmap <S-Tab> 4h

" Better mapping for omni-completion
imap <c-space> <c-x><c-o>

" When lines wrap, move to next wrapped line, although it's the same line.
nnoremap j gj
nnoremap k gk
vnoremap j gj
vnoremap k gk
nnoremap <Down> gj
nnoremap <Up> gk
vnoremap <Down> gj
vnoremap <Up> gk
inoremap <Down> <C-o>gj
inoremap <Up> <C-o>gk

" scroll mode with ctrl key
map <c-up> <c-y>
map <c-down> <c-e>
map <c-k> <c-y>
map <c-j> <c-e>

" smooth scrolling
map <C-U> <C-Y><C-Y><C-Y><C-Y><C-Y><C-Y><C-Y><C-Y><C-Y><C-Y><C-Y><C-Y><C-Y><C-Y><C-Y><C-Y>
map <C-D> <C-E><C-E><C-E><C-E><C-E><C-E><C-E><C-E><C-E><C-E><C-E><C-E><C-E><C-E><C-E><C-E>

" mappings to keep the current visual block selection active after changing indentation
vmap > >gv
vmap < <gv

" mapping to remove highlight search
map <Leader>/ :nohlsearch<CR>

" Line break as <Leader>b
"map <Leader>b i<CR><Esc>      


" see vimtip #159        
" for search and replace
map <F4> :%s//g<Left><Left>
" to replace word under cursor
map <S-F4> :%s/<C-r><C-w>//g<Left><Left>
" finds to the next occurence of the previously visually selected text.
vmap / y:execute "/".escape(@",'[]/\.*')<CR>
" replace selected text
vmap <F4> y:execute "%s/".escape(@",'[]/\')."//g"<Left><Left><Left>

" Use CTRL-S for saving, also in Insert mode
" (run 'stty -ixon' so it works from console)
noremap <C-S>		:update<CR>
vnoremap <C-S>		<C-C>:update<CR>
inoremap <C-S>		<C-O>:update<CR>


" Automatically change directory to the file being edited
" http://vim.wikia.com/wiki/Change_to_the_directory_of_the_current_file
" It will:
"   * use autochdir if available
"   * use an autocmd if autochdir is not available
"   * take care of non-existant directories
"   * take care of spaces in the path 
"if exists('+autochdir')
"  set autochdir
"else
"  autocmd BufEnter * silent! lcd %:p:h:gs/ /\\ /
"endif

" Mapping to change directory to the file being edited
map <silent> <Leader>cd :cd %:p:h<CR>
" Mapping to add the current file path when openning a file
map <Leader>ew :e <C-R>=expand("%:p:h") . "/" <CR>

" Always add the current file's directory to the path if not already there
autocmd BufRead *
      \ let s:tempPath=escape(escape(expand("%:p:h"), ' '), '\ ') |
      \ exec "set path-=".s:tempPath |
      \ exec "set path+=".s:tempPath

" avoid highlighting matching parens
"let loaded_matchparen = 1

" return the syntax highlighting group that the current "thing" under the
" cursor belongs to -- very useful for figuring out what to change as far as
" syntax highlighting goes.
nmap <silent> <F10> :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name")
     \ . '> trans<' . synIDattr(synID(line("."),col("."),0),"name")
     \ . "> lo<" . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name")
     \ . ">"<CR>

" Alt-Space is System menu
if has("gui")
  noremap <M-Space> :simalt ~<CR>
  inoremap <M-Space> <C-O>:simalt ~<CR>
  cnoremap <M-Space> <C-C>:simalt ~<CR>
endif

" toggle quick fix open/close
function! QFixToggle()
  if exists("g:qfix_win")
    cclose
    unlet g:qfix_win
  else
    copen 10
    let g:qfix_win = bufnr("$")
  endif
endfunction

nmap <silent> <Leader>x :call QFixToggle()<CR>

" cscope config
if has("cscope")
    set cscopeprg=/usr/bin/cscope
    set cscopetagorder=0      " use cscope db first, then tag files when calling :cstag
    set cscopetag             " use cscope for tag commands
    set nocscopeverbose
    " add any database in current directory
    if filereadable("cscope.out")
        cs add cscope.out
    " else add database pointed to by environment
    elseif $CSCOPE_DB != ""
        cs add $CSCOPE_DB
    endif
    set cscopeverbose
	set cscopequickfix=s-,c-,d-,i-,t-,e-
endif


" SECTION PLUGIN SPECIFIC

" Minibufexplorer plugin mappings
" use ctrl-up + tab or ctrl-tab
let g:miniBufExplMapWindowNavVim = 1
let g:miniBufExplMapWindowNavArrows = 1
let g:miniBufExplMapCTabSwitchBufs = 1
let g:miniBufExplModSelTarget = 1

" TagList plugin options
let Tlist_Sort_Type = "name"
:nmap <F2> :TlistToggle<cr>

" Bufferlist plugin mappings
map <silent> <F3> :call BufferList()<CR>

" FuzzyFinder plugin mappings (fuf)
nnoremap <Leader>ff :FufFile<cr>
nnoremap <Leader>fb :FufBuffer<cr>
nnoremap <Leader>fr :FufMruFile<cr>
let g:fuf_modesDisable = [ 'mrucmd' ]   " enable mrufile, since the default value is ['mrufile', 'mrucmd']

" FSwitch plugin mappings
nmap <silent> <Leader>of :FSHere<CR>

" NERD_commenter plugin
let NERDShutUp=1    " Avoid warning for unknown filetypes

" camel case motion plugin mappings
" Replace the default 'w', 'b' and 'e' mappings instead of defining additional mappings ',w', ',b' and ',e':
"map <silent> w <Plug>CamelCaseMotion_w
"map <silent> b <Plug>CamelCaseMotion_b
"map <silent> e <Plug>CamelCaseMotion_e

" Pydiction plugin settings
"let g:pydiction_location='/home/fran/.vim/ftplugin/pydiction'


" Load settings specific for local machine
source ~/.vimrc-local

