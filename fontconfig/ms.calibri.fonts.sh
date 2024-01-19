#!/usr/bin/env bash

# 2024-01-19
# https://en.wikipedia.org/wiki/Calibri
# https://learn.microsoft.com/en-us/typography/font-list/calibri
#
# https://learn.microsoft.com/en-us/typography/fonts/windows_10_font_list
# https://learn.microsoft.com/en-us/typography/fonts/windows_11_font_list

WIN_DIR="/mnt/win_c/Windows/Fonts"
LINUX_DIR="/usr/local/share/fonts/ms-calibri"
LINUX_DIR="."

cp -p "$WIN_DIR/calibri.ttf"   "$LINUX_DIR/Calibri-Regular.ttf"
cp -p "$WIN_DIR/calibrib.ttf"  "$LINUX_DIR/Calibri-Bold.ttf"
cp -p "$WIN_DIR/calibrii.ttf"  "$LINUX_DIR/Calibri-Italic.ttf"
cp -p "$WIN_DIR/calibriz.ttf"  "$LINUX_DIR/Calibri-BoldItalic.ttf"
cp -p "$WIN_DIR/calibril.ttf"  "$LINUX_DIR/Calibri-Light.ttf"
cp -p "$WIN_DIR/calibrili.ttf" "$LINUX_DIR/Calibri-LightItalic.ttf"

chmod 644 Calibri*.ttf
#chown root:root Calibri*.ttf
