set -gx PATH $PATH ~/go/bin
set -x SHELL fish
set -x EDITOR nvim
set -x LESSHISTFILE ~/.cache/.lesshist
set fish_greeting
set BRONZE status:black:white pacaur:black:white dir:blue:black git:green:black cmdtime:magenta:black
set -x BRONZE_DIR_LENGTH 1
eval (bronze init)
