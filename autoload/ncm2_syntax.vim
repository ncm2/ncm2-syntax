"=============================================================================
" FILE: ncm2_syntax.vim
" AUTHOR:  Jia Sui <jsfaint@gmail.com>
" License: MIT license
"=============================================================================

if get(s:, 'loaded', 0)
    finish
endif
let s:loaded = 1

let s:initialized = 0

function! ncm2_syntax#on_complete(ctx) abort
  if !s:initialized
    call necosyntax#initialize()
    let s:initialized = 1
  endif

  let ccol = a:ctx['ccol']
  let typed = a:ctx['typed']

  let kw = matchstr(typed, '\w')
  let kwlen = len(kw)

  let matches = necosyntax#gather_candidates()
  let startccol = ccol - kwlen

  call ncm2#complete(a:ctx, startccol, matches)
endfunction

function! ncm2_syntax#init() abort
  call ncm2#register_source({ 'name': 'syntax',
        \ 'mark': 'syntax',
        \ 'priority': 8,
        \ 'on_complete': 'ncm2_syntax#on_complete',
        \ })
endfunction
