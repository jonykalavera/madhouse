# Madhouse

Jony Kalavera's Personalized [chezmoi](https://www.chezmoi.io) Repository

![Hero-banner](./Pictures/madhouse-hero-banner.jpg "Hero-banner")

## Quick Setup

To get started, first ensure you have all the necessary tools installed. For Arch Linux users:

```bash
sudo pacman -Sy chezmoi fzf fd bat btop neovim nvm tldr dust git-delta btop
git clone git@github.com:junegunn/fzf-git.sh.git .fzf-git.sh
```

Next, restore your dotfiles using chezmoi. Simply run:

```bash
chezmoi init git@github.com:jonykalavera/madhouse.git
chezmoi update -v
```

For more detailed information on daily commands and usage, please consult the official [chezmoi documentation](https://www.chezmoi.io/user-guide/command-overview/#daily-commands).

## Neovim Configuration

To set up your neovim environment, create a virtual environment:

```bash
cd .config/nvim
python -m venv venv
./venv/bin/pip install -r requirements.txt
```
