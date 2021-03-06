export ROOTSYS=/cern/root
export PATH=$PATH:$ROOTSYS/bin
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$ROOTSYS/lib
export MANPATH=:$MANPATH:$ROOTSYS/man
alias root='root -l'

export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/cern/xrootd/lib64
export PATH=$PATH:/cern/xrootd/bin

export PATH=/opt/texlive/2015/bin/x86_64-linux:$PATH
export MANPATH=/opt/texlive/2015/texmf-dist/doc/man:$MANPATH
export INFOPATH=/opt/texlive/2015/texmf-dist/doc/info:$INFOPATH
