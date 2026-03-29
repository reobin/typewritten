#!/usr/bin/env zsh

emulate -LR zsh
setopt err_return pipe_fail

ROOT=${0:A:h:h}

trap 'print -u2 -- "ERR at line $LINENO"; exit 1;' ERR ZERR

typeset -g TESTS_PASSED=0

fail() {
  print -u2 -- "FAIL: $1"
  exit 1
}

assert_eq() {
  local expected="$1"
  local actual="$2"
  local message="$3"

  if [[ "$expected" != "$actual" ]]; then
    fail "$message\nexpected: $expected\nactual:   $actual"
  fi

  TESTS_PASSED=$(( TESTS_PASSED + 1 ))
}

assert_contains() {
  local haystack="$1"
  local needle="$2"
  local message="$3"

  if [[ "$haystack" != *"$needle"* ]]; then
    fail "$message\nmissing:  $needle\nin:       $haystack"
  fi

  TESTS_PASSED=$(( TESTS_PASSED + 1 ))
}

reset_env() {
  unset TYPEWRITTEN_COLOR_MAPPINGS TYPEWRITTEN_COLORS
  unset tw_colors tw_color_mappings
}

test_color_mappings() {
  reset_env
  export TYPEWRITTEN_COLOR_MAPPINGS="primary:red;secondary:blue;accent:cyan"
  export TYPEWRITTEN_COLORS="prompt:green;git_status_new:magenta"
  source "$ROOT/lib/colors.zsh"

  assert_eq "red" "$tw_colors[current_directory]" "current directory color follows semantic mapping"
  assert_eq "green" "$tw_colors[prompt]" "direct color overrides prompt color"
  assert_eq "magenta" "$tw_colors[git_status_new]" "direct color overrides git status color"
}

test_git_status_signals() {
  local repo
  repo=$(mktemp -d "${TMPDIR:-/tmp}/typewritten-smoke.XXXXXX")

  git init -q -b main "$repo" || fail "git init failed"
  git -C "$repo" config user.name "Typewritten Tests" || fail "git config user.name failed"
  git -C "$repo" config user.email "tests@example.com" || fail "git config user.email failed"

  print -r -- "tracked" > "$repo/tracked.txt"
  git -C "$repo" add tracked.txt || fail "git add tracked.txt failed"
  git -C "$repo" commit -qm "initial" || fail "git initial commit failed"

  print -r -- "tracked again" > "$repo/tracked.txt"
  git -C "$repo" add tracked.txt || fail "git add modified tracked.txt failed"
  print -r -- "untracked" > "$repo/untracked.txt"
  git -C "$repo" stash push -qm "test stash" || fail "git stash failed"

  print -r -- "working tree change" > "$repo/tracked.txt"
  print -r -- "brand new" > "$repo/untracked.txt"

  pushd "$repo" >/dev/null || fail "pushd failed"
  source "$ROOT/lib/colors.zsh"
  source "$ROOT/lib/git.zsh"

  local branch git_status git_home
  branch=$(tw_git_branch)
  git_status=$(tw_git_status)
  git_home=$(tw_git_home "$repo/nested/child" "$repo")
  popd >/dev/null || fail "popd failed"

  assert_eq "main" "$branch" "branch name resolves in a fresh git repository"
  assert_contains "$git_status" "?" "git status includes untracked marker"
  assert_contains "$git_status" "!" "git status includes modified marker"
  assert_contains "$git_status" '$' "git status includes stash marker"
  assert_eq "${repo:t}/.../" "$git_home" "git home shortens deep repository paths"

  rm -rf "$repo"
}

test_zsh_syntax() {
  local file
  for file in \
    "$ROOT/typewritten.zsh" \
    "$ROOT/typewritten.plugin.zsh" \
    "$ROOT/typewritten.zsh-theme" \
    "$ROOT/prompt_typewritten_setup" \
    "$ROOT/async" \
    "$ROOT/async.zsh" \
    "$ROOT/lib/colors.zsh" \
    "$ROOT/lib/git.zsh" \
    "$ROOT/scripts/install.sh" \
    "$ROOT/scripts/uninstall.sh"
  do
    zsh -n "$file" || fail "zsh -n failed for $file"
    TESTS_PASSED=$(( TESTS_PASSED + 1 ))
  done
}

test_color_mappings
test_git_status_signals
test_zsh_syntax

print -- "Passed $TESTS_PASSED assertions"
