#!/usr/bin/env bash

# 2024-01-16
# https://github.com/musinsky/config/blob/master/MediaWiki/wiki-backup.sh

[[ $EUID -ne 0 ]] && { printf "only root user\n"; exit 1; }

MWDIR="/opt/mediawiki"
MWLSF="LocalSettings.php"
# parsing between two apostrophes ($wgDBname = "example_wiki"; => example_wiki)
DBname="$(grep wgDBname     "$MWDIR/$MWLSF" | grep -oP '(?<=").*(?=")')"
DBuser="$(grep wgDBuser     "$MWDIR/$MWLSF" | grep -oP '(?<=").*(?=")')"
DBpass="$(grep wgDBpassword "$MWDIR/$MWLSF" | grep -oP '(?<=").*(?=")')" # only view
# DBcharset="$(grep wgDBTableOptions "$MWDIR/$MWLSF" | grep -oP '(?<=DEFAULT CHARSET=).*(?=")')"
# mysqldump --default-character-set=binary
MWBCP="$DBname-backup_$(date +%F).tar.xz"
DUMP="$DBname-dump_$(date +%F)"
MWSQL="$DUMP.sql"
MWXML="$DUMP.xml"
MWUPL="$DUMP.uploads"
MWEXT="$DUMP.extensions"

# SQL
printf "mysqldump --user=%s --password  %s" "$DBuser" "$DBname"
printf "   # password='%s'\n" "$DBpass"
mysqldump --user="$DBuser" --password "$DBname" > "$MWSQL"

# XML and uploaded files
php "$MWDIR/maintenance/dumpBackup.php" --current > "$MWXML"
php "$MWDIR/maintenance/dumpUploads.php" > "$MWUPL"

# extensions dir
ls --time-style=long-iso -l -d "$MWDIR/extensions"/*/ > "$MWEXT" # don't quotes "*"

# archiving
tar -chJf "$MWBCP" "$MWSQL" "$MWXML" "$MWUPL" "$MWEXT" \
    "$MWDIR/$MWLSF" "$MWDIR/images" \
    -C "$(dirname "$0")" "$(basename "$0")" \
    -P /etc/httpd/conf.d/mediawiki.conf \
    /var/www/html/robots.txt \
    /var/www/html/google*.html \
    && printf "'%s' created\n" "$MWBCP"
rm "$MWSQL" "$MWXML" "$MWUPL" "$MWEXT"
chmod 400 "$MWBCP"
