source /etc/profile.d/vte*.sh

# variables
if [[ -x /usr/bin/go ]]; then
	eval "$(go env)"
fi
export EDITOR=nvim
export GOPATH
export LESSHISTFILE=$HOME/.cache/.lesshist
export PATH=~/.local/bin:~/.cargo/bin:/usr/local/bin:/bin:/sbin:/usr/lib/jvm/default/bin:/usr/bin/site_perl:/usr/bin/vendor_perl:/usr/bin/core_perl
export RUST_BACKTRACE=1
export XZ_OPT=-T0

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
source <(silver init)

# zsh syntax highlighting
if [[ -f /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]]; then
	source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
elif [[ -f /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]]; then
	source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
fi

# aliases
alias a="sudo apt"
alias ai="a install"
alias ar="a autoremove"
alias as="a search"
alias au="sudo apt update && sudo apt upgrade"
alias c="tput reset"
alias f="fg"
alias g="git"
alias ga="g add"
alias gap="g add -pA"
alias gb="g branch"
alias gc="g commit"
alias gca="gc --amend"
alias vi="$EDITOR"
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
alias gstu="gst -u"
alias ll="ls -lb"
alias ls="eza -abh"
alias rm="rm -i"
alias rsu="yay -Rsu"
alias s="yay -S"
alias ss="yay -Ss"
alias syu="yay -Syu"
alias t="gio trash"
alias toke="tokei -e \*.json -e \*.yaml -e \*.yml -e \*.toml -e target"

if which batcat &> /dev/null; then
	alias bat=batcat
fi

# functions
gcl() {
	if [[ $1 =~ ^[a-zA-Z0-9]+/[a-zA-Z0-9]+ ]]; then
		repo=$1
		shift
		g clone "https://github.com/$repo" "$@"
	else
		g clone "$@"
	fi
}
