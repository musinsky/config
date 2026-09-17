#!/usr/bin/env bash

# 2026-09-16
# GNOME 50 (Fedora 44)

change_font_size() {
  local path="$1"
  local key="$2"
  local fsize="$3"

  gsettings reset "$path" "$key" || exit 1
  printf "\nRESET %s %s: %s\n" "$path" "$key" "$(gsettings get "$path" "$key")"
  local value # includes apostrophes ('value')
  value=$(gsettings get "$path" "$key" | sed -E "s/ [0-9]+'/ $fsize'/")
  gsettings set "$path" "$key" "$value"
  printf "SET   %s %s: %s\n" "$path" "$key" "$(gsettings get "$path" "$key")"
}

gsettings set org.gnome.desktop.background color-shading-type 'vertical'
gsettings set org.gnome.desktop.background picture-options 'none'
gsettings set org.gnome.desktop.background primary-color '#3c78b4'         # (Red: 60 Green: 120 Blue: 180)
gsettings set org.gnome.desktop.background secondary-color '#1e3c5a'       # (Red: 30 Green:  60 Blue:  90)

gsettings set org.gnome.desktop.calendar show-weekdate true
gsettings set org.gnome.desktop.calendar week-start-day 'monday'

gsettings set org.gnome.desktop.input-sources per-window true
gsettings set org.gnome.desktop.input-sources sources "[('xkb', 'us'), ('xkb', 'ru+phonetic'), ('xkb', 'sk+qwerty')]"
gsettings set org.gnome.desktop.input-sources xkb-options "['caps:none']"  # Caps Lock disabled

gsettings set org.gnome.desktop.interface clock-format '24h'
gsettings set org.gnome.desktop.interface clock-show-seconds true
gsettings set org.gnome.desktop.interface clock-show-weekday true
gsettings set org.gnome.desktop.interface enable-hot-corners false         # mouse on top-left corner
gsettings set org.gnome.desktop.interface gtk-enable-primary-paste true    # GNOME 50+
gsettings set org.gnome.desktop.interface show-battery-percentage true
#change_font_size org.gnome.desktop.interface document-font-name  11       # 'Adwaita Sans 12'
#change_font_size org.gnome.desktop.interface font-name           10       # 'Adwaita Sans 11'
#change_font_size org.gnome.desktop.interface monospace-font-name 10       # 'Adwaita Mono 11'

gsettings set org.gnome.desktop.privacy remember-app-usage false
gsettings set org.gnome.desktop.privacy remember-recent-files false

gsettings set org.gnome.desktop.session idle-delay 3600             # monitor blank (screensaver starts)

gsettings set org.gnome.desktop.screensaver lock-delay 600          # lock screen (after idle-delay + lock-delay)
#gsettings set org.gnome.desktop.screensaver lock-enabled false     # disable lock screen (only on home PC)
gsettings set org.gnome.desktop.screensaver lock-enabled true       # enable lock screen

gsettings set org.gnome.desktop.wm.keybindings close "[]"                            # disable Alt+F4
gsettings set org.gnome.desktop.wm.keybindings panel-run-dialog "['<Alt>R']"         # replace Alt+F2 by Alt+R
gsettings set org.gnome.desktop.wm.keybindings show-desktop "['<Ctrl><Alt>M']"
gsettings set org.gnome.desktop.wm.keybindings switch-applications "[]"              # ['<Super>Tab', '<Alt>Tab']
gsettings set org.gnome.desktop.wm.keybindings switch-windows "['<Alt>Tab']"         # []
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-1 "['<Alt>F1']"
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-2 "['<Alt>F2']"
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-3 "['<Alt>F3']"
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-4 "['<Alt>F4']"

gsettings set org.gnome.desktop.wm.preferences button-layout 'appmenu:minimize,maximize,close'
gsettings set org.gnome.desktop.wm.preferences num-workspaces 4
#change_font_size org.gnome.desktop.wm.preferences titlebar-font 10        # 'Adwaita Sans Bold 11'
# ==============================================================================

