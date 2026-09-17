<!-- markdownlint-disable MD033 MD041-->
<p align="right">last edit: 2026-09-17</p>
<!-- markdownlint-enable  MD033 MD041-->

- <https://muke.saske.sk/wiki/GNOME>

## admin

```plain
sudo curl -fSs https://raw.githubusercontent.com/musinsky/config/master/GNOME/01-muke-customize-gdm \
     --output-dir /etc/dconf/db/gdm.d/ --remote-name
sudo dconf update
```

## user

```plain
curl -fSs https://raw.githubusercontent.com/musinsky/config/master/GNOME/dconf-settings.sh | bash
```
