<p align="right">last edit: 2024-02-14</p>

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
wget https://raw.githubusercontent.com/musinsky/config/master/MidnightCommander/mc.menu -O "$HOME"/.config/mc/menu
```
```
# or as admin (for all users) # be careful, will be replaced after upgrade or reinstall mc
cp -i -p /etc/mc/mc.menu /etc/mc/mc.menu.orig
wget https://raw.githubusercontent.com/musinsky/config/master/MidnightCommander/mc.menu -O /etc/mc/mc.menu
```

### Extension file
Commands in extension file allows you to specify programs to executed when you
try to open (invoked on Enter or double click), view (F3) or edit (F4) and do a
bunch of other thing on files with certain extensions (file name endings). If
the extension of the selected file name matches one of the extensions in the
extensions file then the corresponding command (for open, view or edit) is
executed. Rules are matched from top to bottom, thus the order is important.

**NOTE** from Midnight Commander version 4.8.29 (2023-01) and newer changes in
the extension file.
* version <= 4.8.28: **3.0** extension file format, `mc.ext` file
* version >= 4.8.29: **4.0** extension file format, `mc.ext.ini` file

`%pkgdatadir%/mc.ext.ini` (on Fedora/CentOS `/etc/mc/mc.ext.ini`) is the default
system wide extension file. `~/.config/mc/mc.ext.ini` user's own extension file.
They override the contents of the system wide files if present.

Customized shell script files in EXTHELPERSDIR (on Fedora/CentOS
`/usr/libexec/mc/ext.d` dir) are compatible with Linux GNU Bash shell systems
(tested on Fedora). All changes are for view action (F3) only. For open action
(Enter) is used `xdg-open` (opens a file in the user's preferred application) by
default.

```
# v4.8.29+
MC_EXT_FILE="mc.ext.ini"
MC_EXT_FORM="mc.4.0.ext.add"
# v4.8.28-
[ -f /etc/mc/mc.ext ] && { MC_EXT_FILE="mc.ext"; MC_EXT_FORM="mc.3.0.ext.add"; }
echo "'$MC_EXT_FILE' and '$MC_EXT_FORM'"

mkdir -p "$HOME"/.config/mc
GH_MC="https://raw.githubusercontent.com/musinsky/config/master/MidnightCommander"
# copy default extension file and add (prepend) a few extra extensions (order is important)
wget "$GH_MC/$MC_EXT_FORM" -O - | cat - /etc/mc/"$MC_EXT_FILE" > "$HOME"/.config/mc/"$MC_EXT_FILE"
# copy customized shell scripts
SYSTEM_DIR="/usr/libexec/mc/ext.d"
CUSTOM_DIR="$HOME/.config/mc/ext.d" # or wherever you want (for example CUSTOM_DIR="$SYSTEM_DIR")
wget -N "$GH_MC"/ext.d/doc.custom.sh   -P "$CUSTOM_DIR"
wget -N "$GH_MC"/ext.d/image.custom.sh -P "$CUSTOM_DIR"
wget -N "$GH_MC"/ext.d/misc.custom.sh  -P "$CUSTOM_DIR"
wget -N "$GH_MC"/ext.d/sound.custom.sh -P "$CUSTOM_DIR"
wget -N "$GH_MC"/ext.d/video.custom.sh -P "$CUSTOM_DIR"
chmod 755 "$CUSTOM_DIR"/*.custom.sh
# in extension file replace default shell scripts by customized shell scripts
sed -i "s|$SYSTEM_DIR/doc.sh|$CUSTOM_DIR/doc.custom.sh|g"     "$HOME"/.config/mc/"$MC_EXT_FILE"
sed -i "s|$SYSTEM_DIR/image.sh|$CUSTOM_DIR/image.custom.sh|g" "$HOME"/.config/mc/"$MC_EXT_FILE"
sed -i "s|$SYSTEM_DIR/misc.sh|$CUSTOM_DIR/misc.custom.sh|g"   "$HOME"/.config/mc/"$MC_EXT_FILE"
sed -i "s|$SYSTEM_DIR/sound.sh|$CUSTOM_DIR/sound.custom.sh|g" "$HOME"/.config/mc/"$MC_EXT_FILE"
sed -i "s|$SYSTEM_DIR/video.sh|$CUSTOM_DIR/video.custom.sh|g" "$HOME"/.config/mc/"$MC_EXT_FILE"
# nroff (aka simple color) "force" format mode in view mode
sed -i "/.custom.sh/s/{ascii}/{ascii,nroff}/" "$HOME"/.config/mc/"$MC_EXT_FILE"
```

### Skin
Customized 256colors skin derived from the default skin. Midnight Commander
support color aliases in skin files and True Color (16 millions colors) from
version 4.8.19 (2017-03).
```
# as user
mkdir -p "$HOME"/.local/share/mc/skins
wget https://raw.githubusercontent.com/musinsky/config/master/MidnightCommander/skins/default-gray256.ini -O "$HOME"/.local/share/mc/skins/default-gray256.ini
```
```
# or as admin (for all users)
wget https://raw.githubusercontent.com/musinsky/config/master/MidnightCommander/skins/default-gray256.ini -O /usr/share/mc/skins/default-gray256.ini
```
For version <= 4.8.19 (without color aliases in skin files) manual "aliases" is
required (i.a. CentOS 7).
```
sed -i 's/lightgray/color250/g'  "$HOME"/.local/share/mc/skins/default-gray256.ini
sed -i 's/blue/color238/g'       "$HOME"/.local/share/mc/skins/default-gray256.ini
sed -i 's/cyan/color244/g'       "$HOME"/.local/share/mc/skins/default-gray256.ini
sed -i 's/gray/color254/g'       "$HOME"/.local/share/mc/skins/default-gray256.ini
sed -i 's/brightblue/color244/g' "$HOME"/.local/share/mc/skins/default-gray256.ini
```

### Options
```
# exit from mc
sed -i '/skin=/c\skin=default-gray256'                             "$HOME"/.config/mc/ini

sed -i '/timeformat_recent=/c\timeformat_recent=%Y-%m-%d %H:%M:%S' "$HOME"/.config/mc/ini
sed -i '/timeformat_old=/c\timeformat_old=%Y-%m-%d %H:%M   '       "$HOME"/.config/mc/ini # 3 spaces after minute
```
