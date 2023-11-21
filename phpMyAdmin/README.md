## phpMyAdmin
* Download latest [phpMyAdmin](https://www.phpmyadmin.net/downloads/) tarball and unpack to `/opt/` directory.
```
wget -nc https://raw.githubusercontent.com/musinsky/config/master/phpMyAdmin/phpMyAdmin.conf -O /etc/httpd/conf.d/phpMyAdmin.conf
chmod 644 /etc/httpd/conf.d/phpMyAdmin.conf
chown root:root /etc/httpd/conf.d/phpMyAdmin.conf

wget -nc https://raw.githubusercontent.com/musinsky/config/master/phpMyAdmin/config.inc.php -O /opt/phpMyAdmin/config.inc.php
chmod 640 /opt/phpMyAdmin/config.inc.php
chown root:apache /opt/phpMyAdmin/config.inc.php

systemctl restart httpd.service
```
* More info on https://muke.saske.sk/wiki/MySQL
