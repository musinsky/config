<p align="right">last edit: 2024-10-15</p>

## Emacs
### custom init file
```
cp -p $HOME/.emacs.el $HOME/.emacs.el.$(date +%F_%T)
wget -O $HOME/.emacs.el https://raw.githubusercontent.com/musinsky/config/master/Emacs/emacs.el
```

### muke-emacs-format.sh
A simple Emacs batch script that replaces of various programs for formatting,
indenting or cleaning of code (like `clang-format`, `astyle`, `indent`, etc.).
Support all languages supported by Emacs (several hundred).

**install**
```
BDIR='/usr/local/bin'
wget https://raw.githubusercontent.com/musinsky/config/master/Emacs/muke-emacs-format.sh -P "$BDIR"
chmod 755 "$BDIR/muke-emacs-format.sh"
```
**usage**
```
$ muke-emacs-format.sh sample.tex
$ muke-emacs-format.sh -e c++-mode sample.c
```
