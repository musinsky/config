<!-- markdownlint-disable MD033 MD041-->
<p align="right">last edit: 2026-09-17</p>
<!-- markdownlint-enable  MD033 MD041-->

## admin

```plain
sudo curl https://raw.githubusercontent.com/musinsky/config/master/bash/muke-profile.sh \
     --output-dir /etc/profile.d/ --remote-name
```

## user

- customized `$HOME/.bashrc` file

```plain
cp -p "$HOME/.bashrc" "$HOME/.bashrc.$(date +%F_%T)"
curl -o "$HOME/.bashrc" https://raw.githubusercontent.com/musinsky/config/master/bash/bashrc
```

- restore `$HOME/.bashrc` file to default (if something wrong)

```plain
/usr/bin/cp -ip /etc/skel/.bashrc "$HOME"
source "$HOME/.bashrc"
```
