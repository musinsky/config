# [Window List](https://extensions.gnome.org/extension/602/window-list/)

```plain
# 2024-04-15

ENAME="window-list@gnome-shell-extensions.gcampax.github.com"
EDIR="$HOME/.local/share/gnome-shell/extensions/$ENAME"
cp -p "$EDIR/stylesheet-dark.css" "$EDIR/stylesheet-dark.css.$(date +%F_%T)"
curl https://raw.githubusercontent.com/musinsky/config/master/GNOME/extensions/window-list.stylesheet-dark.css >> "$EDIR/stylesheet-dark.css"
gnome-extensions disable "$ENAME" && gnome-extensions enable "$ENAME"
```
