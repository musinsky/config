## Bash shell

### user
* customize `~/.bashrc` file
```
cp -ip "$HOME"/.bashrc "$HOME"/.bashrc.orig

# restore '~/.bashrc' to default (otional)
# cp -ip /etc/skel/.bashrc "$HOME"
# append content of customized 'bashrc' to '~/.bashrc'
wget -O - https://raw.githubusercontent.com/musinsky/config/master/bash/bashrc >> "$HOME"/.bashrc
```

* restore `~/.bashrc` to system default (if something wrong)
```
/usr/bin/cp -ip /etc/skel/.bashrc "$HOME"
source "$HOME"/.bashrc
```

* user dirs
```
wget https://raw.githubusercontent.com/musinsky/config/master/bash/user-dirs.dirs -O "$HOME"/.config/user-dirs.dirs
```

### admin
```
wget https://raw.githubusercontent.com/musinsky/config/master/bash/mucha_set.sh -O /etc/profile.d/mucha_set.sh
```
