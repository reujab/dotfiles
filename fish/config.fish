set -gx PATH $PATH ~/go/bin
set -x SHELL fish
set -x EDITOR nvim
set -x LESS -R
set -x LESSHISTFILE ~/.cache/.lesshist
set fish_greeting
set BRONZE status:black:white packages:black:white dir:blue:black git:green:black cmdtime:magenta:black
set -x BRONZE_SHELL fish
set -x BRONZE_DIR_ALIASES ~/go/src/github.com/reujab:\ue627
set -x BRONZE_DIR_LENGTH 1
eval (bronze init)
