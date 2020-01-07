# git status variables
ZSH_THEME_GIT_PROMPT_PREFIX=" %{$reset_color%}-> %{$fg[magenta]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX=""
ZSH_THEME_GIT_PROMPT_DIRTY=""
ZSH_THEME_GIT_PROMPT_CLEAN=""
ZSH_THEME_GIT_PROMPT_ADDED="%{$fg_bold[cyan]%} +"
ZSH_THEME_GIT_PROMPT_MODIFIED="%{$fg_bold[yellow]%} !"
ZSH_THEME_GIT_PROMPT_DELETED="%{$fg_bold[red]%} —"
ZSH_THEME_GIT_PROMPT_RENAMED="%{$fg_bold[green]%} »"
ZSH_THEME_GIT_PROMPT_UNMERGED="%{$fg_bold[white]%} #"
ZSH_THEME_GIT_PROMPT_UNTRACKED="%{$fg_bold[blue]%} ?"
ZSH_THEME_GIT_PROMPT_STASHED="%{$fg_bold[yellow]%} $"
ZSH_THEME_GIT_PROMPT_BEHIND="%{$fg_bold[blue]%} •|"
ZSH_THEME_GIT_PROMPT_AHEAD="%{$fg_bold[blue]%} |•"

# git status display
local git_info='$(git_prompt_info) $(git_prompt_status)%{$reset_color%}'

# default: blue, if return code other than 0: red
local prompt='%(?,%{$fg[blue]%}> ,%{$fg[red]%}> )'

# current directory display
local directory_path='%{$fg[magenta]%}%c'

# left prompt definition
PROMPT="${prompt}"

# right prompt definition
RPROMPT="${directory_path}"
RPROMPT+="${git_info}"

# prompt cursor fix when exiting vim
_fix_cursor() {
  echo -ne "\e[3 q"
}
precmd_functions+=(_fix_cursor)
