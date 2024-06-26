# Madhouse

Jony Kalavera's, chezmoi dot-files repo.

# Quick setup

Install required packages. For arch:
```bash
sudo pacman -Sy chezmoi
sudo pacman -Sy fzf
sudo pacman -Sy fd
sudo pacman -Sy bat
sudo pacman -Sy btop
sudo pacman -Sy neovim
sudo pacman -Sy nvm
sudo pacman -Sy tldr
sudo pacman -Sy dust
```

Restore dot-files with `chezmoi`.
```
chezmoi init git@github.com:jonykalavera/madhouse.git
chezmoi update -v
```
For more details check https://www.chezmoi.io/user-guide/command-overview/#daily-commands
