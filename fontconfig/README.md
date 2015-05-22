Font Configuration
------------------
```
wget https://raw.githubusercontent.com/musinsky/config/master/fontconfig/19-mucha-font.conf -P /usr/share/fontconfig/conf.avail/
ln -s /usr/share/fontconfig/conf.avail/19-mucha-font.conf /etc/fonts/conf.d/19-mucha-font.conf
```

Copy (if necessary) file ``Xresources`` to ``~/.Xresources`` or ``/etc/X11/Xresources``
