Vim configuration with portability in mind, for Linux, macOS, and Windows

## Requirements

- Vim 9.0 or later

## Installation

Clone this repository and update submodules to install plugins:

    git clone https://github.com/taewoong2318/dotvim.git ~/.config/vim
    cd $_
    git submodule update --init

On Windows, adjust the configuration path (~\vimfiles) and do the same things.

## Updating

Pull new changes and clean unused submodules:

    cd ~/.config/vim
    git pull
    git clean -dff

> [!WARNING]
> This operation will remove all untracked files and directories.
