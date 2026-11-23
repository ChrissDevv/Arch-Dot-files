#!/usr/bin/env bash

uptime_str=$(uptime -p | sed 's/up //')
user=$(whoami)

options="  Lock\n  Suspend\n  Logout\n  Reboot\n  Shutdown"

selected=$(echo -e "$options" | rofi -dmenu \
    -p "$user" \
    -mesg "Uptime: $uptime_str" \
    -theme ~/.config/rofi/powermenu/powermenu.rasi)

case "$selected" in
    *Lock*)
        hyprlock
        ;;
    *Suspend*)
        systemctl suspend
        ;;
    *Logout*)
        if [ -n "$NIRI_SOCKET" ]; then niri msg action quit --skip-confirmation; else hyprctl dispatch exit; fi
        ;;
    *Reboot*)
        systemctl reboot
        ;;
    *Shutdown*)
        systemctl poweroff
        ;;
esac
