# disable fish greeting
set fish_greeting

set -gx PATH $PATH ~/go/bin

set -x EDITOR nvim

# less
set -x LESS -R
set -x LESSHISTFILE ~/.cache/.lesshist

# bronze
set BRONZE status:black:white packages:black:white rss:black:white dir:blue:black git:green:black cmdtime:magenta:black
set -x BRONZE_SHELL fish
set -x BRONZE_DIR_ALIASES ~/go/src/github.com/reujab:\ue627
set -x BRONZE_DIR_LENGTH 1
eval (bronze init)
