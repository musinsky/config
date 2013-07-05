# GNOME 3.8.2

gsettings set org.gnome.desktop.background color-shading-type 'vertical'
gsettings set org.gnome.desktop.background picture-options 'none'
gsettings set org.gnome.desktop.background primary-color '#3C78B4'          # (Red: 60 Green: 120 Blue: 180)
gsettings set org.gnome.desktop.background secondary-color '#1E3C5A'        # (Red: 30 Green:  60 Blue:  90)
gsettings set org.gnome.desktop.background show-desktop-icons true

gsettings set org.gnome.desktop.input-sources sources "[('xkb', 'us'), ('xkb', 'ru+phonetic'), ('xkb', 'sk+qwerty')]"

gsettings set org.gnome.desktop.interface buttons-have-icons true
gsettings set org.gnome.desktop.interface clock-show-date true
gsettings set org.gnome.desktop.interface clock-show-seconds true
gsettings set org.gnome.desktop.interface document-font-name 'Sans 9'                # Sans 11
gsettings set org.gnome.desktop.interface font-name 'Cantarell 9'                    # Cantarell 11
gsettings set org.gnome.desktop.interface menus-have-icons true
gsettings set org.gnome.desktop.interface monospace-font-name 'Monospace 9'          # Monospace 11

gsettings set org.gnome.desktop.screensaver lock-enabled false                       # disable lock screen

gsettings set org.gnome.desktop.session idle-delay 3000                              # turn screen off

gsettings set org.gnome.desktop.wm.keybindings close "[]"                            # disable Alt+F4
gsettings set org.gnome.desktop.wm.keybindings panel-main-menu "[]"                  # disable Alt+F1
gsettings set org.gnome.desktop.wm.keybindings panel-run-dialog "['<Alt>R']"         # replace Alt+F2 by Alt+R
gsettings set org.gnome.desktop.wm.keybindings show-desktop "['<Ctrl><Alt>M']"
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-1 "['<Alt>F1']"
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-2 "['<Alt>F2']"
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-3 "['<Alt>F3']"
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-4 "['<Alt>F4']"

gsettings set org.gnome.desktop.wm.preferences num-workspaces 4
gsettings set org.gnome.desktop.wm.preferences titlebar-font 'Cantarell Bold 9'      # Cantarell Bold 11

gsettings set org.gnome.Evince.Default sizing-mode 'fit-page'

gsettings set org.gnome.nautilus.desktop home-icon-visible false
gsettings set org.gnome.nautilus.desktop network-icon-visible false
gsettings set org.gnome.nautilus.desktop trash-icon-visible false

gsettings set org.gnome.nautilus.preferences always-use-location-entry true
gsettings set org.gnome.nautilus.preferences default-folder-viewer 'list-view'
gsettings set org.gnome.nautilus.preferences show-directory-item-counts 'local-only'
gsettings set org.gnome.nautilus.preferences show-image-thumbnails 'local-only'

gsettings set org.gnome.settings-daemon.plugins.power button-power 'shutdown'        # interactive
gsettings set org.gnome.settings-daemon.plugins.power sleep-inactive-ac-timeout 1800
gsettings set org.gnome.settings-daemon.plugins.power sleep-inactive-battery-timeout 600

gsettings set org.gnome.shell always-show-log-out true                               # 'Log Out' in the user menu

gsettings set org.gnome.shell.calendar show-weekdate true

gsettings set org.gnome.shell.overrides button-layout ':minimize,maximize,close'
gsettings set org.gnome.shell.overrides dynamic-workspaces false

gsettings set org.gnome.Terminal.Legacy.Settings menu-accelerator-enabled false      # disable F10 in GNOME terminal

gconftool-2 --type bool --set /apps/nautilus-open-terminal/desktop_opens_home_dir true
gconftool-2 --type bool --set /apps/nautilus-open-terminal/display_mc_item false
