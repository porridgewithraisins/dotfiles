test -f ~/.bashrc && source ~/.bashrc
test -z "$DISPLAY" && test "$XDG_VTNR" = "1" && exec startx >> ~/.local/share/xorg/startx.log 2>&1
