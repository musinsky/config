<?php
/*
 * 2026-10-21
 * https://github.com/musinsky/config/blob/master/phpMyAdmin/config.inc.php
 *
 * /etc/phpMyAdmin/config.inc.php   (640, root:apache)
 */

declare(strict_types=1);

/* Servers configuration */
$i = 0;

/* Server: localhost [1] */
$i++;
$cfg['Servers'][$i]['auth_type'] = 'http';
$cfg['Servers'][$i]['host'] = 'localhost';
$cfg['Servers'][$i]['AllowNoPassword'] = true;

/* End of servers configuration */

$cfg['MaxRows'] = '999';

?>
