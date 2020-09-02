<p align="center">
  <img src="docs/_media/logo.svg" alt="typewritten" />
</p>

<h1 align="center">typewritten</h1>

<p align="center">A minimal <a href="https://www.zsh.org/">zsh</a> prompt</p>

<br />

<p align="center">
  <a href="https://github.com/reobin/typewritten/blob/master/LICENSE">
    <img src="https://img.shields.io/github/license/reobin/typewritten?style=flat-square" />
  </a>
  <a href="https://github.com/reobin/typewritten/releases">
    <img src="https://img.shields.io/github/v/release/reobin/typewritten?style=flat-square" />
  </a>
  <a href="https://npmjs.com/package/typewritten">
    <img src="https://img.shields.io/npm/dm/typewritten?style=flat-square&logo=npm" />
  </a>
</p>
<p align="center">
  <a href="https://github.com/reobin/typewritten/stargazers">
    <img src="https://img.shields.io/github/stars/reobin/typewritten?style=flat-square&logo=github" />
  </a>
  <a href="https://github.com/reobin/typewritten/network/members">
    <img src="https://img.shields.io/github/forks/reobin/typewritten?style=flat-square&logo=github" />
  </a>
  <a href="#contributors">
    <!-- ALL-CONTRIBUTORS-BADGE:START - Do not remove or modify this section -->
    <img src="https://img.shields.io/badge/all_contributors-18-orange.svg?style=flat-square" alt="All contributors" />
<!-- ALL-CONTRIBUTORS-BADGE:END -->
  </a>
</p>

<p align="center">
  <img src="docs/_media/typewritten.gif?raw=true" alt="typewritten zsh prompt demo" />
</p>

