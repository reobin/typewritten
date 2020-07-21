#      ____ ____ ____ ____ ____ ____ ____ ____ ____ ____ ____
#     ||t |||y |||p |||e |||w |||r |||i |||t |||t |||e |||n ||
#     ||__|||__|||__|||__|||__|||__|||__|||__|||__|||__|||__||
#     |/__\|/__\|/__\|/__\|/__\|/__\|/__\|/__\|/__\|/__\|/__\|
#
#             A minimal, informative zsh prompt theme
#

export TYPEWRITTEN_ROOT=${${(%):-%x}:A:h}
source "$TYPEWRITTEN_ROOT/lib/git.zsh"

BREAK_LINE="
"

_set_left_prompt() {
  local display_git=$1

  local prompt_color="%(?,%F{blue},%F{red})"

  local prompt_symbol=">"
  if [ ! -z "$TYPEWRITTEN_SYMBOL" ]; then
    prompt_symbol="$TYPEWRITTEN_SYMBOL"
  fi

  local virtualenv=""
  if [[ -n $VIRTUAL_ENV ]] && [[ -z $VIRTUAL_ENV_DISABLE_PROMPT ]]; then
    virtualenv="%F{default}($(basename $VIRTUAL_ENV)) "
	fi

  local return_code="%(?,,%F{red}%? )"
  if [ "$TYPEWRITTEN_DISABLE_RETURN_CODE" = true ]; then
    return_code=""
    prompt_color="%F{blue}"
  fi

  local typewritten_prompt="$virtualenv$return_code$prompt_color$prompt_symbol %F{default}"
  local user_host="%F{yellow}%n%F{default}@%F{yellow}%m "

  if [ "$TYPEWRITTEN_PROMPT_LAYOUT" = "singleline" ]; then
    PROMPT="$typewritten_prompt"
  elif [ "$TYPEWRITTEN_PROMPT_LAYOUT" = "singleline_verbose" ]; then
    PROMPT="$user_host$typewritten_prompt"
  elif [ "$TYPEWRITTEN_PROMPT_LAYOUT" = "multiline" ]; then
    PROMPT="$user_host$BREAK_LINE$typewritten_prompt"
  elif [ "$TYPEWRITTEN_PROMPT_LAYOUT" = "half_pure" ]; then
    if [[ $display_git == true ]]; then
      PROMPT="$BREAK_LINE$(typewritten_git_info_display)$BREAK_LINE$typewritten_prompt"
    else
      PROMPT="$BREAK_LINE$typewritten_prompt"
    fi
  elif [ "$TYPEWRITTEN_PROMPT_LAYOUT" = "pure" ]; then
    local directory_path="%~"
    if [[ $display_git == true ]]; then
      PROMPT="$BREAK_LINE%F{magenta}$directory_path %F{default}-> $(typewritten_git_info_display)$BREAK_LINE$typewritten_prompt"
    else
      PROMPT="$BREAK_LINE%F{magenta}$directory_path$BREAK_LINE$typewritten_prompt"
    fi
  else
    PROMPT="$typewritten_prompt"
  fi
}

_set_right_prompt() {
  local display_git=$1
  local is_git_info_on_left=$2

  local directory_path="%c"
  local right_prompt_prefix="%F{default}"
  if [ ! -z "$TYPEWRITTEN_RIGHT_PROMPT_PREFIX" ]; then
    right_prompt_prefix+="$TYPEWRITTEN_RIGHT_PROMPT_PREFIX"
  fi
  RPROMPT="$right_prompt_prefix"

  local git_home_display=""
  local git_branch=""
  local git_status=""

  if [[ $display_git == true ]]; then
    if [ "$TYPEWRITTEN_GIT_RELATIVE_PATH" != false ]; then
      git_home_display="$(typewritten_git_home_display)"
    fi
    RPROMPT+="%F{magenta}$git_home_display$directory_path"
    if [[ $is_git_info_on_left == false ]]; then
      RPROMPT+=" %F{default}-> $(typewritten_git_info_display)"
    fi
  else
    RPROMPT+="%F{magenta}$directory_path"
  fi
}

_prompt() {
  git_hide_status="$(git config --get oh-my-zsh.hide-status 2>/dev/null)"

  display_git=false
  is_git_info_on_left=false
  if [[ "$git_hide_status" != "1" ]] && [[ $(typewritten_is_git_repository) == true ]]; then
    display_git=true
    if [[ "$TYPEWRITTEN_PROMPT_LAYOUT" == "pure" ]] || [[ "$TYPEWRITTEN_PROMPT_LAYOUT" == "half_pure" ]]; then
      is_git_info_on_left=true
    fi
  fi

  _set_left_prompt $display_git
  if [[ "$TYPEWRITTEN_PROMPT_LAYOUT" != "pure" ]]; then
    _set_right_prompt $display_git $is_git_info_on_left
  fi
}

# prompt cursor fix when exiting vim
_fix_cursor() {
  local cursor="\e[3 q"
  if [ "$TYPEWRITTEN_CURSOR" = "block" ]; then
    cursor="\e[1 q"
  elif [ "$TYPEWRITTEN_CURSOR" = "beam" ]; then
    cursor="\e[5 q"
  fi
  echo -ne "$cursor"
}

autoload -U add-zsh-hook
add-zsh-hook precmd _fix_cursor
add-zsh-hook precmd _prompt

zle_highlight=( default:fg=default )
