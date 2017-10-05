# GNOME 3.26

gsettings set org.gnome.desktop.background color-shading-type 'vertical'
gsettings set org.gnome.desktop.background picture-options 'none'
gsettings set org.gnome.desktop.background primary-color '#3C78B4'                   # (Red: 60 Green: 120 Blue: 180)
gsettings set org.gnome.desktop.background secondary-color '#1E3C5A'                 # (Red: 30 Green:  60 Blue:  90)

gsettings set org.gnome.desktop.calendar show-weekdate true

gsettings set org.gnome.desktop.input-sources per-window true
gsettings set org.gnome.desktop.input-sources sources "[('xkb', 'us'), ('xkb', 'ru+phonetic'), ('xkb', 'sk+qwerty')]"

gsettings set org.gnome.desktop.interface clock-show-date true
gsettings set org.gnome.desktop.interface clock-show-seconds true
gsettings set org.gnome.desktop.interface document-font-name 'Sans 9'                # Sans 11
gsettings set org.gnome.desktop.interface font-name 'Cantarell 9'                    # Cantarell 11
gsettings set org.gnome.desktop.interface monospace-font-name 'Monospace 9'          # Monospace 11
gsettings set org.gnome.desktop.interface show-battery-percentage true

gsettings set org.gnome.desktop.privacy remember-app-usage false
gsettings set org.gnome.desktop.privacy remember-recent-files false

gsettings set org.gnome.desktop.screensaver color-shading-type 'vertical'
gsettings set org.gnome.desktop.screensaver lock-enabled false                       # disable lock screen
gsettings set org.gnome.desktop.screensaver picture-options 'none'
gsettings set org.gnome.desktop.screensaver primary-color '#1E3C5A'
gsettings set org.gnome.desktop.screensaver secondary-color '#3C78B4'

gsettings set org.gnome.desktop.session idle-delay 1800                              # turn screen off

gsettings set org.gnome.desktop.wm.keybindings close "[]"                            # disable Alt+F4
gsettings set org.gnome.desktop.wm.keybindings panel-main-menu "[]"                  # disable Alt+F1
gsettings set org.gnome.desktop.wm.keybindings panel-run-dialog "['<Alt>R']"         # replace Alt+F2 by Alt+R
gsettings set org.gnome.desktop.wm.keybindings show-desktop "['<Ctrl><Alt>M']"
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-1 "['<Alt>F1']"
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-2 "['<Alt>F2']"
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-3 "['<Alt>F3']"
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-4 "['<Alt>F4']"

gsettings set org.gnome.desktop.wm.preferences button-layout 'appmenu:minimize,maximize,close'
gsettings set org.gnome.desktop.wm.preferences num-workspaces 4
gsettings set org.gnome.desktop.wm.preferences titlebar-font 'Cantarell Bold 9'      # Cantarell Bold 11

gsettings set org.gnome.Evince.Default sizing-mode 'fit-page'

gsettings set org.gnome.gnome-system-monitor.proctree col-3-visible true             # Virtual Memory
gsettings set org.gnome.gnome-system-monitor.proctree col-3-width 70
gsettings set org.gnome.gnome-system-monitor.proctree col-4-visible true             # Resident Memory
gsettings set org.gnome.gnome-system-monitor.proctree col-4-width 70

gsettings set org.gnome.nautilus.preferences always-use-location-entry true
gsettings set org.gnome.nautilus.preferences default-folder-viewer 'list-view'

gsettings set org.gnome.settings-daemon.plugins.color night-light-enabled true

gsettings set org.gnome.settings-daemon.plugins.power power-button-action 'nothing'
gsettings set org.gnome.settings-daemon.plugins.power sleep-inactive-ac-timeout 3000
gsettings set org.gnome.settings-daemon.plugins.power sleep-inactive-ac-type 'blank'
gsettings set org.gnome.settings-daemon.plugins.power sleep-inactive-battery-timeout 600
gsettings set org.gnome.settings-daemon.plugins.power sleep-inactive-battery-type 'blank'

gsettings set org.gnome.shell.app-switcher current-workspace-only true

### this keys overrides the keys in org.gnome.mutter when running GNOME Shell
# gsettings get org.gnome.mutter attach-modal-dialogs
# gsettings get org.gnome.mutter dynamic-workspaces
gsettings set org.gnome.shell.overrides attach-modal-dialogs false                   # Attach modal dialog to the parent window
gsettings set org.gnome.shell.overrides dynamic-workspaces false

gsettings set org.gnome.Terminal.Legacy.Settings theme-variant 'system'
gsettings set org.gnome.Terminal.Legacy.Settings menu-accelerator-enabled false      # disable F10 in GNOME terminal

