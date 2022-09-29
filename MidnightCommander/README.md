## Midnight Commander

GNU [Midnight Commander](https://midnight-commander.org/) (aka **mc**) is a
directory browser/file manager for Unix-like operating systems.

### User menu

The user menu (invoke by press F2) is a menu of useful actions that can be
customized by the user. When you access the user menu, the file `.mc.menu` from
the current directory is used if it exists, but only if it is owned by user or
root and is not world-writable. If no such file found, `~/.config/mc/menu` is
tried in the same way, and otherwise mc uses the default system-wide menu
`%pkgdatadir%/mc.menu` (on Fedora/CentOS `/etc/mc/mc.menu`).

Customized user menu file is compatible with Linux GNU Bash shell systems
(tested on Fedora).

```
# as user (recommended)
wget -nc https://raw.githubusercontent.com/musinsky/config/master/MidnightCommander/mc.menu -O $HOME/.config/mc/menu
```
```
# or as admin (for all users)
cp -i -p /etc/mc/mc.menu /etc/mc/mc.menu.orig
wget https://raw.githubusercontent.com/musinsky/config/master/MidnightCommander/mc.menu -O /etc/mc/mc.menu
```
