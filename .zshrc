source /etc/profile.d/vte.sh

# change to last working directory
if [[ $PWD = $HOME ]]; then
	cd "$(cat /tmp/.zshwd 2> /dev/null)" 2> /dev/null
fi

# variables
eval "$(go env)"
export EDITOR=nvim
export LESSHISTFILE=$HOME/.cache/.lesshist
export PATH=~/.local/share/bin:/bin:/sbin:/usr/local/bin:/usr/local/sbin:$GOPATH/bin:~/.cargo/bin:/usr/lib/jvm/default/bin:/usr/bin/site_perl:/usr/bin/vendor_perl:/usr/bin/core_perl
export RUST_BACKTRACE=1

# zsh
# enables aliases with sudo
alias sudo="sudo "
bindkey "^W" vi-backward-kill-word

# oh my zsh
export ZSH=$HOME/.oh-my-zsh
ZSH_COMPDUMP=$HOME/.cache/.zcompdump
source "$ZSH/oh-my-zsh.sh"

# silver
SILVER=(status:black:white dir:blue:black git:green:black cmdtime:cyan:black)
export SILVER_SHELL=zsh
export SILVER_DIR_LENGTH=1
export SILVER_DIR_ALIASES=~/go/src/github.com/reujab:$'\ue627'
eval "$(silver init)"

# zsh syntax highlighting
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# aliases
alias c="tput reset"
alias e="$EDITOR"
alias f="fg"
alias g="git"
alias ga="g add"
alias gap="g add -p"
alias gb="g branch"
alias gc="g commit"
alias gca="gc --amend"
alias gco="g checkout"
alias gd="g diff"
alias gds="gd --staged"
alias gf="g fetch"
alias gi="git init"
alias gl="g log"
alias gm="g merge"
alias gp="g push"
alias gpu="g pull"
alias gr="g reset"
alias grb="g rebase"
alias gre="g remote"
alias grep="grep --color=auto -P"
alias grm="g rm"
alias gs="g status"
alias gsm="g submodule"
alias gst="g stash"
alias gsta="gst add"
alias gstd="gst drop"
alias gstl="gst list"
alias gstp="gst pop"
alias io="sudo iotop"
alias lint="c; gometalinter --config ~/.gometalinter.json"
alias ll="ls -lb"
alias ls="exa -a"
alias prename="perl-rename"
alias rm="gio trash"
alias rsu="yay -Rsu"
alias s="yay -S"
alias ss="yay -Ss"
alias syu="yay -Syu"
alias toke="tokei -e \*.json -e \*.yaml -e \*.yml -e \*.toml -e target"

# functions

# saves last directory
chpwd() {
	pwd > /tmp/alacritty-wd
}

clean() {
	setopt nullglob
	rm "$GOPATH/"{bin,pkg} 2> /dev/null
	rm "$GOPATH/src/"^github.com
	rm "$GOPATH/src/github.com/"^reujab
	go get github.com/{alecthomas/gometalinter,reujab/{bing-background,bronze}} golang.org/x/tools/cmd/go{imports,rename}
	unsetopt nullglob
}

gcl() {
	if [[ $1 =~ '^[a-zA-Z0-9_-]+/[a-zA-Z0-9_-]+$' ]]; then
		g clone "https://github.com/$1"
	else
		g clone "$@"
	fi
}

unswap() {
	sudo swapoff /dev/sda3 &&
		sudo swapon /dev/sda3
}

run() {
	c
	go build && "./$(basename "$PWD")" "$@"
}
