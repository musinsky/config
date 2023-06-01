#!/usr/bin/env bash

# 2023-06-01

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

# replace all color names between line starts with '[core]'
# and the last line '$' ('gray' is in the title and not as a color name)
# be careful with order (lightgray/gray and brightblue/blue)
L_NUMBER="$(grep -n '^\[core\]' "$F_NOALIAS" | cut -f 1 -d ':')"
sed -i "$L_NUMBER,$ {s/lightgray/color250/g;  s/gray/color254/g}" "$F_NOALIAS"
sed -i "$L_NUMBER,$ {s/brightblue/color244/g; s/blue/color238/g}" "$F_NOALIAS"
sed -i "$L_NUMBER,$  s/cyan/color244/g"                           "$F_NOALIAS"
# or to same (without variable $L_NUMBER)
# sed -i '/^\[core\]/,$ {s/lightgray/color250/g;  s/gray/color254/g}' "$F_NOALIAS"


# address range (selecting lines by text matching)
# https://www.gnu.org/software/sed/manual/html_node/sed-addresses.html
# https://www.gnu.org/software/sed/manual/html_node/Regexp-Addresses.html
#
# print 'p' lines between line starts with '[' and line starts with '['
# sed -n '/^\[/,/^\[/ p' "$F_ALIAS"
# print 'p' lines between line with 'description' and line with 'Lines'
# sed -n '/description/,/Lines/ p' "$F_ALIAS"
#
# print 'p' lines between line starts with '[core]' and line starts with '['
# sed -n '/^\[core\]/,/^\[/ p' "$F_ALIAS"
# print 'p' lines between line starts with '[core]' and last line '$'
# sed -n '/^\[core\]/,$ p' "$F_ALIAS"
# print 'p' lines between first line '0' and line starts with '[core]'
# sed -n '0,/^\[core\]/ p' "$F_ALIAS"
