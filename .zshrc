# startup
start=$SECONDS

source /etc/profile.d/vte.sh

# plugins
export ZSH=$HOME/.oh-my-zsh

DEFAULT_USER=$USER
HYPHEN_INSENSITIVE=true
PLUGINS=()
ZSH_COMPDUMP=$HOME/.cache/.zcompdump
ZSH_THEME=agnoster

source "$ZSH/oh-my-zsh.sh"
source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# general
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

autoload -U zmv

bindkey "^W" vi-backward-kill-word

eval "$(dircolors)"

export EDITOR=nvim
export GOPATH=$HOME/go
export LESSHISTFILE=$HOME/.cache/.lesshist
export PATH=/bin:/sbin:/usr/local/bin:/usr/local/sbin:$GOPATH/bin

setopt extended_glob

build_prompt() {
  RETVAL=$?

  prompt_status
  prompt_context
  prompt_dir
  prompt_git
  prompt_time
  prompt_end
}

clean() {
  setopt nullglob
  rm "$GOPATH/"{bin,pkg} 2> /dev/null
  rm "$GOPATH/src/"^github.com
  rm "$GOPATH/src/github.com/"^reujab
  go get github.com/{alecthomas/gometalinter,reujab/bing-background} golang.org/x/tools/cmd/go{imports,rename}
  unsetopt nullglob
}

preexec() {
  start=$SECONDS
}

prompt_time() {
  prompt_segment 13 black $((SECONDS - start))s
}

run() {
  c && go build && "./$(basename "$PWD")" "$@"
}
