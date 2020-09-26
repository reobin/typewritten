tw_git_home() {
  local tw_current_directory="$1"
  local tw_git_toplevel="$2"
  local tw_git_home=""
  if [ "$tw_git_toplevel" != "" -a "$tw_git_toplevel" != "$tw_current_directory" ]; then
    local tw_repo_name=`basename $tw_git_toplevel`
    tw_git_home="$tw_repo_name"
  fi;
  if [ "$tw_git_home" != "" ]; then
    # check how many directories are between
    local tw_current_nesting="${tw_current_directory//[^\/]}"
    local tw_repo_nesting="${tw_git_toplevel//[^\/]}"
    local tw_diff=`expr ${#tw_current_nesting} - ${#tw_repo_nesting}`
    if [ $tw_diff -eq 1 ]; then
      echo "$tw_git_home/"
    else
      echo "$tw_git_home/.../"
    fi;
  else
    echo ""
  fi;
}

tw_git_branch() {
  echo "$(command git symbolic-ref --short -q HEAD)"
}

tw_git_status() {
  local tw_git_status_response=$(command git status --porcelain -b 2> /dev/null)

  local tw_git_status_display=""

  # rebasing
  if $(command grep "^## HEAD (no branch)" <<< "$tw_git_status_response" &> /dev/null); then
    tw_git_status_display="%F{$tw_colors[git_rebasing]}rebasing"
  else
    # staged changes
    if $(command grep "^A. " <<< "$tw_git_status_response" &> /dev/null) ||
      $(command grep "^M. " <<< "$tw_git_status_response" &> /dev/null) ||
      $(command grep "^D. " <<< "$tw_git_status_response" &> /dev/null); then
          tw_git_status_display+=" %F{$tw_colors[git_status_staged]}+"
    fi

    # new file
    if $(command grep "?? " <<< "$tw_git_status_response" &> /dev/null); then
      tw_git_status_display+=" %F{$tw_colors[git_status_new]}?"
    fi

    # modified
    if $(command grep "^.M " <<< "$tw_git_status_response" &> /dev/null); then
      tw_git_status_display+=" %F{$tw_colors[git_status_modified]}!"
    fi

    # renamed
    if $(command grep "^R. " <<< "$tw_git_status_response" &> /dev/null); then
      tw_git_status_display+=" %F{$tw_colors[git_status_renamed]}»"
    fi

    # deleted
    if $(command grep "^.D " <<< "$tw_git_status_response" &> /dev/null); then
      tw_git_status_display+=" %F{$tw_colors[git_status_deleted]}—"
    fi

    # unmerged
    if $(command grep "^UU " <<< "$tw_git_status_response" &> /dev/null); then
      tw_git_status_display+=" %F{$tw_colors[git_status_unmerged]}#"
    fi

    local tw_is_ahead=false
    if $(command grep "^## .*ahead" <<< "$tw_git_status_response" &> /dev/null); then
      tw_is_ahead=true
    fi

    local tw_is_behind=false
    if $(command grep "^## .*behind" <<< "$tw_git_status_response" &> /dev/null); then
      tw_is_behind=true
    fi

    if [[ "$tw_is_ahead" == true && "$tw_is_behind" == true ]]; then
      # diverged
      tw_git_status_display+=" %F{$tw_colors[git_status_diverged]}~"
    elif [[ "$tw_is_ahead" == true ]]; then
      tw_git_status_display+=" %F{$tw_colors[git_status_ahead]}|•"
    elif [[ "$tw_is_behind" == true ]]; then
      tw_git_status_display+=" %F{$tw_colors[git_status_behind]}•|"
    fi

    # stashed
    local tw_stash_count=`git stash list | wc -l`
    if [[ $tw_stash_count -gt 0 ]]; then
      tw_git_status_display+=" %F{$tw_colors[git_status_stash]}$"
    fi
  fi

  echo "$tw_git_status_display"
}
