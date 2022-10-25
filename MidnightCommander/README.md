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
# or as admin (for all users) # be careful, will be replaced after upgrade or reinstall mc
cp -i -p /etc/mc/mc.menu /etc/mc/mc.menu.orig
wget https://raw.githubusercontent.com/musinsky/config/master/MidnightCommander/mc.menu -O /etc/mc/mc.menu
```

### Extension file

Commands in extension file allows you to specify programs to executed when you
try to open (invoked on Enter or double click), view (F3) or edit (F4) and do a
bunch of other thing on files with certain extensions (filename endings). If the
extension of the selected file name matches one of the extensions in the
extensions file then the corresponding command (for open, view or edit) is
executed. Rules are matched from top to bottom, thus the order is important.

`%pkgdatadir%/mc.ext` (on Fedora/CentOS `/etc/mc/mc.ext`) is the default system
wide extension file. `~/.config/mc/mc.ext` user's own extension file. They
override the contents of the system wide files if present.

Customized shell script files in EXTHELPERSDIR (on Fedora/CentOS
`/usr/libexec/mc/ext.d` dir) are compatible with Linux GNU Bash shell systems
(tested on Fedora). All changes are for view action (F3) only. For open action
(Enter) is used `xdg-open` (opens a file in the user's preferred application).
