#!/bin/bash
# https://github.com/musinsky/config/tree/master/MediaWiki

DBname=alice_wiki
DBuser=wikiuser
MWSQL=$DBname-dump_`date +%F`.sql
MWDIR=/opt/mediawiki
MWBCP=wiki-alice-backup_`date +%F`.tar.gz

echo "mysqldump --user=$DBuser --password $DBname"
mysqldump --user=$DBuser --password $DBname -c > $MWSQL
tar -czf $MWBCP $MWSQL -C $MWDIR LocalSettings.php images \
    -P /etc/httpd/conf.d/mediawiki.conf \
    /var/www/html/robots.txt /var/www/html/google*.html
rm $MWSQL
chmod 400 $MWBCP
