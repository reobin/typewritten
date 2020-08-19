# git status indicators

When the current git repository is "dirty", a symbol indicating what the changes are is displayed.

- `?` &nbsp; — untracked change(s);
- `+` &nbsp; — staged change(s);
- `!` &nbsp; — file(s) modified in the repo;
- `»` &nbsp; — renamed file(s);
- `—` &nbsp; — deleted file(s);
- `$` &nbsp; — stashed change(s);
- `#` &nbsp; — unmerged change(s);
- `•|` &nbsp; — behind of remote branch;
- `|•` &nbsp; — ahead of remote branch;
- `~` &nbsp; — Branches have diverged;

Git status can be disabled by setting the `git config` value in a repo or globally like so:

```bash
git config --add oh-my-zsh.hide-status 1
```
