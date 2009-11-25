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

xrandr --newmode "1440x900_75.00"  136.75  1440 1536 1688 1936  900 903 909 942 -hsync +vsync
xrandr --addmode VGA-0 "1440x900_75.00"
xrandr --output VGA-0 --mode 1440x900_75.00 --output LVDS --mode 1280x800 --left-of VGA-0   & 

xmodmap -e 'remove Lock = Caps_Lock'
xmodmap -e 'keysym Caps_Lock = Control_L'
xmodmap -e 'add Control = Control_L'
exec  xmonad
