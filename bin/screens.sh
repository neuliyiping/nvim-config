#!/usr/bin/bash

# shellcheck disable=SC1090
source "$HOME/.zshenv"

launch-rofi() {
    rofi \
        -dmenu \
        -p "Select a screen layout" \
        -sep "|" \
        -theme powermenu
}

dual-rotated() {
    source "$DOTFILES/bin/initial_screen.sh"
}

dual-office() {
    xrandr \
        --output "$MAIN_SCREEN" \
        --primary \
        --mode 1920x1200 \
        --rate 60 \
        --rotate normal \
        --output "$LAPTOP_SCREEN" \
        --mode 1920x1080 \
        --rotate normal \
        --left-of "$MAIN_SCREEN" \
        --rate 60
}

dual-home() {
    xrandr \
        --output "$MAIN_SCREEN" \
        --primary \
        --mode 2560x1440 \
        --rate 120.0 \
        --rotate normal \
        --output "$LAPTOP_SCREEN" \
        --mode 1920x1080 \
        --rotate normal \
        --right-of "$MAIN_SCREEN" \
        --rate 60
}

main-office() {
    xrandr \
        --output "$MAIN_SCREEN" \
        --primary \
        --mode 1920x1200 \
        --rate 60 \
        --rotate normal
    xrandr \
        --output "$LAPTOP_SCREEN" \
        --off
}

main-home() {
    xrandr \
        --output "$MAIN_SCREEN" \
        --primary \
        --mode 2560x1440 \
        --rate 60 \
        --rotate normal \
        --output "$LAPTOP_SCREEN" \
        --off
}

laptop-screen() {
    xrandr \
        --output "$LAPTOP_SCREEN" \
        --primary \
        --mode 1920x1080 \
        --rate 60 \
        --rotate normal \
        --output "$MAIN_SCREEN" \
        --off
}

screens() {
    mode=$(echo "dualo|dualh|office|home|laptop" | launch-rofi)

    case "$mode" in
    "dualo")
        dual-office
        ;;
    "dualh")
        dual-home
        ;;
    "office")
        main-offie
        ;;
    "home")
        main-home
        ;;
    "laptop")
        laptop-screen
        ;;
    *)
        notify-send -a "Screens" "Atenció!" "Algo ha passat i no he pogut posar les pantalles com vols :("
        exit 1
        ;;
    esac

    i3-msg restart
}

screens "$@"
