augroup danmakufu_ph3
  au BufRead,BufNewFile *.dnh set filetype=danmakufu_ph3
  au BufRead,BufNewFile *.txt call CheckForPh3Txt()
augroup end

function! CheckForPh3Txt()
  " Attempt to detect if the current text file is danmakufu ph3 code.
  "
  " This might not work in all situations - such as the files present in
  " the `default_system` folder, since they don't usually have headers.

  " If `ph3_disable_txt_check` is set, don't check for that.
  if get(b:, "ph3_disable_txt_check", get(g:, "ph3_disable_txt_check", 0))
    return
  endif

  if getline(1) =~ '\v^#\w+(\[\w*\])?$'
    set filetype=danmakufu_ph3
  endif
endfunction

" vim: sw=2 et
