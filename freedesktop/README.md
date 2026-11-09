<!-- markdownlint-disable MD033 MD041-->
<p align="right">last edit: 2026-11-09</p>
<!-- markdownlint-enable  MD033 MD041-->

## freedesktop

```plain
sudo curl https://raw.githubusercontent.com/musinsky/config/master/freedesktop/20-no-bitmap-all-fonts.conf \
     --output-dir /etc/fonts/conf.d/ --remote-name
```

```plain
DEST_DIR=/usr/local/share/applications/
sudo mkdir -p "$DEST_DIR"
sudo curl https://raw.githubusercontent.com/musinsky/config/master/freedesktop/root.desktop \
     --output-dir "$DEST_DIR" --remote-name

DEST_DIR=/usr/local/share/icons/hicolor/scalable/apps/
sudo mkdir -p "$DEST_DIR"
sudo curl https://raw.githubusercontent.com/musinsky/config/master/freedesktop/root.svg \
     --output-dir "$DEST_DIR" --remote-name
```
