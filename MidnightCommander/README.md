## Midnight Commander

### Menu File

The Midnight Commander (mc) user menu is a menu of useful actions that can be
customized by the user. When you access the user menu, the file `.mc.menu` from
the current directory is used if it exists, but only if it is owned by user or
root and is not world-writable. If no such file found, `~/.config/mc/menu` is
tried in the same way, and otherwise mc uses the default system-wide menu
`%pkgdatadir%/mc.menu` (on Fedora/CentOS `/etc/mc/mc.menu`).

```
# user
wget -nc https://raw.githubusercontent.com/musinsky/config/master/MidnightCommander/mc.menu -O $HOME/.config/mc/menu
```
```
# admin (for all users)
cp -p /etc/mc/mc.menu /etc/mc/mc.menu.orig
wget https://raw.githubusercontent.com/musinsky/config/master/MidnightCommander/mc.menu -O /etc/mc/mc.menu
```
