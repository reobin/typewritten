# ``>_`` typewritten - a minimal, informative zsh prompt theme

Leaves all the room for what's important.
<img align="center" src="https://raw.githubusercontent.com/reobin/typewritten/master/media/demo.gif" alt="video" />

> Terminal is [iTerm2](https://iterm2.com/) — Font is [FiraCode](https://github.com/tonsky/FiraCode) — Terminal theme is [SpaceCamp](https://github.com/reobin/spacecamp-iterm)

## Features
- Current directory
- Current git branch
- Git status indicators:
  - ``?``     &nbsp; — untracked change(s);
  - ``+``     &nbsp; — staged change(s);
  - ``!``     &nbsp; — file(s) modified in the repo;
  - ``»``     &nbsp; — renamed file(s);
  - ``—``     &nbsp; — deleted file(s);
  - ``$``     &nbsp; — stashed change(s);
  - ``#``     &nbsp; — unmerged change(s);
  - ``•|``    — behind of remote branch;
  - ``|•``    — ahead of remote branch;
- Prompt color changes to red when an error return code is\
returned and code is displayed on the right
- Multiline support
- Prompt cursor fix when exiting vim

## Installation
Clone the repository into your custom oh-my-zsh themes directory:
```shell
$ git clone https://github.com/reobin/typewritten.git $ZSH_CUSTOM/themes/typewritten
```

Symlink ``typewritten.zsh-theme`` to your oh-my-zsh custom themes directory:
```shell
ln -s "$ZSH_CUSTOM/themes/typewritten/typewritten.zsh-theme" "$ZSH_CUSTOM/themes/typewritten.zsh-theme"
```

Set ``ZSH_THEME="typewritten/typewritten"`` in your ``.zshrc``.

## Multiline option
Multiline is now supported thanms to [@thbe](https://github.com/thbe). Add this option to your ``.zshrc``:
```shell
TYPEWRITTEN_MULTILINE=true
```
