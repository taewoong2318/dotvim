# Taewoong's Vim Configuration

Vim configuration with portability in mind, for Linux, macOS, and Windows

## Requirements

- Vim 9.0 or later

## Installation

Clone this repository to the following directory:

| Platform  | Vim       | Location                                  |
| --------- | --------- | ----------------------------------------- |
| Unix      | >=9.1.327 | `$XDG_CONFIG_HOME/vim` or `~/.config/vim` |
| Unix      | <9.1.327  | `~/.vim`                                  |
| Windows   |           | `~\vimfiles`                              |

Then move into the repository and update submodules to install plugins:

    git submodule update --init

## Updating

Pull new changes, update submodules, and clean unused submodules (if needed):

    git pull
    git submodule update --init
    git clean -dff

> [!WARNING]
> `git clean -dff` will remove all untracked files and directories.
