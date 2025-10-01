# dotvim

Taewoong's Vim configuration

## Requirements

- Git
- Vim 8.2.1978 or later

## Installation

Clone this repository to the following directory:

| Platform | Vim        | Location                           |
| -------- | ---------- | ---------------------------------- |
| Unix     | >= 9.1.327 | `~/.vim` or `$XDG_CONFIG_HOME/vim` |
| Unix     | < 9.1.327  | `~/.vim`                           |
| Windows  |            | `%USERPROFILE%\vimfiles`           |

Then move into the repository and update submodules to install plugins:

    git submodule update --init

## Updating

Pull new changes, update submodules, and clean unused submodules:

    git pull
    git submodule update --init
    git clean -dff

Note that `git clean -dff` will remove **all untracked files and directories**
in the local repository. To check what will be removed, run `git clean -dffn`.

## Help Tags

Run the following command inside Vim to generate the help tags for the plugin
documentations:

    :helptags ALL

## LSP Support

It is optional to install language servers but offers useful functionalities
for programming. See [vimrc](vimrc) for details.
