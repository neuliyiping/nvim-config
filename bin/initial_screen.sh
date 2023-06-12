#!/usr/bin/bash

# shellcheck disable=SC1090
xrandr \
    --output "$MAIN_SCREEN" \
    --off \
    --output "$LAPTOP_SCREEN" \
    --primary \
    --mode 1920x1080 \
    --rate 60
