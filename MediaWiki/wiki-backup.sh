#!/usr/bin/env bash

# 2024-10-28
# https://github.com/musinsky/config/blob/master/MediaWiki/wiki-backup.sh

[ "$EUID" -ne 0 ] && { printf "only root user\n"; exit 1; }

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
FILES="$DUMP.files"
MWEXT="$DUMP.extensions"

# SQL
printf "mysqldump --user=%s --password  %s" "$DBuser" "$DBname"
printf "   # password='%s'\n" "$DBpass"
mysqldump --user="$DBuser" --password "$DBname" > "$MWSQL"
# XML
php "$MWDIR/maintenance/dumpBackup.php" --current > "$MWXML"
# uploaded files (images)
php "$MWDIR/maintenance/dumpUploads.php" > "$MWUPL"
# files (local files)
ls -lR --group-directories-first --time-style="+%F %T" "$MWDIR/files" > "$FILES"
# extensions (dir names)
ls -ld --time-style="+%F %T" "$MWDIR/extensions"/*/ > "$MWEXT" # don't quotes "*"

# archiving
tar -chJf "$MWBCP" \
    "$MWSQL" "$MWXML" "$MWUPL" "$FILES" "$MWEXT" \
    --exclude="$MWDIR/images/thumb" "$MWDIR/images" "$MWDIR/$MWLSF" \
    -C "$(dirname "$0")" "$(basename "$0")" \
    -P /etc/httpd/conf.d/mediawiki.conf \
    /var/www/html/robots.txt \
    /var/www/html/google*.html \
    && printf "'%s' created\n" "$MWBCP"
rm "$MWSQL" "$MWXML" "$MWUPL" "$FILES" "$MWEXT"
chmod 400 "$MWBCP"

# ### webfiles ###
# WFDIR="/opt/webfiles"
# [ -d "$WFDIR" ] || { printf "'%s' no such directory\n" "$WFDIR"; exit 1; }

# WFBCP="webfiles_$(date +%F).tar.gz"
# tar -chzf "$WFBCP" -P "$WFDIR" /etc/httpd/conf.d/webfiles.conf \
    #     && printf "'%s' created\n" "$WFBCP"
# chmod 444 "$WFBCP"
