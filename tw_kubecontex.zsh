if command -v kubectl > /dev/null; then
  tw_kube_context="$(kubectl config current-context 2&>1 /dev/null)"

  if [[ $tw_kube_context != "" ]]; then
    echo "($(basename $tw_kube_context))"
  fi
fi
