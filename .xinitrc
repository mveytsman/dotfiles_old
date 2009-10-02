#!/bin/sh
#
# ~/.xinitrc
#
# Executed by startx (run your window manager from here)

# exec gnome-session
# exec startkde
# exec startxfce4
# ...or the Window Manager of your choice

xsetroot -cursor_name left_ptr

trayer --edge top --align right --SetDockType true --SetPartialStrut true \
 --expand true --width 3 --tint 0 --transparent true --height 12 &
 
 
# Fire up apps
 
#pidgin &
 
xscreensaver -no-splash &
 
if [ -x /usr/bin/nm-applet ] ; then
   nm-applet --sm-disable &
fi
 
if [ -x /usr/bin/gnome-power-manager ] ; then
   sleep 3
   gnome-power-manager
fi

xrandr --output LVDS --auto --output VGA-0 --rate 75.0 --left-of LVDS --auto  &

exec  xmonad
