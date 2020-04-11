<?php
/*
 * https://github.com/musinsky/config/tree/master/phpMyAdmin
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
