#!/usr/bin/env bash

lxsession &
picom &
sleep 2 && nm-applet &
sleep 2 && udiskie &
xfce4-power-manager &
sleep 2 && volumeicon &
flameshot &
sleep 2 && blueberry-tray &
xwallpaper --stretch ~/Images/wallpapers/001.jpg &
