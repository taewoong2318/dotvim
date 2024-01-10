Simple looking Vim powered by LSP and AI

## Requirements

- Vim (9.0.0185 or newer)
- Node.js
- some language servers (mentioned below)

## Installation

Clone this repository and install plugins:

```sh
mv ~/.vim ~/.vim-backup
git https://github.com/e2318501/dotvim.git ~/.vim
vim +PlugInstall +qa
```

After that, install language servers into specific pathes described in [vimrc](https://github.com/e2318501/dotvim/blob/main/vimrc).
