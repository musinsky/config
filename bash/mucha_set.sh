# https://github.com/musinsky/config/blob/master/bash/mucha_set.sh

check_mucha () {
    varvalue=${!1}

    if [ -z "$varvalue" ]; then
        # echo "Create variable with value"
        declare -g $1=$2
    elif [[ $varvalue != *$2* ]]; then
        # echo "Append value to exist variable"
        declare -g $1=$varvalue:$2
    else
        # echo "Variable already contains value"
        return
    fi
}

# https://sft.its.cern.ch/jira/browse/ROOT-9309
# it's better to never set ROOTSYS, LD_LIBRARY_PATH and never source thisroot.sh
#   ROOTSYS=/cern/root
#   check_mucha PATH $ROOTSYS/bin
#   check_mucha LD_LIBRARY_PATH $ROOTSYS/lib
#   check_mucha CMAKE_PREFIX_PATH $ROOTSYS

ROOTPREFIX=/cern/root
check_mucha PATH $ROOTPREFIX/bin
check_mucha PYTHONPATH $ROOTPREFIX/lib
check_mucha JUPYTER_PATH $ROOTPREFIX/etc/notebook

check_mucha PATH /cern/xrootd/bin
check_mucha LD_LIBRARY_PATH /cern/xrootd/lib64

check_mucha PATH /opt/texlive/2021/bin/x86_64-linux

# MAN and INFO are added automatically
export PATH LD_LIBRARY_PATH PYTHONPATH JUPYTER_PATH

unset varvalue
