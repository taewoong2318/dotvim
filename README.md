Simple Vim powered by LSP and AI

## Requirements

- Vim (9.0.0185 or newer)
- Node.js
- some language servers (mentioned below)

## Installation

Clone this repository including submodules:

```sh
cd ~
mv .vim .vim-backup
git clone --recurse-submodules -j8 https://github.com/e2318501/.vim.git
```

After cloning the repository, install language servers into specific pathes described in [this file](https://github.com/e2318501/.vim/blob/main/pack/pkgconf/opt/lsp-conf/plugin/lsp-conf.vim).
