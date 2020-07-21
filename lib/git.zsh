_git_home() {
  local current_directory="$1"
  local git_toplevel="$2"
  local git_home=""
  if [ "$git_toplevel" != "" -a "$git_toplevel" != "$current_directory" ]; then
    local repo_name=`basename $git_toplevel`
    git_home="$repo_name"
  fi;
  if [ "$git_home" != "" ]; then
    # check how many directories are between
    local current_nesting="${current_directory//[^\/]}"
    local repo_nesting="${git_toplevel//[^\/]}"
    local diff=`expr ${#current_nesting} - ${#repo_nesting}`
    if [ $diff -eq 1 ]; then
      echo "$git_home/"
    else
      echo "$git_home/.../"
    fi;
  else
    echo ""
  fi;
}

_git_branch() {
  echo "$(command git symbolic-ref --short -q HEAD)"
}

_git_status() {
  local STATUS=$(command git status --porcelain -b 2> /dev/null)

  local git_status=""

  # rebasing
  if $(command grep "^## HEAD (no branch)" <<< "$STATUS" &> /dev/null); then
    git_status="%F{magenta}rebasing"
  else
    # staged changes
    if $(command grep "^A  " <<< "$STATUS" &> /dev/null) ||
      $(command grep "^M  " <<< "$STATUS" &> /dev/null) ||
      $(command grep "^D  " <<< "$STATUS" &> /dev/null); then
          git_status+=" %F{green}+"
    fi

    # new file
    if $(command grep "?? " <<< "$STATUS" &> /dev/null); then
      git_status+=" %F{blue}?"
    fi

    # modified
    if $(command grep "^ M " <<< "$STATUS" &> /dev/null); then
      git_status+=" %F{yellow}!"
    fi

    # renamed
    if $(command grep "^R  " <<< "$STATUS" &> /dev/null); then
      git_status+=" %F{cyan}»"
    fi

    # deleted
    if $(command grep "^ D " <<< "$STATUS" &> /dev/null); then
      git_status+=" %F{red}—"
    fi

    # unmerged
    if $(command grep "^UU " <<< "$STATUS" &> /dev/null); then
      git_status+=" %F{default}#"
    fi

    local is_ahead=false
    if $(command grep "^## .*ahead" <<< "$STATUS" &> /dev/null); then
      is_ahead=true
    fi

    local is_behind=false
    if $(command grep "^## .*behind" <<< "$STATUS" &> /dev/null); then
      is_behind=true
    fi

    if [[ "$is_ahead" == true && "$is_behind" == true ]]; then
      # diverged
      git_status+=" %F{blue}~"
    elif [[ "$is_ahead" == true ]]; then
      git_status+=" %F{blue}|•"
    elif [[ "$is_behind" == true ]]; then
      git_status+=" %F{blue}•|"
    fi

    # stashed
    local stash_count=`git stash list | wc -l`
    if [[ $stash_count -gt 0 ]]; then
      git_status+=" %F{yellow}$"
    fi
  fi

  echo "$git_status"
}
