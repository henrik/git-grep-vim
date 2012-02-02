let g:gitgrepprg="git\\ grep\\ -n"

function! s:GitGrep(cmd, args)
    let grepprg_bak=&grepprg
    exec "set grepprg=" . g:gitgrepprg

    silent execute a:cmd . " " . a:args

    if a:cmd =~# '^l'
      topleft lopen
    else
      topleft copen
    endif

    let &grepprg=grepprg_bak
    exec "redraw!"
endfunction

command! -nargs=* -complete=file GitGrep call s:GitGrep('grep<bang>', <q-args>)
command! -nargs=* -complete=file GitGrepAdd call s:GitGrep('grepadd<bang>', <q-args>)
command! -nargs=* -complete=file LGitGrep call s:GitGrep('lgrep<bang>', <q-args>)
command! -nargs=* -complete=file LGitGrepAdd call s:GitGrep('lgrepadd<bang>', <q-args>)
