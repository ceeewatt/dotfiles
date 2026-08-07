This repository is intended to hold the configuration files (dotfiles) for the Unix utilities used across my various machines.

We're using [chezmoi](www.chezmoi.io), the dotfile management tool that allows for declaratively defining your configurations across many diverse machines in a single source of truth.

At present, I use two primary x86_64 desktops: One running Fedora 44; the other running Windows with Ubuntu on WSL. My chezmoi configuration will largely be designed around these machines.

These are the tools for which I need to manage the configuration of:
- Shell: bash
- Terminal: alacritty
- Terminal multiplexer: zellij
- other utilities: fzf, zoxide, starship, and more to be added...

# TODO

- nvim
- vscode
- gnome/dconf
- notes repo

# WIP: Setup Instructions

My chezmoi configuration, at present, is a work in progress. As such, a new machine will require some manual configuration alongside the use of chezmoi.

1) Install KeePassXC password manager. On WSL, install natively on Windows.

From cloud storage, download the kdbx database(s). Manually import the ssh keys and ssh config file to `~/.ssh`, and set file permissions appropriately:

```sh
cd ~/.ssh
keys='id_rsa id_ed25519 ...'
for k in "$keys"; do
    # Generate corresponding public key
    ssh-keygen -y -f $k > ${k}.pub

    # Restrict file permissions
    chmod 600 $k
    chmod 644 ${k}.pub
done

chmod 700 ~/.ssh
```

2) Configure sudo: edit sudoers file via `visudo`.

Run `sudo visudo -f /etc/sudoers.d/${USER}` and append a line of the following form: `<user> ALL=(ALL:ALL) NOPASSWD: ALL`.

3) Ensure prequisite system packages are installed: git

4) Install and initialize chezmoi

The following commands should install the chezmoi executable to `~/opt` and create a symbolic link in `~/.local/bin`. Once installed, run the `chezmoi init` command to clone this repo and initialize the local chezmoi installation. Note that this command uses the SSH url, which relies on the configuration added in step 1.

```sh
mkdir -p ~/opt ~/.local/bin
sh -c "$(curl -fsLS https://get.chezmoi.io)" -- -b ~/opt
ln -sf ~/opt/chezmoi ~/.local/bin
chezmoi init -S ~/dev/home/dotfiles home.github.com:ceeewatt/dotfiles.git
```

5) Apply changes with: `chezmoi apply`

6) Manual steps for Windows/WSL

At present, I'm using the default Windows Terminal rather than Alacritty. To match my Alacritty config, manually install the appropriate nerd font and theme.

Nerd font:
- Download an unzip `https://github.com/ryanoasis/nerd-fonts/releases/latest/download/JetBrainsMono.zip`.
- Select all `*.ttf` files, right click, and select `Install`.
- Select `JetBrainsMono Nerd Font` under `Profiles` > `Ubuntu` > `Appearance`.

Gruvbox Dark theme:
- Copy the JSON scheme object from `github.com/runxel/gruvbox-iterm`.
- Under terminal settings, click `Open JSON file` to open `settings.json`.
- Paste the JSON object under `schemes`. Save the file. The theme should then appear as an option under `Profiles` > `Ubuntu` > `Appearance`.
