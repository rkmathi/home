#!/usr/bin/env bash

# ibus-mozc
export XMODIFIERS="@im=ibus"
export XMODIFIER="@im=ibus"
export GTK_IM_MODULE=ibus
export QT_IM_MODULE=ibus
export DefaultIMModule=ibus
ibus-daemon -d -x

# xmodmap
xmodmap .Xmodmap

# dbus-launch
dbus-launch

# xfce4-volumed
xfce4-volumed

# Exec WindowManager
exec xmonad
