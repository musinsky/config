<p align="right">last edit: 2024-11-11</p>

## Bash shell

### user
* customized `~/.bashrc` file
```
cp -ip "$HOME"/.bashrc "$HOME"/.bashrc.orig
wget https://raw.githubusercontent.com/musinsky/config/master/bash/bashrc -O "$HOME"/.bashrc
```

* restore `~/.bashrc` to default (if something wrong)
```
/usr/bin/cp -ip /etc/skel/.bashrc "$HOME"
source "$HOME"/.bashrc
```

### admin
```
wget https://raw.githubusercontent.com/musinsky/config/master/bash/muke-profile.sh -O /etc/profile.d/muke-profile.sh
```
