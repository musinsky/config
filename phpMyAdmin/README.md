<!-- markdownlint-disable MD033 MD041-->
<p align="right">last edit: 2026-10-22</p>
<!-- markdownlint-enable  MD033 MD041-->

- <https://muke.saske.sk/wiki/MySQL>

## phpMyAdmin config file

```plain
sudo cp -ip --update=none /etc/phpMyAdmin/config.inc.php /etc/phpMyAdmin/config.inc.php.orig
curl -fSL https://raw.githubusercontent.com/musinsky/config/master/phpMyAdmin/config.inc.php -o /tmp/tmp.file
sudo install --compare -o root -g apache -m 640 /tmp/tmp.file /etc/phpMyAdmin/config.inc.php
rm -f /tmp/tmp.file
```

## phpMyAdmin manual installation (not recommended)

- Download latest [phpMyAdmin](https://www.phpmyadmin.net/downloads/) tarball and unpack to `/opt/` directory.

```plain
curl -fSL https://raw.githubusercontent.com/musinsky/config/master/phpMyAdmin/phpMyAdmin.conf -o /etc/httpd/conf.d/phpMyAdmin.conf
chmod 644 /etc/httpd/conf.d/phpMyAdmin.conf
chown root:root /etc/httpd/conf.d/phpMyAdmin.conf

systemctl restart httpd.service
```
