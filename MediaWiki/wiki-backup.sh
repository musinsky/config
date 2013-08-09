#!/bin/bash
# https://github.com/musinsky/config/tree/master/MediaWiki

DBname=alice_wiki
DBuser=wikiuser
MWDIR=/opt/mediawiki
DUMP="$DBname"_dump_`date +%F`
MWXML=$DUMP.xml
MWSQL=$DUMP.sql
MWBCP="$DBname"_backup_`date +%F`.tar.gz

# XML
php $MWDIR/maintenance/dumpBackup.php --current > $MWXML

# SQL
echo "mysqldump --user=$DBuser --password $DBname"
mysqldump --user=$DBuser --password $DBname -c > $MWSQL

tar -czf $MWBCP $MWXML $MWSQL -C $MWDIR LocalSettings.php images \
    -P /etc/httpd/conf.d/mediawiki.conf \
    /var/www/html/robots.txt /var/www/html/google*.html
rm $MWXML $MWSQL
chmod 400 $MWBCP
