# Taewoong's Vim Configuration

Vim configuration with portability in mind, for Linux, macOS, and Windows

![Opening the Vim source code on Vim](https://github.com/user-attachments/assets/28ca51bf-6e5b-4fd4-b735-61b58d1af552)

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
> `git clean -dff` will remove all untracked files and directories in the local repository
