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
- Cursor customization
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

Set ``ZSH_THEME="typewritten"`` in your ``.zshrc``.

## Cursor option
Default cursor is ``underscore``, but there is two more options: ``beam`` and ``block``.
They are both configured by adding the `TYPEWRITTEN_CURSOR` zsh variable to your ``.zshrc``:
```shell
export TYPEWRITTEN_CURSOR="beam"
```

## Singleline verbose option
To change the left prompt from:
```
shell
>
```

to
```
shell
user@host >
```
add this option to your `.zshrc`:
```shell
export TYPEWRITTEN_SINGLELINE_VERBOSE=true
```


## Multiline option
Multiline is now supported thanks to [@thbe](https://github.com/thbe). Add this option to your ``.zshrc``:
```shell
export TYPEWRITTEN_MULTILINE=true
```

## Screenshots
Multiline
<img src="https://raw.githubusercontent.com/reobin/typewritten/master/media/multiline.png" alt="multiline" />

Return code
<img src="https://raw.githubusercontent.com/reobin/typewritten/master/media/return_code.png" alt="return code" />
