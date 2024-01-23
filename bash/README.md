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

* user dirs
```
wget https://raw.githubusercontent.com/musinsky/config/master/bash/user-dirs.dirs -O "$HOME"/.config/user-dirs.dirs
chmod 600 "$HOME"/.config/user-dirs.dirs
chown "$USER":"$USER" "$HOME"/.config/user-dirs.dirs
```

### admin
```
wget https://raw.githubusercontent.com/musinsky/config/master/bash/muke-profile.sh -O /etc/profile.d/muke-profile.sh
```
