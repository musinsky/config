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

ROOTSYS=/cern/root
check_mucha PATH $ROOTSYS/bin
check_mucha LD_LIBRARY_PATH $ROOTSYS/lib
check_mucha PYTHONPATH $ROOTSYS/lib
check_mucha CMAKE_PREFIX_PATH $ROOTSYS

check_mucha PATH /cern/xrootd/bin
check_mucha LD_LIBRARY_PATH /cern/xrootd/lib64

check_mucha PATH /opt/texlive/2017/bin/x86_64-linux

# MAN and INFO are added automatically
export ROOTSYS PATH LD_LIBRARY_PATH PYTHONPATH CMAKE_PREFIX_PATH
alias root='root -l'

unset varvalue
