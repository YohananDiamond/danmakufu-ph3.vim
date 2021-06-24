if exists("b:did_ftplugin")
  finish
else
  let b:did_ftplugin = 1
endif

if has("comments")
  setlocal commentstring=//\ %s
endif

" vim: sw=2 et
