<!-- markdownlint-disable MD033 MD041-->
<p align="right">last edit: 2026-04-14</p>
<!-- markdownlint-enable  MD033 MD041-->

# Visual Studio Code

## Flavors of Visual Studio (Code)

### [Visual Studio](https://visualstudio.microsoft.com/downloads/)

- Proprietary IDE developed by Microsoft (only Windows)
- <https://en.wikipedia.org/wiki/Visual_Studio>

### [Visual Studio Code](https://code.visualstudio.com/Download) (VS Code)

- Proprietary (based on open source) code editor (Windows, macOS and Linux)
- Visual Studio Code [Docs](https://code.visualstudio.com/docs),
  [Extensions](https://marketplace.visualstudio.com/VSCode) or [GitHub](https://github.com/microsoft/vscode)
- <https://en.wikipedia.org/wiki/Visual_Studio_Code>
- <https://wiki.archlinux.org/title/Visual_Studio_Code>

### <https://vscode.dev/>

- [Visual Studio Code for the Web](https://code.visualstudio.com/docs/setup/vscode-web) (browser-based version)

### [VSCodium](https://vscodium.com/)

- Open source software binaries (binary builds only) of VS Code (Windows, macOS and Linux)
- Some language extensions developed by Microsoft (for example
  [ms-vscode.cpptools](https://marketplace.visualstudio.com/items?itemName=ms-vscode.cpptools)) now strictly require the
  proprietary Visual Studio Code release to work
- [vscodium-deb-rpm-repo repository](https://gitlab.com/paulcarroty/vscodium-deb-rpm-repo) is "one man show" repo

## Visual Studio Code (VS Code) on Linux

- VS Code docs: [Setting up Visual Studio Code](https://code.visualstudio.com/docs/setup/setup-overview),
  [Visual Studio Code on Linux](https://code.visualstudio.com/docs/setup/linux)
- repository [`/etc/yum.repos.d/vscode.repo`](https://github.com/musinsky/config/blob/master/yum.repos.d/vscode.repo)
  (common for Fedora/RHEL)
- `$ dnf5 --repo=vscode repoquery --latest-limit=1`
- supported architectures: `aarch64`, `armv7hl`, `x86_64` (platform/distribution: `el8`)
- `code-exploration` (early preview) → `code-insiders` (preview, early access) → **`code`** (stable, weekly)

```console
$ code --transient
State is temporarily stored. Relaunch this state with: code --user-data-dir "/tmp/vscode-LOq2Yb03/data" --extensions-dir "/tmp/vscode-LOq2Yb03/extensions"
```

## Extensions

<!-- markdownlint-disable MD038 MD060-->
| `publisher.name` | Description |
| ---------------- | ----------- |
| `ms-vscode.cpptools-extension-pack` | [C/C++ Extension Pack](https://marketplace.visualstudio.com/items?itemName=ms-vscode.cpptools-extension-pack) (of 4 extensions) |
| `  ms-vscode.cpptools`        | [C/C++](https://marketplace.visualstudio.com/items?itemName=ms-vscode.cpptools) |
| `  ms-vscode.cpptools-themes` | [C/C++ Themes](https://marketplace.visualstudio.com/items?itemName=ms-vscode.cpptools-themes) |
| `  ms-vscode.cpp-devtools`    | [C/C++ DevTools](https://marketplace.visualstudio.com/items?itemName=ms-vscode.cpp-devtools) |
| `  ms-vscode.cmake-tools`     | [CMake Tools](https://marketplace.visualstudio.com/items?itemName=ms-vscode.cmake-tools) |
| `ms-vscode.makefile-tools` | [Makefile Tools](https://marketplace.visualstudio.com/items?itemName=ms-vscode.makefile-tools) |
| `ms-vscode-remote.remote-ssh`      | [Remote - SSH](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-ssh) |
| `ms-vscode-remote.remote-ssh-edit` | [Remote - SSH: Editing Configuration Files](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-ssh-edit) |
| `ms-vscode.remote-explorer`        | [Remote Explorer](https://marketplace.visualstudio.com/items?itemName=ms-vscode.remote-explorer) |
| `DavidAnson.vscode-markdownlint`         | [markdownlint](https://marketplace.visualstudio.com/items?itemName=DavidAnson.vscode-markdownlint) |
| `bierner.markdown-preview-github-styles` | [Markdown Preview Github Styling](https://marketplace.visualstudio.com/items?itemName=bierner.markdown-preview-github-styles) |
| `mkhl.shfmt`           | [shfmt](https://marketplace.visualstudio.com/items?itemName=mkhl.shfmt) |
| `timonwong.shellcheck` | [ShellCheck](https://marketplace.visualstudio.com/items?itemName=timonwong.shellcheck) |
| `esbenp.prettier-vscode` | [Prettier - Code formatter](https://marketplace.visualstudio.com/items?itemName=esbenp.prettier-vscode) |
| `dnut.rewrap-revived` | [Rewrap Revived](https://marketplace.visualstudio.com/items?itemName=dnut.rewrap-revived) |
| `vscode-icons-team.vscode-icons` | [vscode-icons](https://marketplace.visualstudio.com/items?itemName=vscode-icons-team.vscode-icons) |
<!-- markdownlint-enable  MD038 MD060-->

| `publisher.name` | Description |
| ---------------- | ----------- |
| `foxundermoon.shell-format` | [shell-format](https://marketplace.visualstudio.com/items?itemName=foxundermoon.shell-format) (nefunkcne) |
| `jeff-hykin.better-shellscript-syntax` | [Better Shell Syntax](https://marketplace.visualstudio.com/items?itemName=jeff-hykin.better-shellscript-syntax) (zbytocne) |

```plain
$ code --install-extension ms-vscode-remote.remote-ssh \
       --install-extension ms-vscode.remote-explorer
```