gsettings set org.gnome.settings-daemon.plugins.power power-button-action 'nothing'
gsettings set org.gnome.settings-daemon.plugins.power sleep-inactive-ac-timeout 0         # 0 means never
gsettings set org.gnome.settings-daemon.plugins.power sleep-inactive-ac-type 'blank'
gsettings set org.gnome.settings-daemon.plugins.power sleep-inactive-battery-timeout 600
gsettings set org.gnome.settings-daemon.plugins.power sleep-inactive-battery-type 'blank'

#gsettings reset org.gnome.shell command-history
gsettings set org.gnome.shell always-show-log-out true
gsettings set org.gnome.shell.app-switcher current-workspace-only true

gsettings set org.gnome.mutter attach-modal-dialogs false   # modal dialog moved together with parent window
gsettings set org.gnome.mutter dynamic-workspaces false

# GTK3 (some applications that have not yet migrated to GTK4)
gsettings set org.gtk.Settings.FileChooser date-format 'with-time'
gsettings set org.gtk.Settings.FileChooser show-hidden true
gsettings set org.gtk.Settings.FileChooser sort-directories-first true
# GTK4
gsettings set org.gtk.gtk4.Settings.FileChooser date-format 'with-time'
gsettings set org.gtk.gtk4.Settings.FileChooser show-hidden true
gsettings set org.gtk.gtk4.Settings.FileChooser sort-directories-first true

gsettings set org.gnome.nautilus.list-view use-tree-view true
gsettings set org.gnome.nautilus.preferences always-use-location-entry true
gsettings set org.gnome.nautilus.preferences date-time-format 'detailed'
gsettings set org.gnome.nautilus.preferences default-folder-viewer 'list-view'

gsettings set org.gnome.gnome-system-monitor.proctree col-3-visible true   # Virtual Memory
gsettings set org.gnome.gnome-system-monitor.proctree col-3-width 90
gsettings set org.gnome.gnome-system-monitor.proctree col-4-visible true   # Resident Memory
gsettings set org.gnome.gnome-system-monitor.proctree col-4-width 90

gsettings set org.gnome.Evince.Default sizing-mode 'fit-page'
gsettings set org.gnome.Evince page-cache-size 500                         # zoom more than 400%

# GNOME Terminal
gsettings set org.gnome.Terminal.Legacy.Settings menu-accelerator-enabled false   # disable F10
gsettings set org.gnome.Terminal.Legacy.Settings theme-variant 'system'           # 'light'
gsettings set org.gnome.Terminal.Legacy.Keybindings:/org/gnome/terminal/legacy/keybindings/ \
          reset-and-clear '<Control><Shift>R'

## GNOME Terminal Profile
gsettings reset-recursively org.gnome.Terminal.ProfilesList
PROFILE_UUID="$(gsettings get org.gnome.Terminal.ProfilesList default | tr -d \')"
UUID_PATH="org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:${PROFILE_UUID}/"
gsettings reset-recursively "${UUID_PATH}"
gsettings set "${UUID_PATH}" default-size-columns 120    # 80
gsettings set "${UUID_PATH}" default-size-rows 32        # 24
gsettings set "${UUID_PATH}" scrollback-unlimited true   # limit 10000 lines
#gsettings set "${UUID_PATH}" use-system-font true
#gsettings set "${UUID_PATH}" font 'Monospace 12'

### GNOME Terminal Profile Palette
gsettings reset "${UUID_PATH}" palette
COLOR_PALETTE="$(gsettings get "${UUID_PATH}" palette)"
COLOR5="$(echo "${COLOR_PALETTE}" | gawk -F "', '#" '{print $5}')" # find default COLOR5      (ugly blue color)
COLOR_PALETTE="${COLOR_PALETTE//$COLOR5/254b70}" # replace COLOR5 by rgb(37,75,112)=#254b70 (pretty blue color)
gsettings set "${UUID_PATH}" palette "${COLOR_PALETTE}"
