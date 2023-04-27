if version < 600
  syntax clear
elseif exists("b:current_syntax")
  finish
endif

let b:current_syntax = "relay"

" Types
syntax keyword relayType float32 Tensor
highlight link relayType Type

" String literal
syntax region relayString start=/"/ skip=/\\"/ end=/"/
highlight link relayString String

" Keywords
syntax keyword relayKeyword def
highlight link relayKeyword Keyword
"
" Integer literal
syntax match  relayNumber /-\?\<\d\+\>/
highlight link relayNumber Number

" Identifier
syntax match relayIdentifier /[%@][-a-zA-Z$._][-a-zA-Z$._0-9\/\;]*/
syntax match relayIdentifier /[%@!]\d\+\>/
highlight link relayIdentifier Identifier

" Comment
syntax region  relayComment start=/\/\*/ skip=/\\"/ end=/\*\//
highlight link relayComment Comment
