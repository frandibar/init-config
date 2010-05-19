" My personal Vim settings file

set nocompatible            " Make Vim behave in a more useful way instead of being Vi-compatible.
set noswapfile              " Don't use a swapfile for the buffer.  Don't use this for big files!
set autowrite               " Write the contents of the file, if it has been modified, when changing buffers.
set nobackup                " Don't make a backup before overwriting a file.
set wildignore=*.o,*.obj,*.bak " Patterns to ignore when completing file or directory names.
set autoread                " Automatically read files changed outside of vim
set hidden                  " Change buffer without saving

set nowrap                  " Don't wrap lines longer than the width of the window on the next line.
set scrolloff=2             " Minimal number of screen lines to keep above and below the cursor.
set laststatus=2            " Always have status line for each window.
set ruler                   " Show the line and column number of the cursor position, separated by a
set backspace=indent,eol,start  " Influences the working of <BS>, <Del>, CTRL-W and CTRL-U in Insert mode.
set cursorline              " Highlight the screen line of the cursor.
set number                  " Print the line number in front of each line.
set wildmenu                " Possible matches are shown just above the command line, with the

set expandtab               " Use the appropriate number of spaces to insert a <Tab>
set shiftwidth=4            " Number of spaces to use for each step of (auto)indent.
set tabstop=4               " Number of spaces that a <Tab> in the file counts for. 
set softtabstop=4           " Number of spaces that a <Tab> counts for while performing editing operations, like inserting a <Tab> or using <BS>. 

set hlsearch                " When there is a previous search pattern, highlight all its matches.
set ignorecase              " Case is ignored for searches
set incsearch               " While typing a search command, show where the pattern, as it was typed so far, matches. 
set nowrapscan              " Searches wrap around the end of the file.  Also applies to |]s| and

set makeprg=make\ %<        " Program to use for the :make command.
set cindent                 " Enables automatic C program indenting.
set shellslash              " Use a forward slash when expanding file names.
set background=dark         " Vim will try to use colors that look good on a dark background.
set mouse=a                 " Enable the use of the mouse for all modes (normal, visual, insert, command

filetype plugin on          " Enable filetype plugins.
syntax on                   " Turn on syntax highlighting

colorscheme slate
" The following highlights must go after the colorscheme to avoid being overrided.
highlight LineNr ctermfg=darkgrey guifg=darkgrey 
highlight CursorLine ctermbg=darkblue term=bold cterm=bold guibg=Grey25
" override slate colorscheme for PreProc
highlight PreProc guibg=black   

" when I save my ~/.vimrc file, it is sourced automatically.
au! BufWritePost .vimrc nested source % 
au! BufWritePost _vimrc nested source %  

" Set omni completion function for python files
autocmd FileType python set omnifunc=pythoncomplete#Complete

" Add lilypond syntax file
autocmd BufReadPre *.ly set runtimepath+=/usr/share/lilypond/2.12.3/vim/

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

" scroll up and down with ctrl-up/down
map <C-Down> <C-e>
map <C-Up> <C-y>

let mapleader = ","

" mapping to remove highlight search
map <Leader>s :nohlsearch<CR>
" mapping to buffer delete
noremap <Leader>bd :bd<CR>

" Line break as <Leader>b
map <Leader>b i<CR><Esc>      

" see vimtip #159        
" for search and replace
map <F4> :%s//g<Left><Left>
" to replace word under cursor
map <S-F4> :%s/<C-r><C-w>//g<Left><Left>
" finds to the next occurence of the previously visually selected text.
vmap / y:execute "/".escape(@",'[]/\.*')<CR>
" replace selected text
vmap <F4> y:execute "%s/".escape(@",'[]/\')."//g"<Left><Left><Left>

" autocommands for file types
autocmd Filetype plaintex source ~/.vim/source/latex.vim
autocmd Filetype tex source ~/.vim/source/latex.vim
autocmd Filetype html source ~/.vim/source/html.vim
autocmd Filetype cpp source ~/.vim/source/cpp.vim

" Use CTRL-S for saving, also in Insert mode
" (run 'stty -ixon' so it works from console)
noremap <C-S>		:update<CR>
vnoremap <C-S>		<C-C>:update<CR>
inoremap <C-S>		<C-O>:update<CR>


set pdev=MP180      " Configure local printer

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

" Always add the current file's directory to the path if not already there
autocmd BufRead *
      \ let s:tempPath=escape(escape(expand("%:p:h"), ' '), '\ ') |
      \ exec "set path-=".s:tempPath |
      \ exec "set path+=".s:tempPath

" Minibufexplorer plugin mappings
" use ctrl-up + tab or ctrl-tab
let g:miniBufExplMapWindowNavVim = 1
let g:miniBufExplMapWindowNavArrows = 1
let g:miniBufExplMapCTabSwitchBufs = 1
let g:miniBufExplModSelTarget = 1

" TagList plugin options
let Tlist_Sort_Type = "name"
:nmap <F2> :TlistToggle<cr>

" exUtility plugin mappings
"nnoremap <silent> <F5> :ExgsToggle<CR>
"nnoremap <silent> <Leader>gs :ExgsSelectToggle<CR>
"nnoremap <silent> <Leader>gq :ExgsQuickViewToggle<CR>
"nnoremap <silent> <Leader>gt :ExgsStackToggle<CR>
""map <S-f> :GS 
"map <C-S-f> :GSW 
"let g:exGS_backto_editbuf = 0
"let g:exGS_close_when_selected = 0


" FuzzyFinder plugin mappings
nnoremap <Leader>ff :FuzzyFinderFile<cr>
nnoremap <Leader>fb :FuzzyFinderBuffer<cr>
nnoremap <Leader>fr :FuzzyFinderMruFile<cr>

" FSwitch plugin mappings
nmap <silent> <Leader>of :FSHere<CR>

" Alt-Space is System menu
if has("gui")
  noremap <M-Space> :simalt ~<CR>
  inoremap <M-Space> <C-O>:simalt ~<CR>
  cnoremap <M-Space> <C-C>:simalt ~<CR>
endif

" avoid highlighting matching parens
let loaded_matchparen = 1

" disable comment autocomplete
au FileType * setl fo-=cro

" return the syntax highlighting group that the current "thing" under the
" cursor belongs to -- very useful for figuring out what to change as far as
" syntax highlighting goes.
nmap <silent> <F10> :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name")
     \ . '> trans<' . synIDattr(synID(line("."),col("."),0),"name")
     \ . "> lo<" . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name")
     \ . ">"<CR>

" nerd_commenter
let NERDShutUp=1    " Avoid warning for unknown filetypes

" pydiction plugin settings
"let g:pydiction_location='/home/fran/.vim/ftplugin/pydiction'

" bufferlist
map <silent> <F3> :call BufferList()<CR>

" workplace specific
"set path+=w:\**
"set complete=.      " set the matches for insert mode completion to current file
"set keywordprg=~/help.bat

