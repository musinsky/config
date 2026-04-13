<!-- markdownlint-disable MD033 MD041-->
<p align="right">last edit: 2026-04-14</p>
<!-- markdownlint-enable  MD033 MD041-->

# Emacs

## custom init file

```console
cp -p "$HOME/.emacs.el" "$HOME/.emacs.el.$(date +%F_%T)"
curl -o "$HOME/.emacs.el" https://raw.githubusercontent.com/musinsky/config/master/Emacs/emacs.el
```

## muke-emacs-format.sh

A simple Emacs batch script that replaces of various programs for formatting,
indenting or cleaning of code (like `clang-format`, `astyle`, `indent`, etc.).
Support all languages supported by Emacs (several hundred).

### install (download)

```console
curl --silent https://raw.githubusercontent.com/musinsky/config/master/Emacs/muke-emacs-format.sh |
    install --verbose --mode=755 /dev/stdin /usr/local/bin/muke-emacs-format.sh
```

### usage

```console
muke-emacs-format.sh sample.tex
muke-emacs-format.sh -e c++-mode sample.c
```
