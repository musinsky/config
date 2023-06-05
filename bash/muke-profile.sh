# 2023-06-05
# https://github.com/musinsky/config/blob/master/bash/muke-profile.sh

function __muke_var_value {
    local var_value="${!1}"
    # printf "var_name         = %s\n" "$1"
    # printf "var_value        = %s\n" "$var_value"
    # printf "var_value_append = %s\n" "$2"

    if [[ -z "$var_value" ]]; then
        declare -g "$1"="$2"
        # printf "# created variable with value\n"
    elif [[ "$var_value" != *"$2"* ]]; then
        declare -g "$1"="$var_value:$2"
        # printf "# appended value to exist variable\n"
    else
        # printf "# variable exist and already contains value\n"
        return
    fi
}

# https://sft.its.cern.ch/jira/browse/ROOT-9309
# it's better to never set ROOTSYS, LD_LIBRARY_PATH and never source thisroot.sh
#   ROOTSYS='/cern/root'
#   __muke_var_value PATH "$ROOTSYS/bin"
#   __muke_var_value LD_LIBRARY_PATH "$ROOTSYS/lib"
#   __muke_var_value CMAKE_PREFIX_PATH "$ROOTSYS"

ROOT_PATH='/cern/root'
__muke_var_value PATH         "$ROOT_PATH/bin"
__muke_var_value PYTHONPATH   "$ROOT_PATH/lib"
__muke_var_value JUPYTER_PATH "$ROOT_PATH/etc/notebook"

__muke_var_value PATH            '/cern/xrootd/bin'
__muke_var_value LD_LIBRARY_PATH '/cern/xrootd/lib64'

__muke_var_value PATH '/opt/texlive/2023/bin/x86_64-linux'

# MAN and INFO are added automatically
export PATH LD_LIBRARY_PATH PYTHONPATH JUPYTER_PATH

unset ROOT_PATH
