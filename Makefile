SHELL := /bin/bash

clean-downloads:
	# https://github.com/risabhRizz/DownloadsOrganizer
	cd Downloads && java -jar DownloadsOrganizer.jar

install:	
	sudo pamac install \
		bat btop btop \
		chezmoi \
		docker \
		docker-compose \
		dust \
		eza \
		fd \
		fzf \
		git\
		lazygit \
		neovim \
		pyenv \
		ripgrep \
		tldr \
		tmux \
		tmuxp \
		zoxide \
		git-delta \
		imv \
		github-cli \
		dry-bin \
		redis \
		entr \
		plantuml \
		feh \
		1password \
		1password-cli \
		mariadb-clients \
		mariadb-libs \
		awsvpnclient \
		k9s \
		luarocks \
		imagemagick \
		starship
	sudo luarocks install magick --lua-version 5.1
	if [[ ! -d $$HOME/.fzf-git.sh ]]; then git clone git@github.com:junegunn/fzf-git.sh.git .fzf-git.sh; fi
	cd .config/nvim
	if [[ ! -d ~/.config/nvim/venv ]]; then python -m venv ~/.config/nvim/venv; fi
	$$HOME/.config/nvim/venv/bin/pip install -r $$HOME/.config/nvim/requirements.txt
	if [[ ! -d ~/.tmux/plugins/tpm ]]; then git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm; fi
	if [[ ! -f ~/.emoji-prompt.sh ]]; then curl 'https://raw.githubusercontent.com/jonykalavera/emoji-prompt/master/emoji-prompt.sh' > ~/.emoji-prompt.sh; fi
	curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash
	curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh


chezmoi-all:
	chezmoi re-add
	chezmoi git -- add .
	chezmoi git -- commit -m "🤖 Auto-add-all 💀 from 🖳  $$(hostname)"
	chezmoi git -- push
