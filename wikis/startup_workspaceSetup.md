# Automating workspace setup

# Helpfull references:
A good start - someone's [blurb](https://askubuntu.com/a/235131) on wmctrl:

http://www.linuxjournal.com/magazine/hack-and-automate-your-desktop-wmctrl

wmctrl -o 1281,0

wmctrl has commands both for shifting to different desktops and also to different viewports. Because Compiz often uses multiple viewports instead of desktops, the above command moves me to the second viewport (my desktops are 1280x768, so 1281,0 corresponds to the top corner of my second viewport).

## Useful commands:

```
wmctrl -l # lists all of the windows managed by wmctrl
wmctrl -r <mywindow> -I <tag> # selects a window and names it with a tag
wmctrl -r <tag> -o X,Y # selects a window tagged as <tag> and moves it to position X,Y
wmctrl -d # This will list properties of the desktop, such as "0  * DG: 5760x3240  VP: 3840,0  WA: 0,24 1920x1056  N/A" where DG gives desktop geometry (all 9 workspaces) and VP gives viewport position, or the top left corner coord of current viewport (where terminal is open).
```

NOTE:
- when -o X,Y is specified, X,Y are relative to the vieport that you are in
- when -e g,x,y,w,h

## A little experimentation
Let's try something (assume you are in the center viewport):

```
w=1920 # Make vars for desktop locations:
h=1056
x2=$w
x3=`echo "$w*2" | bc`
y2=$h
y3=`echo "$w*2" | bc`
wmctrl -r "Shotwell" -N "photo_window"
wmctrl -r photo_window -e 0,$x3,$y3,-1,-1
google-chrome https://dxsplunk.myriad.com
```

- Apparently s```--working-directory``` below is relative to your home directory
  - ```gnome-terminal --working-directory=sandbox/python```

```gnome-terminal --window-with-profile=automate -e "bash -c 'cd ~/sandbox; $SHELL'"```


Check the wireless network:

```iwconfig 2>@1 | grep ESSID```
