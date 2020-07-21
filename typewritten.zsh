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
fi;

_user_host="%F{yellow}%n%F{default}@%F{yellow}%m"
_prompt="$_prompt_color$_return_code$_prompt_symbol %F{default}"

_redraw() {
  local _virtualenv=""
  if [[ ! -z $VIRTUAL_ENV ]] && [[ -z $VIRTUAL_ENV_DISABLE_PROMPT ]]; then
    _virtualenv="%F{default}($(basename $VIRTUAL_ENV)) "
  fi;

  _env_prompt="$_virtualenv$_prompt"

  _layout="$TYPEWRITTEN_PROMPT_LAYOUT"
  _git_info="$prompt_data[_git_branch]$prompt_data[_git_status]"
  if [ "$_layout" = "half_pure" ]; then
    PROMPT="$BREAK_LINE%F{magenta}$_git_info$BREAK_LINE$_env_prompt"
    RPROMPT="$_right_prompt_prefix%F{magenta}$prompt_data[_git_home]%c"
  else
    local _git_arrow_info=""
    if [ "$_git_info" != "" ]; then
      _git_arrow_info=" %F{default}-> %F{magenta}$_git_info"
    fi;
    if [ "$_layout" = "pure" ]; then
      PROMPT="$BREAK_LINE%F{magenta}%~%F{magenta}$_git_arrow_info$BREAK_LINE$_env_prompt"
      RPROMPT=""
    else
      if [ "$_layout" = "singleline_verbose" ]; then
        PROMPT="$_user_host $_env_prompt"
      elif [ "$_layout" = "multiline" ]; then
        PROMPT="$BREAK_LINE$_user_host$BREAK_LINE$_env_prompt"
      else
        PROMPT="$_env_prompt"
      fi;
      RPROMPT="$_right_prompt_prefix%F{magenta}$prompt_data[_git_home]%c$_git_arrow_info"
    fi;
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
  typeset -Ag prompt_data

  local _current_directory="$PWD"
  async_worker_eval _worker builtin cd -q $_current_directory

  local _git_hide_status="$(git config --get oh-my-zsh.hide-status 2>/dev/null)"
  if [[ "$_git_hide_status" != "1" ]]; then
    local _git_toplevel="$(git rev-parse --show-toplevel 2>/dev/null)"
    if [[ "$_git_toplevel" != $prompt_data[_git_toplevel] ]]; then
      async_flush_jobs _worker
      prompt_data[_git_branch]=
      prompt_data[_git_status]=
    fi;

    if [[ "$_current_directory" != $prompt_data[_current_directory] ]]; then
      async_flush_jobs _worker
      prompt_data[_git_home]=
    fi;

    prompt_data[_git_toplevel]="$_git_toplevel"
    prompt_data[_current_directory]="$_current_directory"
    if [[ "$TYPEWRITTEN_GIT_RELATIVE_PATH" != false ]]; then
      async_job _worker _git_home $_current_directory $_git_toplevel
    fi;
    async_job _worker _git_branch
    async_job _worker _git_status
  else
    prompt_data[_git_branch]=
    prompt_data[_git_status]=
  fi;

  _redraw
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

zle_highlight=( default:fg=default )
