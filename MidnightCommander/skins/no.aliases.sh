#!/usr/bin/env bash

# 2023-05-31

F_ALIAS='default-gray256.ini'
F_NOALIAS='default-gray256.no.aliases.ini'

# delete the lines lying between 'pattern1' and 'patter2'
# including the lines containing these patterns
# sed '/pattern1/,/pattern2/d' input.file
# excluding the lines containing these patterns
# sed '/pattern1/,/pattern2/{//!d}' input.file
# and line starts with these patterns
# sed '/^pattern1/,/^pattern2/{//!d}' input.file
#
# remove all lines lying between line starts with '[aliases]' and '[core]'
sed '/^\[aliases\]/,/^\[core\]/{//!d}' "$F_ALIAS" > "$F_NOALIAS"

# remove (all) line starts with '[aliases]'
sed -i '/^\[aliases\]/d' "$F_NOALIAS"

# replace (all) $F_ALIAS by $F_NOALIAS (https github file name)
sed -i "s/$F_ALIAS/$F_NOALIAS/g" "$F_NOALIAS"

# replace all color names after line starts with '[core]' ('gray' is in title)
# be careful with order (lightgray/gray and brightblue/blue)
L_NUMBER=$(grep -n '\[core\]' "$F_NOALIAS" | cut -f 1 -d ':')
sed -i "$L_NUMBER,$ {s/lightgray/color250/g;  s/gray/color254/g}" "$F_NOALIAS"
sed -i "$L_NUMBER,$ {s/brightblue/color244/g; s/blue/color238/g}" "$F_NOALIAS"
sed -i "$L_NUMBER,$  s/cyan/color244/g"                           "$F_NOALIAS"
