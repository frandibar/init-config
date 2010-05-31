set lines=35 columns=99
"set guioptions-=T           " Remove toolbar from GUI
set guioptions=merb

if has('win32') || has('win64')
    "set guifont=Monaco:h16
    set guifont=Consolas:h10:cANSI
elseif has('unix')
    set guifont=Consolas\ Italic\ 10
    set linespace=3
    "set guifont=Century\ Schoolbook\ L\ Italic\ 12
    "let &guifont="Monospace 10"
endif

set winaltkeys=yes
