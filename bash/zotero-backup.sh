#!/bin/bash

ZDIR=.mozilla/firefox/*.default/zotero
ZSTORAGE=$ZDIR/storage
ZSQLITE=$ZDIR/zotero.sqlite
ZBAK=zotero_`date +%F`.tar.xz

tar -cJvf $ZBAK $ZSTORAGE $ZSQLITE
chmod 444 $ZBAK
