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

source "$TYPEWRITTEN_ROOT/lib/colors.zsh"
source "$TYPEWRITTEN_ROOT/lib/git.zsh"

BREAK_LINE="
"

_right_prompt_prefix="%F{$colors[right_prompt_prefix]}$TYPEWRITTEN_RIGHT_PROMPT_PREFIX"

local _prompt_symbol="❯"
if [ ! -z "$TYPEWRITTEN_SYMBOL" ]; then
  _prompt_symbol="$TYPEWRITTEN_SYMBOL"
fi;

local _prompt_color="%(?,%F{$colors[symbol]},%F{$colors[error_code]})"
local _return_code="%(?,,%F{$colors[symbol_error]}%? )"
if [ "$TYPEWRITTEN_DISABLE_RETURN_CODE" = true ]; then
  _prompt_color="%F{$colors[prompt]}"
  _return_code=""
fi;

_user_host="%F{$colors[host]}%n%F{$colors[host_user_connector]}@%F{$colors[user]}%m"
_prompt="$_prompt_color$_return_code$_prompt_symbol %F{$colors[prompt]}"

_current_directory_color="$colors[current_directory]"
_git_branch_color="$colors[git_branch]"

_current_directory="%F{$_current_directory_color}%c"
_verbose_current_directory="%F{$_current_directory_color]}%~"
_arrow="%F{$colors[arrow]}->"

_redraw() {
  local _virtualenv=""
  if [[ ! -z $VIRTUAL_ENV ]] && [[ -z $VIRTUAL_ENV_DISABLE_PROMPT ]]; then
    _virtualenv="%F{$colors[virtualenv]}($(basename $VIRTUAL_ENV)) "
  fi;

  _env_prompt="$_virtualenv$_prompt"

  _layout="$TYPEWRITTEN_PROMPT_LAYOUT"
  _git_info="$prompt_data[_git_branch]$prompt_data[_git_status]"
  if [ "$_layout" = "half_pure" ]; then
    PROMPT="$BREAK_LINE%F{$_git_branch_color}$_git_info$BREAK_LINE$_env_prompt"
    RPROMPT="$_right_prompt_prefix%F{$_current_directory_color}$prompt_data[_git_home]$_current_directory"
  else
    local _git_arrow_info=""
    if [ "$_git_info" != "" ]; then
      _git_arrow_info=" $_arrow %F{$_git_branch_color}$_git_info"
    fi;
    if [ "$_layout" = "pure" ]; then
      PROMPT="$BREAK_LINE$_verbose_current_directory$_git_arrow_info$BREAK_LINE$_env_prompt"
      RPROMPT=""
    else
      if [ "$_layout" = "singleline_verbose" ]; then
        PROMPT="$_user_host $_env_prompt"
      elif [ "$_layout" = "multiline" ]; then
        PROMPT="$BREAK_LINE$_user_host$BREAK_LINE$_env_prompt"
      else
        PROMPT="$_env_prompt"
      fi;
      RPROMPT="$_right_prompt_prefix%F{$_current_directory_color}$prompt_data[_git_home]$_current_directory$_git_arrow_info"
    fi;
  fi;

  zle && zle .reset-prompt
}

_async_init_worker() {
  async_start_worker _worker -n
  async_register_callback _worker _prompt_callback
}

_prompt_callback() {
  local name=$1 code=$2 output=$3
  if (( code == 2 )) || (( code == 3 )) || (( code == 130 )); then
    # reinit async workers and colors
    async_stop_worker _worker
    _async_init_worker
    _async_init_tasks
    _setup_color_mappings
    _setup_colors
  elif (( code )); then
    _async_init_tasks
  fi;
  prompt_data[$name]=$output
  _redraw
}

_async_init_tasks() {
  typeset -Ag prompt_data

  local _current_pwd="$PWD"
  async_worker_eval _worker builtin cd -q $_current_pwd

  local _git_hide_status="$(git config --get oh-my-zsh.hide-status 2>/dev/null)"
  if [[ "$_git_hide_status" != "1" ]]; then
    local _git_toplevel="$(git rev-parse --show-toplevel 2>/dev/null)"
    if [[ "$_git_toplevel" != $prompt_data[_git_toplevel] ]]; then
      async_flush_jobs _worker
      prompt_data[_git_branch]=
      prompt_data[_git_status]=
    fi;

    if [[ "$_current_pwd" != $prompt_data[_current_pwd] ]]; then
      async_flush_jobs _worker
      prompt_data[_git_home]=
    fi;

    prompt_data[_git_toplevel]="$_git_toplevel"
    prompt_data[_current_pwd]="$_current_pwd"
    if [[ "$TYPEWRITTEN_GIT_RELATIVE_PATH" != false ]]; then
      async_job _worker _git_home $_current_pwd $_git_toplevel
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

_setup() {
  _async_init_worker
  _async_init_tasks

  zmodload zsh/zle
  autoload -Uz add-zsh-hook
  add-zsh-hook precmd _fix_cursor
  add-zsh-hook precmd _async_init_tasks

  PROMPT="$_prompt"
}

_setup
zle_highlight=( default:fg=$colors[prompt] )
