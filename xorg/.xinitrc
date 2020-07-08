# needed to make java gui (primarily JetBrains IDEs) work
# requires compiz package from AUR
wmname compiz
export AWT_TOOLKIT=MToolkit;
[ -f ~/.xprofile ] && . ~/.xprofile
# if you're not running a display manager (LightDM, SDDM etc), 
# you should add 'exec <your window manager executable name>'
# Example:
# exec dwm
# exec awesomewm
# exec dbus-launch --exit-with-session dwm
