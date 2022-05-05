#!/usr/bin/bash

# 2022-05-05
# https://github.com/musinsky/config/blob/master/MediaWiki/wiki-backup.sh

DBname=$(hostname)_wiki
DBuser=wikiuser
MWDIR=/opt/mediawiki
DUMP="$DBname"_dump_$(date +%F)
MWXML=$DUMP.xml
MWSQL=$DUMP.sql
MWEXT=extensions.list
MWBCP="$DBname"_backup_$(date +%F).tar.gz
BCPSC=$(basename $0)

# XML
php $MWDIR/maintenance/dumpBackup.php --current > $MWXML

# SQL
echo "mysqldump --user=$DBuser --password $DBname"
mysqldump --user=$DBuser --password $DBname -c > $MWSQL

# extensions list
ls -l $MWDIR/extensions | grep '^d' > $MWEXT

# archiving
tar -czf $MWBCP $MWXML $MWSQL $MWEXT $BCPSC -C $MWDIR LocalSettings.php images \
    -P /etc/httpd/conf.d/mediawiki.conf \
    /var/www/html/robots.txt /var/www/html/google*.html
rm $MWXML $MWSQL $MWEXT
chmod 400 $MWBCP
