" File: autoload/miosnippet.vim
" Author: daisuzu <daisuzu@gmail.com>
" URL: https://github.com/daisuzu/miosnippet.vim
" License: MIT

let s:save_cpo = &cpo
set cpo&vim

" config {{{
let s:miosnippet_config = {}

" gocode, vim-go-extra
let s:miosnippet_config['gocomplete#Complete'] = {
            \   'pattern': 'func \(\w\+\)(\([^)]*\))\s*(\?\([^)]*\))\?',
            \   'name': 1,
            \   'parameters': 2,
            \   'returns': 3,
            \   'delimiter': ', ',
            \ }

" vim-go
let s:miosnippet_config['go#complete#Complete'] =
            \ s:miosnippet_config['gocomplete#Complete']

" jedi-vim
let s:miosnippet_config['jedi#completions'] = {
            \   'pattern': '\(\w\+\)(\([^)]*\))',
            \   'name': 1,
            \   'parameters': 2,
            \   'returns': 0,
            \   'delimiter': ', ',
            \ }
" }}}

" internal functions {{{
function! s:echo_warning(msg)
    echohl WarningMsg | echo a:msg | echohl None
endfunction

function! s:get_candidates()
    return [get(v:, 'completed_item', {})]
endfunction

function! s:get_config()
    return get(s:miosnippet_config, &omnifunc, {})
endfunction

function! s:parse_signature(signature, config)
    let parsed = {'name': '', 'parameters': [], 'returns': []}

    let l = matchlist(a:signature, a:config.pattern)
    if !len(l)
        return parsed
    endif

    let parsed.name = get(a:config, 'name', 0) ? l[a:config.name] : ''
    let parsed.parameters = get(a:config, 'parameters', 0) ?
                \ split(l[a:config.parameters], a:config.delimiter) : []
    let parsed.returns = get(a:config, 'returns', 0) ?
                \ split(l[a:config.returns], a:config.delimiter) : []

    return parsed
endfunction

function! s:make_snip(parsed, config)
    let parameters = a:parsed.parameters
    return join(
                \   map(
                \       deepcopy(parameters),
                \       'printf("<`%d:%s`>", index(parameters, v:val), v:val)'
                \   ),
                \   a:config.delimiter
                \ )
endfunction

function! s:str_to_insert(name, snip, line)
    return a:snip
endfunction

" }}}

function! miosnippet#generate()
    let cursor_pos = col('.') - 1

    let candidates = s:get_candidates()
    if !len(candidates)
        call s:echo_warning('no candidates')
        return ''
    endif

    let config = s:get_config()
    if config == {}
        call s:echo_warning('no config')
        return ''
    endif

    let parsed = s:parse_signature(candidates[0].info, config)
    let snip = s:make_snip(parsed, config)

    let str = s:str_to_insert(parsed.name, snip, getline('.'))
    if str == ''
        call s:echo_warning('inappropriate str')
        return ''
    endif

    return printf("%s\<ESC>0%dli", str, cursor_pos)
endfunction

let &cpo = s:save_cpo
unlet s:save_cpo

" vim: foldmethod=marker
