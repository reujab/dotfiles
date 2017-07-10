set -gx PATH $PATH ~/go/bin
set -x SHELL fish
set -x EDITOR nvim
set -x LESSHISTFILE ~/.cache/.lesshist
set fish_greeting
set BRONZE black:white:status blue:black:shortdir green:black:git magenta:black:cmdtime
eval (bronze init)
