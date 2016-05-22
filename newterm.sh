#! /bin/zsh

dir=${$(xprop -id $(xdotool getactivewindow) WM_ICON_NAME | sed 's/WM_ICON_NAME(STRING) = \".*: //; s,\~.\?,'"$HOME"'/,')%\"}
urxvt -cd $dir
