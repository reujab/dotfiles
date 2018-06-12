source /etc/profile.d/vte.sh

# variables
eval "$(go env)"
export EDITOR=nvim
export LESSHISTFILE=$HOME/.cache/.lesshist
export PATH=/bin:/sbin:/usr/local/bin:/usr/local/sbin:$GOPATH/bin:~/.cargo/bin

# zsh
# enables aliases with sudo
alias sudo="sudo "
bindkey "^W" vi-backward-kill-word

# oh my zsh
export ZSH=$HOME/.oh-my-zsh
ZSH_COMPDUMP=$HOME/.cache/.zcompdump
source "$ZSH/oh-my-zsh.sh"

# bronze
BRONZE=(status:black:white packages:black:white)
if [[ $UID != 0 ]]; then
	BRONZE+=(rss:black:white)
fi
BRONZE+=(dir:blue:black git:green:black cmdtime:magenta:black)
export BRONZE_SHELL=zsh
export BRONZE_DIR_LENGTH=1
export BRONZE_DIR_ALIASES=~/go/src/github.com/reujab:$'\ue627'
eval "$(bronze init)"

# zsh syntax highlighting
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# aliases
alias aur="pacaur"
alias c="tput reset"
alias tokei="tokei -e \*.json -e \*.yaml -e \*.yml -e \*.toml"
alias dnfc="sudo dnf clean"
alias dnfcd="sudo dnf copr disable"
alias dnfce="sudo dnf copr enable"
alias dnfcr="sudo dnf copr remove"
alias dnfh="sudo dnf history"
alias dnfi="sudo dnf install"
alias dnfp="dnf provides"
alias dnfr="sudo dnf remove"
alias dnfs="dnf search"
alias dnfu="sudo dnf upgrade"
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
alias gi="git init"
alias gl="g log"
alias gp="g push"
alias gpu="g pull"
alias gr="g reset"
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
alias ll="ls -l"
alias ls="exa -a"
alias prename="perl-rename"
alias rm="gio trash"
alias rmrf="/bin/rm -rf"
alias rsu="aur -Rsu"
alias s="aur -S"
alias ss="aur -Ss"
alias syu="aur -Syu"

# functions
clean() {
	setopt nullglob
	rm "$GOPATH/"{bin,pkg} 2> /dev/null
	rm "$GOPATH/src/"^github.com
	rm "$GOPATH/src/github.com/"^reujab
	go get github.com/{alecthomas/gometalinter,reujab/{bing-background,bronze}} golang.org/x/tools/cmd/go{imports,rename}
	unsetopt nullglob
}

gcl() {
	if [[ $1 =~ '^[a-zA-Z0-9_-]+$' ]]; then
		g clone "http://gogs/reujab/$1" "${@:2}"
	elif [[ $1 =~ '^[a-zA-Z0-9_-]+/[a-zA-Z0-9_-]+$' ]]; then
		g clone "https://github.com/$1" "${@:2}"
	else
		g clone "$@"
	fi
}

run() {
	c
	go build && "./$(basename "$PWD")" "$@"
}
