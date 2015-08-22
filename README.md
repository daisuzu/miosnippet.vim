miosnippet
==========

This plugin generates a snippet of the `Method signature` in `Insert mode` from `omnifunc`
for [neosnippet](https://github.com/Shougo/neosnippet.vim).

## Requirements

* [neosnippet](https://github.com/Shougo/neosnippet.vim)
* omni completion plugin
    * [vim-go](https://github.com/fatih/vim-go)
    * [jedi-vim](https://github.com/davidhalter/jedi-vim)

## Installation

```vim
" NeoBundle
NeoBundle 'daisuzu/miosnippet.vim'
```

## Usage

```vim
imap <C-]> <Plug>(miosnippet_generate)
```

## License

[MIT](https://github.com/daisuzu/miosnippet.vim/blob/master/LICENSE)
