#!/usr/bin/env zsh

#      ____ ____ ____ ____ ____ ____ ____ ____ ____ ____ ____
#     ||t |||y |||p |||e |||w |||r |||i |||t |||t |||e |||n ||
#     ||__|||__|||__|||__|||__|||__|||__|||__|||__|||__|||__||
#     |/__\|/__\|/__\|/__\|/__\|/__\|/__\|/__\|/__\|/__\|/__\|
#
#             A minimal, informative zsh prompt theme
#

export TYPEWRITTEN_ROOT=${${(%):-%x}:A:h}

source "$TYPEWRITTEN_ROOT/async.zsh"
async_init

source "$TYPEWRITTEN_ROOT/lib/git.zsh"

typeset -Ag prompt_data

BREAK_LINE="
"

_right_prompt_prefix="%F{default}$TYPEWRITTEN_RIGHT_PROMPT_PREFIX"

local _prompt_symbol="❯"
if [ ! -z "$TYPEWRITTEN_SYMBOL" ]; then
  _prompt_symbol="$TYPEWRITTEN_SYMBOL"
fi;

local _prompt_color="%(?,%F{blue},%F{red})"
local _return_code="%(?,,%F{red}%? )"
if [ "$TYPEWRITTEN_DISABLE_RETURN_CODE" = true ]; then
  _prompt_color="%F{blue}"
  _return_code=""
fi

_user_host="%F{yellow}%n%F{default}@%F{yellow}%m"
_prompt="$_prompt_color$_return_code$_prompt_symbol %F{default}"

_redraw() {
  local _virtualenv=""
  if [[ ! -z $VIRTUAL_ENV ]] && [[ -z $VIRTUAL_ENV_DISABLE_PROMPT ]]; then
    _virtualenv="%F{default}($(basename $VIRTUAL_ENV)) "
  fi;

  _env_prompt="$_virtualenv$_prompt"

  _layout="$TYPEWRITTEN_PROMPT_LAYOUT"
  if [ "$_layout" = "half_pure" ]; then
    PROMPT="$BREAK_LINE%F{magenta}$prompt_data[_git_info]$BREAK_LINE$_env_prompt"
    RPROMPT="$_right_prompt_prefix%F{magenta}$prompt_data[_git_home]%c"
  elif [ "$_layout" = "pure" ]; then
    local _git_info=""
    if [ "$prompt_data[_git_info]" != "" ]; then
      _git_info=" %F{default}-> %F{magenta}$prompt_data[_git_info]"
    fi;
    PROMPT="$BREAK_LINE%F{magenta}%~%F{magenta}$_git_info$BREAK_LINE$_env_prompt"
    RPROMPT=""
  else
    local _git_info=""
    if [ "$prompt_data[_git_info]" != "" ]; then
      _git_info=" %F{default}-> %F{magenta}$prompt_data[_git_info]"
    fi;
    if [ "$_layout" = "singleline_verbose" ]; then
      PROMPT="$_user_host $_env_prompt"
    elif [ "$_layout" = "multiline" ]; then
      PROMPT="$BREAK_LINE$_user_host$BREAK_LINE$_env_prompt"
    else
      PROMPT="$_env_prompt"
    fi;
    RPROMPT="$_right_prompt_prefix%F{magenta}$prompt_data[_git_home]%c$_git_info"
  fi;

  zle && zle .reset-prompt
}

_prompt_callback() {
  local name=$1 output=$3
  prompt_data[$name]=$output
  _redraw
}

async_start_worker _worker -n
async_register_callback _worker _prompt_callback

_prompt_precmd() {
  _git_hide_status="$(git config --get oh-my-zsh.hide-status 2>/dev/null)"

  if [[ "$_git_hide_status" != "1" ]]; then
    if [[ "$TYPEWRITTEN_GIT_RELATIVE_PATH" != false ]]; then
      async_job _worker _git_home $PWD
    fi;
    async_job _worker _git_info $PWD
  fi;
}

# prompt cursor fix when exiting vim
_fix_cursor() {
  local cursor="\e[3 q"
  if [ "$TYPEWRITTEN_CURSOR" = "block" ]; then
    cursor="\e[1 q"
  elif [ "$TYPEWRITTEN_CURSOR" = "beam" ]; then
    cursor="\e[5 q"
  fi;
  echo -ne "$cursor"
}

zmodload zsh/zle
autoload -Uz add-zsh-hook
add-zsh-hook precmd _fix_cursor
add-zsh-hook precmd _prompt_precmd

PROMPT="$_prompt"
RPROMPT="$_right_prompt_prefix%F{magenta}%c"

zle_highlight=( default:fg=default )
