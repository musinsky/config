# 2026-09-28
# https://github.com/musinsky/config/blob/master/bash/muke-profile.sh

# export MUKE_PROFILE_VERBOSE=1 # enable verbose output

__muke_var_value_export() {
  [[ "${MUKE_PROFILE_VERBOSE}" == 1 ]] && {
    printf "var_name         = '%s'\n" "${1}"
    printf "var_value        = '%s'\n" "${!1}"
    printf "var_value_append = '%s'\n" "${2}"
  }
  # Note: value referenced by ${!1} may change during function execution

  if [[ -z "${!1}" ]]; then
    declare -gx "${1}"="${2}"
    [[ "${MUKE_PROFILE_VERBOSE}" == 1 ]] && {
      printf "variable '%s' is unset or empty\n" "${1}"
      printf "=> variable '%s' set to value '%s' (and exported)\n" "${1}" "${2}"
    }
  elif [[ "${!1}" != *"${2}"* ]]; then
    declare -gx "${1}"="${!1}:${2}"
    [[ "${MUKE_PROFILE_VERBOSE}" == 1 ]] && {
      printf "variable '%s' exists but does not contain value '%s'\n" "${1}" "${2}"
      printf "=> value '%s' appended to variable '%s' (and exported)\n" "${2}" "${1}"
    }
  else
    [[ "${MUKE_PROFILE_VERBOSE}" == 1 ]] && {
      printf "variable '%s' exists and already contains value '%s'\n" "${1}" "${2}"
      printf "=> no changes\n"
    }
  fi

  [[ "${MUKE_PROFILE_VERBOSE}" == 1 ]] && {
    printf "===> '%s' = '%s'\n\n" "${1}" "${!1}"
  }
}

PREFIX_PATH="/opt/root"
[[ -d "${PREFIX_PATH}" ]] && {
  # __muke_var_value_export ROOTSYS "${PREFIX_PATH}"
  __muke_var_value_export PATH "${PREFIX_PATH}/bin"
  __muke_var_value_export LD_LIBRARY_PATH "${PREFIX_PATH}/lib"
  __muke_var_value_export CMAKE_PREFIX_PATH "${PREFIX_PATH}"
  [[ -d "${PREFIX_PATH}/lib/cppyy" ]] && { # root-config --has-pyroot
    __muke_var_value_export PYTHONPATH "${PREFIX_PATH}/lib"
    __muke_var_value_export JUPYTER_PATH "${PREFIX_PATH}/etc/notebook"
    __muke_var_value_export JUPYTER_CONFIG_PATH "${PREFIX_PATH}/etc/notebook"
  }
}

PREFIX_PATH="/opt/xrootd"
[[ -d "${PREFIX_PATH}" ]] && {
  __muke_var_value_export PATH "${PREFIX_PATH}/bin"
  __muke_var_value_export LD_LIBRARY_PATH "${PREFIX_PATH}/lib64"
}

PREFIX_PATH="/opt/texlive/2026"
[[ -d "${PREFIX_PATH}" ]] && {
  __muke_var_value_export PATH "${PREFIX_PATH}/bin/x86_64-linux"
}

# man and info paths are automatically determined by the programs
unset PREFIX_PATH
