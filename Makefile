SHELL := /bin/bash

clean-downloads:
	# https://github.com/risabhRizz/DownloadsOrganizer
	cd Downloads && java -jar DownloadsOrganizer.jar

setup:
	sudo pacman -Syu
	sudo pacman -Sy --needed base-devel git
	yay -Sy install \
		bat \
		chezmoi \
		docker \
		docker-compose \
		dust \
		entr \
		eza \
		fd \
		feh \
		fzf \
		git-delta \
		git\
		github-cli \
		imagemagick \
		imv \
		k9s \
		lazygit \
		luarocks \
		mariadb-clients \
		mariadb-libs \
		neovim \
		plantuml \
		pyenv \
		redis \
		ripgrep \
		starship \
		tldr \
		tmux \
		tmuxp \
		zoxide
	sudo luarocks install magick --lua-version 5.1
	if [[ ! -d $$HOME/.fzf-git.sh ]]; then git clone git@github.com:junegunn/fzf-git.sh.git .fzf-git.sh; fi
	cd .config/nvim
	if [[ ! -d ~/.config/nvim/venv ]]; then python -m venv ~/.config/nvim/venv; fi
	$$HOME/.config/nvim/venv/bin/pip install -r $$HOME/.config/nvim/requirements.txt
	if [[ ! -d ~/.tmux/plugins/tpm ]]; then git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm; fi
	curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash
	curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

linux-setup: setup
	yay -Sy \
		dry-bin \
		awsvpnclient \
		1password-cli \
		1password

chezmoi-all:
	chezmoi re-add
	chezmoi git -- add .
	chezmoi git -- commit -m "🤖 Auto-add-all 💀 from 🖳  $$(hostname)"
	chezmoi git -- push