> Terminal is [iTerm2](https://iterm2.com/) — Font is [JetBrains Mono](https://www.jetbrains.com/lp/mono/) — Terminal theme is [Seoul256](https://github.com/junegunn/seoul256.vim)

## Features

- Asynchronous git info
- Fully customizable
  - [Colors for any of the prompt sections](https://typewritten.dev/#/prompt_color_customization)
  - [Prompt layout](https://typewritten.dev/#/prompt_customization?id=typewritten_prompt_layout)
  - [Prompt symbol](https://typewritten.dev/#/prompt_customization?id=typewritten_symbol)
  - [Constant display of git home directory](https://typewritten.dev/#/prompt_customization?id=typewritten_git_relative_path)
  - [Cursor](https://typewritten.dev/#/prompt_customization?id=typewritten_cursor)
  - [Prefix on right prompt](https://typewritten.dev/#/prompt_customization?id=typewritten_right_prompt_prefix)

## Quick start

### [npm](https://npmjs.com/get-npm)

```shell
npm install -g typewritten
```

That's it. The script will make the necessary symlinks to `fpath` and set the prompt in your `.zshrc`.

### Manual

Clone the typewritten repository somewhere you can easily link. I recommend creating a `.zsh` directory at root.

```shell
mkdir -p "$HOME/.zsh"
git clone https://github.com/reobin/typewritten.git "$HOME/.zsh/typewritten"
```

Load typewritten in your `.zshrc` by using zsh prompinit:

```shell
fpath+=$HOME/.zsh/typewritten
autoload -U promptinit; promptinit
prompt typewritten
```

### Other ways to install

Many other ways to install typewritten are available in the [docs](https://typewritten.dev/#/installation)

## Customization

typewritten is customizable in many ways. To keep the readme file as lean as possible, the documentation was moved to [https://typewritten.dev](https://typewritten.dev).

The documentation is separated into two parts:

- [Prompt customization](https://typewritten.dev/#/prompt_customization), everything to do with how and where the info is displayed
- [Prompt color customization](https://typewritten.dev/#/prompt_color_customization), set a custom color for any of the prompt sections

**Example of 3 customized typewritten prompts**

<p align="center">
  <img src="docs/_media/configuration_examples/bash.png" width="800" />
</p>
<p align="center">
  <img src="docs/_media/configuration_examples/pure.png" width="400" />
  <img src="docs/_media/configuration_examples/half_pure.png" width="400" />
</p>

## Contributors ✨

Thanks goes to these wonderful people ([emoji key](https://allcontributors.org/docs/en/emoji-key)):

<!-- ALL-CONTRIBUTORS-LIST:START - Do not remove or modify this section -->
<!-- prettier-ignore-start -->
<!-- markdownlint-disable -->
<table>
  <tr>
    <td align="center"><a href="https://github.com/reobin"><img src="https://avatars1.githubusercontent.com/u/5920450?v=4" width="100px;" alt=""/><br /><sub><b>Robin Gagnon</b></sub></a><br /><a href="https://github.com/reobin/typewritten/commits?author=reobin" title="Code">💻</a> <a href="#maintenance-reobin" title="Maintenance">🚧</a> <a href="https://github.com/reobin/typewritten/commits?author=reobin" title="Documentation">📖</a></td>
    <td align="center"><a href="https://www.thbe.org/"><img src="https://avatars3.githubusercontent.com/u/495530?v=4" width="100px;" alt=""/><br /><sub><b>thbe</b></sub></a><br /><a href="https://github.com/reobin/typewritten/commits?author=thbe" title="Code">💻</a></td>
    <td align="center"><a href="http://erikreinertsen.com"><img src="https://avatars2.githubusercontent.com/u/1253422?v=4" width="100px;" alt=""/><br /><sub><b>Erik Reinertsen</b></sub></a><br /><a href="https://github.com/reobin/typewritten/commits?author=erikr" title="Code">💻</a> <a href="https://github.com/reobin/typewritten/commits?author=erikr" title="Documentation">📖</a></td>
    <td align="center"><a href="https://twitter.com/artem_zin"><img src="https://avatars0.githubusercontent.com/u/967132?v=4" width="100px;" alt=""/><br /><sub><b>Artem Zinnatullin :slowpoke:</b></sub></a><br /><a href="https://github.com/reobin/typewritten/commits?author=artem-zinnatullin" title="Code">💻</a> <a href="https://github.com/reobin/typewritten/commits?author=artem-zinnatullin" title="Documentation">📖</a></td>
    <td align="center"><a href="https://nizarmah.me/"><img src="https://avatars1.githubusercontent.com/u/5631091?v=4" width="100px;" alt=""/><br /><sub><b>Nizar</b></sub></a><br /><a href="https://github.com/reobin/typewritten/commits?author=nizarmah" title="Code">💻</a></td>
    <td align="center"><a href="https://github.com/johnletey"><img src="https://avatars1.githubusercontent.com/u/62398724?v=4" width="100px;" alt=""/><br /><sub><b>John Letey</b></sub></a><br /><a href="https://github.com/reobin/typewritten/commits?author=johnletey" title="Documentation">📖</a></td>
    <td align="center"><a href="http://www.linkedin.com/in/ninja18"><img src="https://avatars2.githubusercontent.com/u/19199814?v=4" width="100px;" alt=""/><br /><sub><b>Niranjan</b></sub></a><br /><a href="https://github.com/reobin/typewritten/commits?author=ninja18" title="Code">💻</a></td>
  </tr>
  <tr>
    <td align="center"><a href="https://github.com/mrillusi0n"><img src="https://avatars1.githubusercontent.com/u/37063502?v=4" width="100px;" alt=""/><br /><sub><b>Nikhil</b></sub></a><br /><a href="#ideas-mrillusi0n" title="Ideas, Planning, & Feedback">🤔</a></td>
    <td align="center"><a href="http://tdeekens.name"><img src="https://avatars3.githubusercontent.com/u/1877073?v=4" width="100px;" alt=""/><br /><sub><b>Tobias Deekens</b></sub></a><br /><a href="#ideas-tdeekens" title="Ideas, Planning, & Feedback">🤔</a></td>
    <td align="center"><a href="https://xenoterracide.com"><img src="https://avatars3.githubusercontent.com/u/5517?v=4" width="100px;" alt=""/><br /><sub><b>Caleb Cushing</b></sub></a><br /><a href="#ideas-xenoterracide" title="Ideas, Planning, & Feedback">🤔</a></td>
    <td align="center"><a href="http://k.petrov4y@outlook.com"><img src="https://avatars2.githubusercontent.com/u/51177852?v=4" width="100px;" alt=""/><br /><sub><b>Konstantin Petrov</b></sub></a><br /><a href="https://github.com/reobin/typewritten/commits?author=eleven4y" title="Code">💻</a> <a href="https://github.com/reobin/typewritten/commits?author=eleven4y" title="Documentation">📖</a></td>
    <td align="center"><a href="https://rechtlogisch.de"><img src="https://avatars0.githubusercontent.com/u/2451083?v=4" width="100px;" alt=""/><br /><sub><b>Krzysztof Tomasz Zembrowski</b></sub></a><br /><a href="https://github.com/reobin/typewritten/commits?author=zembrowski" title="Documentation">📖</a></td>
    <td align="center"><a href="https://github.com/Ivan-Velickovic"><img src="https://avatars0.githubusercontent.com/u/10481259?v=4" width="100px;" alt=""/><br /><sub><b>Ivan Velickovic</b></sub></a><br /><a href="https://github.com/reobin/typewritten/commits?author=Ivan-Velickovic" title="Documentation">📖</a></td>
    <td align="center"><a href="https://github.com/barischrooneyj"><img src="https://avatars0.githubusercontent.com/u/6631452?v=4" width="100px;" alt=""/><br /><sub><b>Jeremy Barisch-Rooney</b></sub></a><br /><a href="#ideas-barischrooneyj" title="Ideas, Planning, & Feedback">🤔</a></td>
  </tr>
  <tr>
    <td align="center"><a href="https://github.com/oniGino"><img src="https://avatars3.githubusercontent.com/u/33404137?v=4" width="100px;" alt=""/><br /><sub><b>Gino</b></sub></a><br /><a href="https://github.com/reobin/typewritten/issues?q=author%3AoniGino" title="Bug reports">🐛</a></td>
    <td align="center"><a href="https://github.com/frdrk"><img src="https://avatars3.githubusercontent.com/u/3447600?v=4" width="100px;" alt=""/><br /><sub><b>frdrk</b></sub></a><br /><a href="https://github.com/reobin/typewritten/issues?q=author%3Afrdrk" title="Bug reports">🐛</a> <a href="#userTesting-frdrk" title="User Testing">📓</a></td>
    <td align="center"><a href="https://github.com/huy-ha"><img src="https://avatars0.githubusercontent.com/u/33562579?v=4" width="100px;" alt=""/><br /><sub><b>Huy Ha</b></sub></a><br /><a href="https://github.com/reobin/typewritten/issues?q=author%3Ahuy-ha" title="Bug reports">🐛</a> <a href="#userTesting-huy-ha" title="User Testing">📓</a></td>
    <td align="center"><a href="https://github.com/foruniverse"><img src="https://avatars3.githubusercontent.com/u/32241199?v=4" width="100px;" alt=""/><br /><sub><b>yanyan</b></sub></a><br /><a href="https://github.com/reobin/typewritten/commits?author=foruniverse" title="Code">💻</a></td>
  </tr>
</table>

<!-- markdownlint-enable -->
<!-- prettier-ignore-end -->
<!-- ALL-CONTRIBUTORS-LIST:END -->

This project follows the [all-contributors](https://github.com/all-contributors/all-contributors) specification. Contributions of any kind welcome!

## Inspiration

`pure` layout is inspired by [Pure](https://github.com/sindresorhus/pure)

