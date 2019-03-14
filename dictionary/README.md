Sharing personal dictionary
---------------------------
### Emacs
* default sa personalne slovniky ukladaju (v zavislosti od jazyka) do suboru `~/.hunspell_sk_SK` resp. `~/.hunspell_ru_RU`
* `(setq ispell-personal-dictionary "~/.musinsky.dic")` umoznuje nastavit personalny slovnik (spolocny pre vsetky jazyky). Slova sa pridavaju na koniec slovnika (suboru).
```
wget https://raw.githubusercontent.com/musinsky/config/master/dictionary/musinsky.dic -O ~/.musinsky.dic
```

### LibreOffice
* default je personalny slovnik ulozeny `~/.config/libreoffice/[majorVersion]/user/wordbook/standard.dic`
  * moznost [pridavat rozne slovniky](https://help.libreoffice.org/Common/Writing_Aids/cs): tematicke, synonymicke, jazykove
  * nazov suboru musi mat koncovku `.dic`
  * subor musi zacinat hlavickou
```
OOoUserDict1
lang: <none>
type: positive
---
some_dict_word
```
* ak sa subor so slovnikom vola `standard.dic` LibreOffice ho automaticky zapne, inak je ho potrebne pridat/aktivovat cez *Tools/Options => Language Settings/Writing Aids/User-defined dictionaries*
* slova v slovniku sa automaticky usporiadavaju podla abecedy
* sharing personal dictionary file `~/.musinsky.dic`
```
ln -s ~/.musinsky.dic `find ~/.config/libreoffice/*/user/wordbook -type d`/standard.dic
```

### Firefox
* default je personalny slovnik ulozeny `~/.mozilla/firefox/[uniqueID.default]/persdict.dat`
* nazov slovnika (suboru) nie je mozne menit
* pri ulozeni noveho slova do `persdict.dat` sa meni usporiadanie slov. Ak by sa tento slovnik (subor) zdielal s LibreOffice, potom by sa preusporiadali aj prve riadky z hlavicky tohoto slovnika, a teda pre LibreOffice by bol tento slovnik uz dalej nepouzitelny.
* prijatelne riesenie je cas od casu vytvorit novy personalny slovnik pre Firefox spojenim jeho stareho slovnika a spolocneho slovnika pre Emacs a LibreOffice
```
sed -n '5,$p' ~/.musinsky.dic ~/.mozilla/firefox/*.default/persdict.dat | sort -u > persdict_merge.dat
```

### Google Chrome
* default je personalny slovnik ulozeny `~/.config/google-chrome/Default/Custom Dictionary.txt`
* nazov slovnika (suboru) nie je mozne menit
* pri ulozeni noveho slova do `Custom Dictionary.txt` sa meni usporiadanie (abecedne) slov + nakoniec sa pridava jeden riadok s checksum
* plati teda to iste ako pre Firefox, nemoznost pouzivat spolu s LibreOffice, resp. cas od casu manualne spajat slovniky
