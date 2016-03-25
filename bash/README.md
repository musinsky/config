Bash shell
----------

### User
```
wget https://raw.githubusercontent.com/musinsky/config/master/bash/user-dirs.dirs -O ~/.config/user-dirs.dirs
```

append content of ``bash_profile`` to ``~/.bash_profile``
```
wget -O - https://raw.githubusercontent.com/musinsky/config/master/bash/bash_profile >> .bash_profile
```

```
wget https://raw.githubusercontent.com/musinsky/config/master/bash/bash_profile
sed -i '$ r bash_profile' ~/.bash_profile
rm bash_profile
```

### Admin
```
wget https://raw.githubusercontent.com/musinsky/config/master/bash/mucha_set.sh -O /etc/profile.d/mucha_set.sh
```

```
wget https://raw.githubusercontent.com/musinsky/config/master/bash/gnome-terminal -O /usr/local/bin/gnome-terminal
chmod 755 /usr/local/bin/gnome-terminal
```
