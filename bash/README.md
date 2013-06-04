Bash shell
----------

### User
append content of ``bash_profile`` to ``~/.bash_profile``
```
wget https://raw.github.com/musinsky/config/master/bash/bash_profile
sed -i '$ r bash_profile' ~/.bash_profile
rm bash_profile
```

### Admin
```
wget https://raw.github.com/musinsky/config/master/bash/mucha.sh -O /etc/profile.d/mucha.sh
```
