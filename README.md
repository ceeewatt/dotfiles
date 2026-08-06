This repository is intended to hold the configuration files (dotfiles) for the Unix utilities used across my various machines.

We're using [chezmoi](www.chezmoi.io), the dotfile management tool that allows for declaratively defining your configurations across many diverse machines in a single source of truth.

At present, I use two primary x86_64 desktops: One running Fedora 44; the other running Windows with Ubuntu on WSL. My chezmoi configuration will largely be designed around these machines.

These are the tools for which I need to manage the configuration of:
- Shell: bash
- Terminal: alacritty
- Terminal multiplexer: zellij
- other utilities: fzf, zoxide, starship, and more to be added...

# TODO

- Install system packages
    - curl
    - pipx
    - C/C++ devel tools
- Install third party tools
    - zellij
    - tldr
    - node & bun
    - cargo
- SSH & password manager integration
- nvim
- vscode

# WIP: Setup Instructions

My chezmoi configuration, at present, is a work in progress. As such, a new machine will require some manual configuration alongside the use of chezmoi.

1) Install KeePassXC password manager. On WSL, install natively on Windows.

From cloud storage, download the kdbx database(s). Manually import the ssh keys and ssh config file to `~/.ssh`.

2) Configure sudo: edit sudoers file via `visudo`.

Run `sudo visudo -f /etc/sudoers.d/${USER}` and append a line of the following form: `<user> ALL=(ALL:ALL) NOPASSWD: ALL`.

3) Ensure prequisite system packages are installed: git

4) Install and initialize chezmoi

The following command should install chezmoi, clone this repo, and initialize itself. Note that the command uses the SSH url, which relies on the configuration added in step 1.

`sh -c "$(curl -fsLS https://get.chezmoi.io)" -- init -S ~/dev/home/dotfiles home.github.com:ceeewatt/dotfiles.git`

5) Apply changes with: `chezmoi apply`
