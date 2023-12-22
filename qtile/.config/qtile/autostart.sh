#!/usr/bin/env bash

xrdb -merge ~/.Xresources
xmodmap ~/.Xmodmap
lxsession &
nm-applet &
udiskie &
xfce4-power-manager &
pa-applet &
flameshot &
blueberry-tray &
dunst &
xwallpaper --stretch ~/Images/wallpapers/001.jpg &
