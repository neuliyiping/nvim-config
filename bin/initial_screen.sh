#!/usr/bin/bash

# shellcheck disable=SC1090
source "$HOME/.zshenv"

xrandr \
    --output "$MAIN_SCREEN" \
    --primary \
    --mode 2560x1440 \
    --rate 120.0 \
    --rotate normal \
    --output "$SECONDARY_SCREEN" \
    --mode 2560x1440 \
    --pos 2560x0 \
    --rotate right \
    --rate 120.0
