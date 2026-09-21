<!-- markdownlint-disable MD033 MD041-->
<p align="right">last edit: 2026-09-21</p>
<!-- markdownlint-enable  MD033 MD041-->

## global

- global environment variables

```plain
sudo curl https://raw.githubusercontent.com/musinsky/config/master/bash/muke-profile.sh \
     --output-dir /etc/profile.d/ --remote-name
```

## root user

- disable creation of unnecessary shell configuration files in `/root/` dir

```plain
cp -ip --update=none /usr/lib/tmpfiles.d/rootfiles.conf /usr/lib/tmpfiles.d/rootfiles.conf.orig
sed -i '\|^C /root/\.bash_logout|s|^|#|' /usr/lib/tmpfiles.d/rootfiles.conf
sed -i '\|^C /root/\.cshrc|s|^|#|'       /usr/lib/tmpfiles.d/rootfiles.conf
sed -i '\|^C /root/\.tcshrc|s|^|#|'      /usr/lib/tmpfiles.d/rootfiles.conf
```

- customized `/root/.bashrc` (`$HOME/.bashrc`) file

```plain
cp -p /root/.bashrc /root/.bashrc."$(date +%F_%T)"
curl -o /root/.bashrc https://raw.githubusercontent.com/musinsky/config/master/bash/bashrc.root
```

- restoring `/root/.bashrc` (`$HOME/.bashrc`) file to default (if something wrong)

```plain
/usr/bin/cp -ip /usr/share/rootfiles/.bashrc /root/
source /root/.bashrc
```

## user

- customized `$HOME/.bashrc` file

```plain
cp -p "$HOME/.bashrc" "$HOME/.bashrc.$(date +%F_%T)"
curl -o "$HOME/.bashrc" https://raw.githubusercontent.com/musinsky/config/master/bash/bashrc
```

- restoring `$HOME/.bashrc` file to default (if something wrong)

```plain
/usr/bin/cp -ip /etc/skel/.bashrc "$HOME"
source "$HOME/.bashrc"
```
