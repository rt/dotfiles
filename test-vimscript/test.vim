
command! SH call <SID>sayHello()

function! s:sayHello(...)
  let colors = {
        \ "apple": "red",
        \ "banana": "yellow",
        \}
  echo colors["apple"]
  echo get(colors, "apple")
endfunction

function! GetBackingFile(filename)
  let l:hyphenIndex = stridx(a:filename, "-")
  echo l:hyphenIndex
  if (l:hyphenIndex > 0)
    Ggrep substitute(a:filename, "-", "_", "g")
  else
    Ggrep substitute(a:filename, "_", "-", "g")
  endif
endfunction
