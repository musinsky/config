# TeX Live 2025
# https://github.com/musinsky/config/tree/master/TeXLive/texlive.profile
#
# /opt/texlive/2025/tlpkg/texlive.profile

# must be set every 4 dirs with prefix '/opt',
# otherwise the default prefix '/usr/local' will be used instead

selected_scheme scheme-custom
TEXDIR /opt/texlive/2025
TEXMFLOCAL /opt/texlive/texmf-local
TEXMFSYSCONFIG /opt/texlive/2025/texmf-config
TEXMFSYSVAR /opt/texlive/2025/texmf-var
collection-basic 1
collection-latex 1
collection-latexrecommended 1

# everything else as default
