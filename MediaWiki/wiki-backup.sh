#!/usr/bin/bash

# 2022-05-25
# https://github.com/musinsky/config/blob/master/MediaWiki/wiki-backup.sh

DBname=$(hostname)_wiki   # better choice is parsing $wgDBname in LocalSettings.php
DBuser=wikiuser
MWDIR=/opt/mediawiki
DUMP="$DBname"-dump_$(date +%F)
MWXML=$DUMP.xml
MWSQL=$DUMP.sql
MWUPL=upload.files
MWEXT=extensions.list
MWBCP="$DBname"-backup_$(date +%F).tar.gz
BCPSC=$(basename $0)

# SQL
echo "mariadb-dump --user=$DBuser --password $DBname"
mariadb-dump --user=$DBuser --password $DBname > $MWSQL

# XML and upload files
php $MWDIR/maintenance/dumpBackup.php --current > $MWXML
php $MWDIR/maintenance/dumpUploads.php > $MWUPL

# extensions list
ls -l $MWDIR/extensions | grep '^d' > $MWEXT

# archiving
tar -czf $MWBCP $MWSQL $MWXML $MWUPL $MWEXT $BCPSC -C $MWDIR LocalSettings.php images \
    -P /etc/httpd/conf.d/mediawiki.conf \
    /var/www/html/robots.txt /var/www/html/google*.html
rm $MWSQL $MWXML $MWUPL $MWEXT
chmod 400 $MWBCP
