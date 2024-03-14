# TeX Live 2024
# https://github.com/musinsky/config/tree/master/TeXLive
#
# /opt/texlive/2024/tlpkg/texlive.profile

# must be set every 4 dirs with prefix '/opt', otherwise the default
# prefix '/usr/local' will be used instead

selected_scheme scheme-custom
TEXDIR /opt/texlive/2024
TEXMFLOCAL /opt/texlive/texmf-local
TEXMFSYSCONFIG /opt/texlive/2024/texmf-config
TEXMFSYSVAR /opt/texlive/2024/texmf-var
collection-basic 1
collection-latex 1
collection-latexrecommended 1

# everything else as default
