## Windows

`cd %localappdata%`

`git clone --recurse-submodules git@github.com:kqtran-dev/nvim.git`

### dependencies

`scoop install neovim`
`scoop install fd`
`scoop install fzf`
`scoop install jq`
`scoop install ripgrep`
`scoop install rustup`
`winget install Microsoft.VisualStudio.2022.BuildTools --force --override "--wait --passive --add Microsoft.VisualStudio.Component.VC.Tools.x86.x64 --add Microsoft.VisualStudio.Component.Windows10SDK"`


## Linux
`stow -d ~/.config -t ~ nvim`

If using AppImage:

dlopen(): error loading libfuse.so.2

AppImages require FUSE to run.

`sudo apt install fuse libfuse2`

### requirements
#### mason
`sudo apt install npm`
`sudo apt install make`
`sudo apt install nodejs`

#### telescope
`sudo apt install clang`

#### obsidian
`sudo apt install ripgrep`
