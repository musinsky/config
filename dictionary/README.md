<!-- markdownlint-disable MD033 MD041-->
<p align="right">last edit: 2026-09-22</p>
<!-- markdownlint-enable  MD033 MD041-->

## Sharing personal dictionary

```plain
# curl https://raw.githubusercontent.com/musinsky/config/master/dictionary/musinsky.dic -o "$HOME/.musinsky.dic"
ln -s "$HOME/config/dictionary/musinsky.dic" "$HOME/.musinsky.dic"
```

### Emacs

Default sa personalne slovniky ukladaju (v zavislosti od jazyka) do suborov `$HOME/.hunspell_sk_SK` resp.
`$HOME/.hunspell_en_US`. Nastavenie `(setq ispell-personal-dictionary "~/.musinsky.dic")` umoznuje zdielat jeden
personalny slovnik spolocny pre vsetky jazyky. Slova sa pridavaju na koniec slovnika (suboru).

### LibreOffice

LibreOffice umoznuje pridavat rozne slovniky: tematicke, synonymicke, jazykove, resp. *User-defined Dictionaries*. V
pripade ak sa subor so slovnikom vola `standard.dic`, LibreOffice ho automaticky zapne, inak je potrebne subor so
slovnikom pridat/aktivovat cez *Tools/Options > Languages and Locales/Writing Aids/User-defined Dictionaries*.

Personalny slovnik je ulozeny ako `$HOME/.config/libreoffice/<majorVersion>/user/wordbook/standard.dic` subor a je
pristupny pre vsetky jazyky. Novo pridane slova v slovniku sa automaticky usporiadava podla abecedy (ekvivalent
`LC_COLLATE=C sort -u standard.dic`). Nazov suboru musi mat koncovku `.dic` a subor musi zacinat hlavickou:

```plain
OOoUserDict1
lang: <none>
type: positive
---
<some_dict_word>
```

```plain
ln -s "$HOME/.musinsky.dic" "$(find $HOME/.config/libreoffice/*/user/wordbook -type d)"/standard.dic
```

### Firefox

Firefox personalny slovnik je ulozeny ako `$HOME/.config/mozilla/firefox/<uniqueID>.default-release/persdict.dat` subor.
Nazov slovnika (suboru) nie je mozne menit. Pri ulozeni noveho slova do `persdict.dat` sa meni usporiadanie slov. Ak by
sa tento slovnik (subor) zdielal s LibreOffice, potom by sa preusporiadali aj prve riadky z hlavicky tohoto slovnika, a
teda pre LibreOffice by bol tento slovnik uz dalej nepouzitelny.

Prijatelne riesenie je cas od casu vytvorit novy personalny slovnik pre Firefox spojenim jeho stareho slovnika a
spolocneho slovnika pre Emacs a LibreOffice

```plain
sed -n '5,$p' "$HOME/.musinsky.dic" "$HOME"/.config/mozilla/firefox/*.default-release/persdict.dat | LC_COLLATE=C sort -u > persdict_merge.dat
```

### Google Chrome

Personalny slovnik ulozeny ako `$HOME/.config/google-chrome/Default/Custom Dictionary.txt` subor. Nazov slovnika
(suboru) nie je mozne menit. Pri ulozeni noveho slova do `Custom Dictionary.txt` sa meni usporiadanie (abecedne) slov +
nakoniec sa pridava jeden riadok s checksum. Plati teda to iste ako pre Firefox, nemoznost pouzivat spolu s LibreOffice,
resp. cas od casu manualne spajat slovniky.
