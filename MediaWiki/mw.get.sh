#!/usr/bin/env bash

# 2024-10-21
# https://github.com/musinsky/config/blob/master/MediaWiki/mw.get.sh

# https://releases.wikimedia.org/mediawiki/1.42/?C=M;O=D
# => mediawiki-core-1.42.3.tar.gz ~52M
# => mediawiki-1.42.3.tar.gz      ~85M
# release (tarball) comes with a number of extensions and skins bundled
# https://www.mediawiki.org/wiki/Bundled_extensions_and_skins
#
# https://github.com/wikimedia/mediawiki   (MediaWiki core)
# https://github.com/wikimedia/mediawiki/archive/refs/heads/master.zip  # development branch
# https://github.com/wikimedia/mediawiki/archive/refs/heads/REL1_42.zip # release branch
# https://github.com/wikimedia/mediawiki/archive/refs/tags/1.42.3.zip   # release tag version
#
# https://github.com/wikimedia/mediawiki-extensions   (MediaWiki extensions)
# https://github.com/wikimedia/mediawiki-extensions-Cite/archive/refs/heads/master.zip
# https://github.com/wikimedia/mediawiki-extensions-Cite/archive/refs/heads/REL1_42.zip
# no release tags version
#
# https://github.com/wikimedia/mediawiki-skins   (MediaWiki skins)
# https://github.com/wikimedia/mediawiki-skins-Vector/archive/refs/heads/master.zip
# https://github.com/wikimedia/mediawiki-skins-Vector/archive/refs/heads/REL1_42.zip
# no release tags version
#
# https://www.mediawiki.org/wiki/Special:ExtensionDistributor/Cite
# https://extdist.wmflabs.org/dist/extensions/Cite-REL1_42-1d977ba.tar.gz
# https://www.mediawiki.org/wiki/Special:SkinDistributor/Vector
# https://extdist.wmflabs.org/dist/skins/Vector-REL1_42-ac50184.tar.gz
# no automatic download method (file name contains git commit hash)
#
# https://github.com/wikimedia/mediawiki-vendor   (MediaWiki vendor)
# https://github.com/wikimedia/mediawiki-vendor/archive/refs/heads/master.zip
# https://github.com/wikimedia/mediawiki-vendor/archive/refs/heads/REL1_42.zip
# no release tags version

gh_get() {
    local owner="$1"
    local repo="$2"
    local branch="$3"
    local dir_move="$4"
    local file="$branch.tar.gz"
    local url="https://github.com/$owner/$repo/archive/refs/heads/$file"

    printf "\ndownloading '%s'\n" "$url"
    wget --quiet --directory-prefix "$DIR_DNLD" "$url" || return
    tar -xzf "$DIR_DNLD/$file" --directory "$DIR_UNPK"
    rm --verbose "$DIR_DNLD/$file" || exit 1
    # downloaded file '$branch.tar.gz' was extracted to directory '$repo-$branch'
    [ -z "$dir_move" ] ||
        mv --verbose "$DIR_UNPK/$repo-$branch" "$MW_CORE_DIR/$dir_move" || exit 1
}

MW_BRANCH="REL1_42" # release (stable) branch
MW_BRANCH="master"  # development branch
DIR_DNLD="$(mktemp --directory --suffix _Download_$MW_BRANCH)" || exit 1
DIR_UNPK="$(mktemp --directory --suffix _Unpack_$MW_BRANCH)" || exit 1
OPT_MW_CORE_EXCLUDE="no" # exclude or not exclude MediaWiki core
#OPT_MW_CORE_EXCLUDE="yes"

# MediaWiki core
MW_CORE_DIR="$DIR_UNPK/mediawiki-$MW_BRANCH" # don not change, must be '$repo-$branch'
if [ "$OPT_MW_CORE_EXCLUDE" = "yes" ]; then
    mkdir --parent "$MW_CORE_DIR"/{extensions,skins} # do not download MediaWiki core
