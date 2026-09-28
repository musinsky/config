#!/usr/bin/env bash

# 2026-09-29
# GNOME 50 (Fedora 44)

print_status() {
  printf "# after 'idle-delay' seconds (0 means never) monitor blanks, i.e. screensaver activates\n"
  printf "org.gnome.desktop.session idle-delay: %d\n\n" \
         "$(gsettings get org.gnome.desktop.session idle-delay | cut -d' ' -f2)"

  printf "# only if screensaver was activated, i.e after 'idle-delay' seconds +\n"
  printf "# after 'lock-delay' seconds (0 means immediately) screen locks (if 'lock-enabled')\n"
  printf "org.gnome.desktop.screensaver lock-delay: %d\n" \
         "$(gsettings get org.gnome.desktop.screensaver lock-delay | cut -d' ' -f2)"
  printf "org.gnome.desktop.screensaver lock-enabled: %s\n\n" \
         "$(gsettings get org.gnome.desktop.screensaver lock-enabled)"

  printf "# power timeouts are independent of 'idle-delay' value and 0 seconds means never\n"
  printf "org.gnome.settings-daemon.plugins.power power-button-action: %s\n" \
         "$(gsettings get org.gnome.settings-daemon.plugins.power power-button-action)"
  printf "org.gnome.settings-daemon.plugins.power sleep-inactive-ac-timeout: %d\n" \
         "$(gsettings get org.gnome.settings-daemon.plugins.power sleep-inactive-ac-timeout | cut -d' ' -f2)"
  printf "org.gnome.settings-daemon.plugins.power sleep-inactive-ac-type: %s\n" \
         "$(gsettings get org.gnome.settings-daemon.plugins.power sleep-inactive-ac-type)"
  printf "org.gnome.settings-daemon.plugins.power sleep-inactive-battery-timeout: %d\n" \
         "$(gsettings get org.gnome.settings-daemon.plugins.power sleep-inactive-battery-timeout | cut -d' ' -f2)"
  printf "org.gnome.settings-daemon.plugins.power sleep-inactive-battery-type: %s\n\n" \
         "$(gsettings get org.gnome.settings-daemon.plugins.power sleep-inactive-battery-type)"
}

set_power() {
  local id=$1
  gsettings set org.gnome.desktop.session idle-delay "${IDLE_DELAY[$id]}"
  gsettings set org.gnome.desktop.screensaver lock-delay "${LOCK_DELAY[$id]}"
  gsettings set org.gnome.desktop.screensaver lock-enabled "${LOCK_ENABLED[$id]}"
  gsettings set org.gnome.settings-daemon.plugins.power power-button-action "${BUTTON_ACTION[$id]}"
  gsettings set org.gnome.settings-daemon.plugins.power sleep-inactive-ac-timeout "${AC_TIMEOUT[$id]}"
  gsettings set org.gnome.settings-daemon.plugins.power sleep-inactive-ac-type "${AC_TYPE[$id]}"
  gsettings set org.gnome.settings-daemon.plugins.power sleep-inactive-battery-timeout "${BATTERY_TIMEOUT[$id]}"
  gsettings set org.gnome.settings-daemon.plugins.power sleep-inactive-battery-type "${BATTERY_TYPE[$id]}"
}

# profile[id]     #[0]LAPTOP     #[1]SERVER     #[2]HOMEPC     # default
IDLE_DELAY=(      $((30 * 60))   $((30 * 60))   $((30 * 60)) ) # 300
LOCK_DELAY=(      $((10 * 60))   $((10 * 60))   0            ) # 0
LOCK_ENABLED=(    "true"         "true"         "false"      ) # true
BUTTON_ACTION=(   "nothing"      "nothing"      "nothing"    ) # 'suspend' (no enum 'shutdown')
AC_TIMEOUT=(      $((90 * 60))   $((90 * 60))   $((90 * 60)) ) # 900
AC_TYPE=(         "suspend"      "blank"        "suspend"    ) # 'suspend'
BATTERY_TIMEOUT=( $((10 * 60))   0              0            ) # 900
BATTERY_TYPE=(    "suspend"      "nothing"      "nothing"    ) # 'suspend'

gsettings reset-recursively org.gnome.desktop.session
gsettings reset-recursively org.gnome.desktop.screensaver
gsettings reset-recursively org.gnome.settings-daemon.plugins.power
#printf "=== Profile: default ===\n"
#print_status

compgen -G '/sys/class/power_supply/BAT*' > /dev/null && {
  set_power 0
  printf "=== Profile: laptop ===\n"
  print_status
  exit
}

hostname | grep 'muke' > /dev/null && {
  set_power 1
  printf "=== Profile: server ===\n"
  print_status
  exit
}

set_power 2
printf "=== Profile: homePC ===\n"
print_status
