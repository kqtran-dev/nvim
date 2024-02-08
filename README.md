## Windows

`cd %localappdata%`

`git clone --recurse-submodules git@github.com:kqtran-dev/nvim.git`

### dependencies

#### telescope

`winget install Microsoft.VisualStudio.2022.BuildTools --force --override "--wait --passive --add Microsoft.VisualStudio.Component.VC.Tools.x86.x64 --add Microsoft.VisualStudio.Component.Windows10SDK"`

`winget install sharkdp.fd`

`winget install BurntSushi.ripgrep.MSVC`

## Linux
`stow -d ~/.config -t ~ nvim`

If using AppImage:

dlopen(): error loading libfuse.so.2

AppImages require FUSE to run.

`sudo apt install fuse libfuse2`

### dependencies
#### telescope
`sudo apt install clang`

#### obsidian
`sudo apt install ripgrep`
