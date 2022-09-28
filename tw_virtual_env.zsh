if [[ -z $VIRTUAL_ENV_DISABLE_PROMPT ]]; then
  local tw_virtual_env=""
  if [[ ! -z $VIRTUAL_ENV ]]; then
    tw_virtual_env="$VIRTUAL_ENV"
  elif [[ ! -z $CONDA_PREFIX ]]; then
    tw_virtual_env="$CONDA_PREFIX"
  fi;

  if [[ $tw_virtual_env != "" ]]; then
    echo "($(basename $tw_virtual_env))"
  fi;
fi;
