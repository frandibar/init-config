
function! MoveBlockUp() range
    let l:topline = a:firstline - 1
    if l:topline == 0
        return
    endif
    let l:bottomline = a:lastline - 1
    "save unnamed register to avoid side effects
    let l:copyreg = @"
    execute l:topline . 'delete'
    execute l:bottomline . 'put'
    "restore unnamed register
    let @" = l:copyreg
    " visually select block again
    execute 'normal! ' . l:topline . 'ggV' . l:bottomline . 'gg'
endfunction

function! MoveBlockDown() range
    let l:topline = a:firstline - 1
    let l:bottomline = a:lastline + 1
    if l:bottomline == getpos('$')[1] + 1
        return
    endif
    "save unnamed register to avoid side effects
    let l:copyreg = @"
    execute l:bottomline . 'delete'
    execute l:topline . 'put'
    "restore unnamed register
    let @" = l:copyreg
    " visually select block again
    execute 'normal! ' . (l:topline + 2) . 'ggV' . l:bottomline . 'gg'
endfunction

vmap <leader>k :call MoveBlockUp()<CR>
vmap <leader>j :call MoveBlockDown()<CR>

