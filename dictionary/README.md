Sharing personal dictionary
---------------------------
### Emacs
* default sa personalne slovniky ukladaju (v zavislosti od jazyka) do suboru `~/.hunspell_sk_SK` resp. `~/.hunspell_ru_RU`
* `(setq ispell-personal-dictionary "~/.musinsky.dic")` umoznuje nastavit personalny slovnik (spolocny pre vsetky jazyky)
```
wget https://raw.github.com/musinsky/config/master/dictionary/musinsky.dic -O ~/.musinsky.dic
```

### LibreOffice
* default je personalny slovnik ulozeny `~/.config/libreoffice/[majorVersion]/user/wordbook/standard.dic`
  * nazov suboru musi mat koncovku `.dic`
  * subor musi zacinat hlavickou
```
OOoUserDict1
lang: <none>
type: positive
---
some_dict_word
```
* ak sa subor so slovnikom vola `standard.dic` LibreOffice ho automaticky zapne, inak je ho potrebne [zapnut/aktivovat](https://help.libreoffice.org/Common/Writing_Aids/cs) cez *Tools/Options => Language Settings/Writing Aids/User-defined dictionaries*
* slova v slovniku sa automaticky usporiadavaju podla abecedy
* sharing personal dictionary file `~/.musinsky.dic`
```
ln -s ~/.musinsky.dic `find ~/.config/libreoffice/*/user/wordbook -type d`/standard.dic
```

### Firefox
* default je personalny slovnik ulozeny `~/.mozilla/firefox/[uniqueID.default]/persdict.dat`
* cestu ani nazov suboru nie je mozne menit
* pri ulozeni noveho slova do personalneho slovnika sa meni usporiadanie slov. Ak by sa tento slovnik (subor) zdielal s LibreOffice, potom by sa preusporiadali aj prve riadky z hlavicky tohoto slovnika, a teda pre LibreOffice by bol tento slovnik uz dalej nepouzitelny.
* prijatelne riesenie je cas od casu vytvorit novy slovnik pre Firefox spojenim jeho stareho slovnika a spolocneho slovnika pre Emacs a LibreOffice
```
sed -n '5,$p' ~/.musinsky.dic ~/.mozilla/firefox/*.default/persdict.dat | sort -u > merge_persdict.dat
```
