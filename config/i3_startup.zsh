#!/bin/zsh

DISPLAYS=(`xrandr | awk '/ connected /{printf "%s ", $1}'`)

if [[ "${#DISPLAYS[@]}" == "2" ]]; then
    EXTERNDISPLAY=$DISPLAYS[-1]
    BUILTINDISPLAY=$DISPLAYS[1]
    xrandr --output $EXTERNDISPLAY --primary --left-of $BUILTINDISPLAY --output $BUILTINDISPLAY
    echo "Configuring $EXTERNDISPLAY and $BUILTINDISPLAY display setup"
else
    xrandr --auto
    echo "Configuring auto"
fi
