#!/bin/bash -eux
set -o pipefail

dotfiles=$(readlink -f "$(dirname "$0")")
cd

. /etc/os-release

if [[ $ID = arch ]]; then
	# enable multilib repositories
	grep '^\[multilib\]$' /etc/pacman.conf > /dev/null || sudo tee -a /etc/pacman.conf > /dev/null << EOF
[multilib]
Include = /etc/pacman.d/mirrorlist
EOF

	# enable colors in pacman and yay
	sudo sed -i 's/#Color/Color/' /etc/pacman.conf

	# install yay
	if ! which yay; then
		sudo pacman --needed --noconfirm -S base-devel go git
		rm -rf yay
		git clone https://aur.archlinux.org/yay.git
		pushd yay
		makepkg -i --needed --noconfirm
		popd
		rm -rf yay
	fi

	# install all packages
	yay --needed --noconfirm -Syu \
		arc-gtk-theme \
		bat \
		evince \
		eza \
		file-roller \
		foomatic-db-{engine,gutenprint-ppds} \
		gdm \
		git-delta \
		gnome-backgrounds \
		gnome-browser-connector \
		gnome-calculator \
		gnome-control-center \
		gnome-keyring \
		gnome-logs \
		gnome-menus \
		gnome-screenshot \
		gnome-session \
		gnome-shell \
		gnome-shell-extensions \
		gnome-system-monitor \
		gnome-text-editor \
		gnome-tweak-tool \
		gst-libav \
		gutenprint \
		htop \
		libgit2 \
		libgnome-keyring \
		loupe \
		nautilus \
		neovim \
		net-tools \
		networkmanager \
		noto-fonts-emoji \
		ntfs-3g \
		numix-circle-icon-theme \
		openssh \
		python-neovim \
		tokei \
		totem \
		unrar \
		wget \
		xclip \
		zsh \
		zsh-syntax-highlighting
elif [[ $ID = debian ]]; then
	su root -c "
	if ! grep contrib /etc/apt/sources.list; then
		sed -i 's/ main/ main contrib/g' /etc/apt/sources.list
	fi
	dpkg --add-architecture i386
	apt-get update
	apt-get install -y \
		arc-theme \
		bat \
		cups \
		curl \
		evince \
		eza \
		fonts-liberation \
		fonts-noto-color-emoji \
		gcc \
		git-delta \
		gnome-backgrounds \
		gnome-boxes \
		gnome-calculator \
		gnome-console \
		gnome-console \
		gnome-disk-utility \
		gnome-shell \
		gnome-shell-extension-appindicator \
		gnome-shell-extension-blur-my-shell \
		gnome-shell-extension-dashtodock \
		gnome-shell-extension-places-menu \
		gnome-shell-extension-system-monitor \
		gnome-shell-extension-tiling-assistant \
		gnome-snapshot \
		gnome-system-monitor \
		gnome-text-editor \
		gvfs-backends \
		gvfs-fuse \
		htop \
		libpam-gnome-keyring \
		libsecret-1-dev \
		libssl-dev \
		loupe \
		neovim \
		net-tools \
		numix-icon-theme-circle \
		pkg-config \
		rustup \
		ssh \
		steam-installer \
		sudo \
		system-config-printer-{common,udev} \
		systemd-boot \
		tokei \
		xh \
		zsh \
		zsh-syntax-highlighting
	make --directory=/usr/share/doc/git/contrib/credential/libsecret
	apt-get --allow-remove-essential -y autoremove \
		apparmor \
		busybox \
		grub\* \
		libsecret-1-dev \
		vim-tiny \
		yelp
	usermod -aG sudo $USER
	"

	curl -f https://zed.dev/install.sh | sh
	rustup default stable
fi

# install dotfiles
git clone --depth=1 --branch=v1.1.0 https://github.com/reujab/silver
cd silver
sed -i 's/git2.*/git2 = { version = "0.18", default-features = false }/' Cargo.toml
cargo install
cd
rm -rf silver
ln -sf "$dotfiles/.gitconfig" "$dotfiles/.zshrc" ~
ln -sfn "$dotfiles/.vim" ~/.config/nvim
git clone --depth=1 https://github.com/ohmyzsh/ohmyzsh .oh-my-zsh || true
sudo cp -r .oh-my-zsh /root
git clone --depth=1 https://github.com/junegunn/vim-plug ~/.config/nvim/plugged/vim-plug || true

# install neovim plugins
nvim +PlugInstall +qa -E
nvim +UpdateRemotePlugins +q

# install patched fonts
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.4.0/CodeNewRoman.zip
unzip CodeNewRoman.zip '*.otf' -d ~/.local/share/fonts/
rm CodeNewRoman.zip
fc-cache -fv

# configure gnome and apps
dconf write /org/gnome/shell/extensions/dash-to-dock/extend-height true
dconf write /org/gtk/settings/file-chooser/show-hidden true
dconf write /org/gnome/shell/extensions/dash-to-dock/dock-fixed false
dconf write /org/gnome/shell/extensions/dash-to-dock/multi-monitor true
dconf write /org/gnome/shell/extensions/dash-to-dock/show-trash true
dconf write /org/gnome/shell/extensions/dash-to-dock/scroll-action "'switch-workspace'"
dconf write /org/gnome/shell/extensions/dash-to-dock/dock-position "'LEFT'"
gsettings set org.gnome.desktop.input-sources xkb-options "['caps:swapescape', 'terminate:ctrl_alt_bksp']"
gsettings set org.gnome.desktop.interface clock-show-date true
gsettings set org.gnome.desktop.interface color-scheme prefer-dark
gsettings set org.gnome.desktop.peripherals.mouse accel-profile flat
gsettings set org.gnome.desktop.interface clock-show-seconds true
gsettings set org.gnome.desktop.interface monospace-font-name "CodeNewRoman Nerd Font Mono 12"
gsettings set org.gnome.desktop.interface gtk-key-theme Emacs
gsettings set org.gnome.desktop.interface gtk-theme Arc
gsettings set org.gnome.desktop.interface icon-theme Numix-Circle
gsettings set org.gnome.desktop.interface show-battery-percentage true
gsettings set org.gnome.desktop.wm.preferences button-layout appmenu:minimize,maximize,close
sudo systemctl enable NetworkManager
sudo systemctl enable gdm

# change the shell to zsh
sudo chsh -s /usr/bin/zsh
sudo chsh -s /usr/bin/zsh "$USER"

echo success
