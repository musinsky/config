phpMyAdmin
----------
```
wget https://raw.github.com/musinsky/config/master/phpMyAdmin/phpMyAdmin.conf -O /etc/httpd/conf.d/phpMyAdmin.conf
chmod 644 /etc/httpd/conf.d/phpMyAdmin.conf
chown root:root /etc/httpd/conf.d/phpMyAdmin.conf

wget https://raw.github.com/musinsky/config/master/phpMyAdmin/config.inc.php -O /opt/phpMyAdmin/config.inc.php
chmod 644 /opt/phpMyAdmin/config.inc.php
chown root:root /opt/phpMyAdmin/config.inc.php
```

More info on http://alice.saske.sk/wiki/MySQL
