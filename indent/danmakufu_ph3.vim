" This file has been derived from a portion of zig.vim's code.
" Repository available at: https://github.com/ziglang/zig.vim
" License: The MIT License (Expat)
"
" Copyright (c) 2017 Andrew Kelley
"
" Permission is hereby granted, free of charge, to any person obtaining a copy
" of this software and associated documentation files (the "Software"), to deal
" in the Software without restriction, including without limitation the rights
" to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
" copies of the Software, and to permit persons to whom the Software is
" furnished to do so, subject to the following conditions:
"
" The above copyright notice and this permission notice shall be included in
" all copies or substantial portions of the Software.
"
" THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
" IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
" FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
" AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
" LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
" OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
" THE SOFTWARE.

if exists("b:did_indent")
  finish
else
  let b:did_indent = 1
endif

if has("cindent")
  setlocal cindent
endif

" L0 -> 0 indent for jump labels (i.e. case statement in c).
" m1 -> if `)` starts a line, match its indent with the first char of its
"       matching `(` line
" (s -> use one indent, when starting a new line after a trailing `(`
" j1 -> indenting for "javascript object declarations"
" J1 -> see j1
" w1 -> starting a new line with `(` at the same indent as `(`
setlocal cinoptions=L0,m1,(s,j1,J1,l1

" cinkeys: controls what keys trigger indent formatting
" 0{ -> {
" 0} -> }
" 0) -> )
" 0] -> ]
" !^F -> make CTRL-F (^F) reindent the current line when typed
" o -> when <CR> or `o` is used
" O -> when the `O` command is used
setlocal cinkeys=0{,0},0),0],!^F,o,O

setlocal indentexpr=GetPh3Indent(v:lnum)

function! GetPh3Indent(lnum)
  let current_line_n = a:lnum
  let current_line = getline(a:lnum)

  let prev_line_n = prevnonblank(a:lnum - 1)
  let prev_line = getline(prev_line_n)

  " indentation for `case`s in an `alternative` statement
  if current_line =~ '\v^\s*<case>'
    return indent(prev_line_n)
  endif

  " for lines that look like
  "   },
  "   };
  " try treating them the same as a }
  if prev_line =~ '\v^\s*}\s*[,;]\s*$'
    if current_line =~ '\v^\s*}\s*[,;]?\s*$'
      return indent(prev_line_n) - 4
    endif

    return indent(prev_line_n - 1) - 4
  endif

  return cindent(a:lnum)
endfunction

" vim: sw=2 et
