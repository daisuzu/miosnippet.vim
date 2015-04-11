" File: plugin/miosnippet.vim
" Author: daisuzu <daisuzu@gmail.com>
" URL: https://github.com/daisuzu/miosnippet.vim
" License: MIT

if exists('g:loaded_miosnippet')
  finish
endif
let g:loaded_miosnippet = 1

let s:save_cpo = &cpo
set cpo&vim

inoremap <silent><expr> <Plug>(miosnippet_generate) miosnippet#generate()

let &cpo = s:save_cpo
unlet s:save_cpo
