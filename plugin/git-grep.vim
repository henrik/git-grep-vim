let g:gitgrepprg="git\\ grep\\ -En"
let g:gitgrepformat="%f:%l:%m,%f:%l%m,%f\\ \\ %l%m"

function! s:GitGrep(cmd, args)
    let grepprg_bak=&grepprg
    let grepformat_bak=&grepformat
    exec "set grepprg=" . g:gitgrepprg
    exec "set grepformat=" . g:gitgrepformat

    let l:grepargs = a:args
    " Escape pipes in e.g. :GitGrep "foo|bar"
    let l:grepargs = escape(l:grepargs, '|')
    " Escape again if piped argument is unquoted, e.g. :GitGrep foo|bar
    if l:grepargs =~ '\(^\|\s\)[^"'']\S*|'
      let l:grepargs = escape(l:grepargs, '|')
    endif

    silent execute a:cmd . " " . l:grepargs

    if a:cmd =~# '^l'
      topleft lopen
    else
      topleft copen
    endif

    let &grepprg=grepprg_bak
    let &grepformat=grepformat_bak
    exec "redraw!"
endfunction

command! -nargs=* -complete=file GitGrep call s:GitGrep('grep<bang>', <q-args>)
command! -nargs=* -complete=file GitGrepAdd call s:GitGrep('grepadd<bang>', <q-args>)
command! -nargs=* -complete=file LGitGrep call s:GitGrep('lgrep<bang>', <q-args>)
command! -nargs=* -complete=file LGitGrepAdd call s:GitGrep('lgrepadd<bang>', <q-args>)
