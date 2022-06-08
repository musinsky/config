#!/usr/bin/bash

# 2022-06-08
# https://github.com/musinsky/config/blob/master/MediaWiki/wiki-backup.sh

MWDIR=/opt/mediawiki
MWLSF=LocalSettings.php
# parsing between two apostrophes ($wgDBname = "example_wiki"; => example_wiki)
DBname=$(grep DBname $MWDIR/$MWLSF | grep -oP '(?<=").*(?=")')
DBuser=$(grep DBuser $MWDIR/$MWLSF | grep -oP '(?<=").*(?=")')
# DBcharset=$(grep DBTableOptions $MWDIR/$MWLSF | grep -oP '(?<=DEFAULT CHARSET=).*(?=")')
# mysqldump --default-character-set=binary
DUMP="$DBname"-dump_$(date +%F)
MWSQL=$DUMP.sql
MWXML=$DUMP.xml
MWUPL=$DUMP.uploads
MWEXT=extensions.dir
MWBCP="$DBname"-backup_$(date +%F).tar.xz
BCPSC=$(basename $0)

# SQL
echo "mysqldump --user=$DBuser --password $DBname"
mysqldump --user=$DBuser --password $DBname > $MWSQL

# XML and uploaded files
php $MWDIR/maintenance/dumpBackup.php --current > $MWXML
php $MWDIR/maintenance/dumpUploads.php > $MWUPL

# extensions dir
ls -l $MWDIR/extensions | grep '^d' > $MWEXT

# archiving
tar -cJf $MWBCP $MWSQL $MWXML $MWUPL $MWEXT $BCPSC -C $MWDIR $MWLSF images \
    -P /etc/httpd/conf.d/mediawiki.conf \
    /var/www/html/robots.txt /var/www/html/google*.html
rm $MWSQL $MWXML $MWUPL $MWEXT
chmod 400 $MWBCP
