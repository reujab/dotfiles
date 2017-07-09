source /etc/profile.d/vte.sh

# plugins
eval "$(go env)"
export PATH=/bin:/sbin:/usr/local/bin:/usr/local/sbin:$GOPATH/bin
export ZSH=$HOME/.oh-my-zsh

BRONZE=(black:white:status blue:black:shortdir green:black:git magenta:black:cmdtime)
HYPHEN_INSENSITIVE=true
PLUGINS=()
ZSH_COMPDUMP=$HOME/.cache/.zcompdump

eval "$(bronze init)"

source "$ZSH/oh-my-zsh.sh"
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# general
alias -s go="go run"
alias aur="pacaur"
alias auri="aur -S"
alias aurr="aur -Rsu"
alias aurs="aur -Ss"
alias c="tput reset"
alias cloc="cloc --exclude-dir node_modules,dist --exclude-ext json ."
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
alias g="git"
alias ga="g add"
alias gap="g add -p"
alias gb="g branch"
alias gc="g commit"
alias gca="gc --amend"
alias gco="g checkout"
alias gd="g diff"
alias gi="git init"
alias gl="g log"
alias gp="g push"
alias gpu="g pull"
alias gr="g reset"
alias grep="grep --color=auto -P"
alias gs="g status"
alias gst="g stash"
alias io="sudo iotop"
alias la="ls -A"
alias lint="c && gometalinter --config ~/.gometalinter.json"
alias ll="ls -ldh"
alias ls="ls --color=auto"
alias rm="gio trash"
alias rmrf="/bin/rm -rf"
alias v="nvim"
alias gsm="g submodule"
alias grm="g rm"

autoload -U zmv

bindkey "^W" vi-backward-kill-word

eval "$(dircolors)"

export EDITOR=nvim
export LESSHISTFILE=$HOME/.cache/.lesshist

setopt extended_glob

unset LESS

clean() {
	setopt nullglob
	rm "$GOPATH/"{bin,pkg} 2> /dev/null
	rm "$GOPATH/src/"^github.com
	rm "$GOPATH/src/github.com/"^reujab
	go get github.com/{alecthomas/gometalinter,reujab/bing-background} golang.org/x/tools/cmd/go{imports,rename}
	unsetopt nullglob
}

gcl() {
	if [[ $1 =~ '^[a-zA-Z0-9_-]+/[a-zA-Z0-9_-]+$' ]]; then
		g clone "https://github.com/$1" "${@:2}"
	else
		g clone "$@"
	fi
}

run() {
	c && go build && "./$(basename "$PWD")" "$@"
}
