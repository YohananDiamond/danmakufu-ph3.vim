if exists("b:current_syntax")
  finish
endif
let b:current_syntax = "danmakufu_ph3"

syn match ph3Number /\v[0-9]+/
syn match ph3Indentifier /\v[a-zA-Z_][a-zA-Z0-9_]*/

syn match ph3DeclKeyword /\v<(let|function|task)>/
syn match ph3Keyword /\v<(alternative|ascent|break|case|descent|else|if|in|local|loop|others|real|return|sub|times|while|yield)>/
syn match ph3Preprocessor /\v^\s*#include\s*/
syn match ph3Builtin /\v<(add|append|compare|concatenate|divide|false|index|length|multiply|negative|not|pi|power|predecessor|remainder|result|slice|successor|subtract|true|max|power|floor)>/

" FIXME: there should be a ph3Indentifier in the contains here, too, but
" I don't wanna highlight it in the start string.
syn region ph3Metadata matchgroup=ph3MetadataDelim start=/\v^\s*#[a-zA-Z_][a-zA-Z0-9_]*\[/ end=/\v\]/ contains=ph3String,ph3Number

syn region ph3Comment start=/\/\// end=/$/
syn region ph3Comment start=/\/\*/ end=/\*\//

syn region ph3String start=/"/ end=/"/ skip=/\\"/

syn match ph3InvalidAts /\v\@[a-zA-Z_][a-zA-Z0-9_]*>/
syn match ph3AtThingies /\v\@(Initialize|Event|MainLoop|Finalize|Loading)>/

hi link ph3DeclKeyword Function
hi link ph3Keyword Keyword
hi link ph3MetadataDelim PreProc
hi link ph3Preprocessor PreProc
hi link ph3Comment Comment
hi link ph3String String
hi link ph3AtThingies Statement
hi link ph3InvalidAts ErrorMsg
hi link ph3Builtin Special
hi link ph3Number Number

" vim: sw=2 et
