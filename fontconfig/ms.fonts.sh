#!/usr/bin/env bash

# 2024-01-30
#
# https://learn.microsoft.com/en-us/typography/fonts/windows_10_font_list
# https://learn.microsoft.com/en-us/typography/fonts/windows_11_font_list

WIN_DIR="/mnt/win_c/Windows/Fonts"
LINUX_DIR="/usr/local/share/fonts"     # admin (prefer dir)
LINUX_DIR="/usr/share/fonts"           # admin
LINUX_DIR="$HOME/.local/share/fonts"   # user

# https://learn.microsoft.com/en-us/typography/font-list/calibri
# https://en.wikipedia.org/wiki/Calibri

FONT_DIR="$LINUX_DIR/ms-calibri"
mkdir -p "$FONT_DIR"
cp -p "$WIN_DIR/calibri.ttf"   "$FONT_DIR/Calibri-Regular.ttf"
cp -p "$WIN_DIR/calibrib.ttf"  "$FONT_DIR/Calibri-Bold.ttf"
cp -p "$WIN_DIR/calibrii.ttf"  "$FONT_DIR/Calibri-Italic.ttf"
cp -p "$WIN_DIR/calibriz.ttf"  "$FONT_DIR/Calibri-BoldItalic.ttf"
cp -p "$WIN_DIR/calibril.ttf"  "$FONT_DIR/Calibri-Light.ttf"
cp -p "$WIN_DIR/calibrili.ttf" "$FONT_DIR/Calibri-LightItalic.ttf"
find "$FONT_DIR" -type f -name 'Calibri*' -exec chmod 644 {} \;
ls -lR "$FONT_DIR"

# https://learn.microsoft.com/en-us/typography/font-list/comic-sans-ms
# https://en.wikipedia.org/wiki/Comic_Sans

FONT_DIR="$LINUX_DIR/ms-comic-sans"
mkdir -p "$FONT_DIR"
cp -p "$WIN_DIR/comic.ttf"   "$FONT_DIR/ComicSans-Regular.ttf"
cp -p "$WIN_DIR/comicbd.ttf" "$FONT_DIR/ComicSans-Bold.ttf"
cp -p "$WIN_DIR/comici.ttf"  "$FONT_DIR/ComicSans-Italic.ttf"
cp -p "$WIN_DIR/comicz.ttf"  "$FONT_DIR/ComicSans-BoldItalic.ttf"
find "$FONT_DIR" -type f -name 'ComicSans*' -exec chmod 644 {} \;
ls -lR "$FONT_DIR"

fc-cache && echo "fc-cache done"