else
    gh_get wikimedia mediawiki "$MW_BRANCH"
    # directories 'extensions' and 'skins' in the release branch (not in the development
    # branch) contain empty sub-directories of bundled extensions and skins
    find "$MW_CORE_DIR/extensions" -mindepth 1 -type d -printf '%f\n' -delete \
         > "$MW_CORE_DIR/extensions/default.bundled.extensions"
    find "$MW_CORE_DIR/skins"      -mindepth 1 -type d -printf '%f\n' -delete \
         > "$MW_CORE_DIR/skins/default.bundled.skins"
    # empty directory 'vendor' exists in the release branch but not in the development branch
    [ -d "$MW_CORE_DIR/vendor" ] && rmdir "$MW_CORE_DIR/vendor"
fi
# ln --verbose --symbolic --relative "$MW_CORE_DIR" "$DIR_UNPK/mediawiki"

# MediaWiki vendor
# development branch has ~4-5x more size than release branch
gh_get wikimedia mediawiki-vendor "$MW_BRANCH" vendor

# MediaWiki extensions
gh_get wikimedia mediawiki-extensions-CategoryTree     "$MW_BRANCH" extensions/CategoryTree
gh_get wikimedia mediawiki-extensions-Cite             "$MW_BRANCH" extensions/Cite
gh_get wikimedia mediawiki-extensions-CodeMirror       "$MW_BRANCH" extensions/CodeMirror
gh_get wikimedia mediawiki-extensions-Interwiki        "$MW_BRANCH" extensions/Interwiki
gh_get wikimedia mediawiki-extensions-MultimediaViewer "$MW_BRANCH" extensions/MultimediaViewer
gh_get wikimedia mediawiki-extensions-ParserFunctions  "$MW_BRANCH" extensions/ParserFunctions
gh_get wikimedia mediawiki-extensions-ReplaceText      "$MW_BRANCH" extensions/ReplaceText
gh_get wikimedia mediawiki-extensions-SyntaxHighlight_GeSHi "$MW_BRANCH" \
       extensions/SyntaxHighlight_GeSHi
gh_get wikimedia mediawiki-extensions-TemplateData     "$MW_BRANCH" extensions/TemplateData
gh_get wikimedia mediawiki-extensions-Variables        "$MW_BRANCH" extensions/Variables
gh_get wikimedia mediawiki-extensions-WikiEditor       "$MW_BRANCH" extensions/WikiEditor
# other extensions
gh_get jmnote    SimpleMathJax                         main         extensions/SimpleMathJax

# MediaWiki skins
gh_get wikimedia mediawiki-skins-MinervaNeue "$MW_BRANCH" skins/MinervaNeue
gh_get wikimedia mediawiki-skins-MonoBook    "$MW_BRANCH" skins/MonoBook
gh_get wikimedia mediawiki-skins-Timeless    "$MW_BRANCH" skins/Timeless
gh_get wikimedia mediawiki-skins-Vector      "$MW_BRANCH" skins/Vector

rmdir "$DIR_DNLD"   # remove empty download dir
# remove unnecessary parts
find "$MW_CORE_DIR" -type f -name '.*' | xargs -r rm   # all dot files, i.a. '.htaccess'
find "$MW_CORE_DIR" -type d -name '.phan' | xargs -r rm -rf
rm -rf "$MW_CORE_DIR/tests"

# printf "\nMediaWiki has been downloaded into the dir: '%s'\n" "$MW_CORE_DIR"
printf "\nsuperuser (root) privileges required (chown)\n"
sudo chown --recursive root:root "$MW_CORE_DIR"
sudo chown apache:apache "$MW_CORE_DIR/images"   # apache on Fedora/RHEL

MW_TARBALL="$(basename "$MW_CORE_DIR")-$(date +%F).tar.gz"
printf "\ncreating '%s'\n" "$MW_TARBALL"
tar -czf "$MW_TARBALL" -C "$(dirname "$MW_CORE_DIR")" "$(basename "$MW_CORE_DIR")" \
    && printf "'%s' created\n" "$MW_TARBALL"
chmod 444 "$MW_TARBALL"
sudo rm -rf "$DIR_UNPK"   # remove unpack dir
