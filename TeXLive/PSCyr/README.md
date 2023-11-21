# PSCyr
* See on https://muke.saske.sk/wiki/TeXLive for more info.
* Collection of PSCyr fonts (version 0.4d-beta9, 2004-10-15), Alexander Lebedev (2000-2004). Tested on Linux (Fedora) and TeX Live.
### install
1. as **admin** (recommended) to **$TEXMFLOCAL** (`/opt/texlive/texmf-local`)
```
export DEST_DIR=$(kpsewhich -var-value=TEXMFLOCAL)
```
2. or as **user** to **$TEXMFHOME** (`/home/musinsky/texmf`)
```
export DEST_DIR=$(kpsewhich -var-value=TEXMFHOME)
```
* common parts
```
wget https://raw.githubusercontent.com/musinsky/config/master/TeXLive/PSCyr/PSCyr-0.4-beta9-tex.tar.gz
wget https://raw.githubusercontent.com/musinsky/config/master/TeXLive/PSCyr/PSCyr-0.4-beta9-type1.tar.gz
tar -xzf PSCyr-0.4-beta9-type1.tar.gz
tar -xzf PSCyr-0.4-beta9-tex.tar.gz

mkdir -p $DEST_DIR/fonts/{afm,tfm,type1,vf}/public/pscyr
mkdir -p $DEST_DIR/fonts/{enc,map}/dvips/pscyr
mkdir -p $DEST_DIR/fonts/map/dvipdfm/pscyr
mkdir -p $DEST_DIR/tex/latex/pscyr
mkdir -p $DEST_DIR/doc/fonts/pscyr

mv PSCyr/fonts/afm/public/pscyr/*   $DEST_DIR/fonts/afm/public/pscyr
mv PSCyr/fonts/tfm/public/pscyr/*   $DEST_DIR/fonts/tfm/public/pscyr
mv PSCyr/fonts/type1/public/pscyr/* $DEST_DIR/fonts/type1/public/pscyr
mv PSCyr/fonts/vf/public/pscyr/*    $DEST_DIR/fonts/vf/public/pscyr
mv PSCyr/dvips/pscyr/*.enc       $DEST_DIR/fonts/enc/dvips/pscyr
mv PSCyr/dvips/pscyr/*.map       $DEST_DIR/fonts/map/dvips/pscyr
mv PSCyr/dvipdfm/base/*.map      $DEST_DIR/fonts/map/dvipdfm/pscyr
mv PSCyr/tex/latex/pscyr/*    $DEST_DIR/tex/latex/pscyr

# documentation
mv PSCyr/ChangeLog        $DEST_DIR/doc/fonts/pscyr
mv PSCyr/LICENSE          $DEST_DIR/doc/fonts/pscyr
mv PSCyr/manifest.txt     $DEST_DIR/doc/fonts/pscyr
mv PSCyr/doc/PROBLEMS     $DEST_DIR/doc/fonts/pscyr
mv PSCyr/doc/fonts-ex.tex $DEST_DIR/doc/fonts/pscyr
iconv -f KOI8-R -t UTF8 < PSCyr/doc/README.koi > $DEST_DIR/doc/fonts/pscyr/README.utf8
```
1. as **admin** (recommended)
```
mktexlsr
updmap-sys --enable Map=pscyr.map
```
2. or as **user**
```
mktexlsr $DEST_DIR
updmap-user --enable Map=pscyr.map
```
