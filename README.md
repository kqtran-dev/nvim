## Windows

`cd %localappdata%`

`git clone --recurse-submodules git@github.com:kqtran-dev/nvim.git`

### dependencies

#### telescope

`winget install sharkdp.fd`
`winget install BurntSushi.ripgrep.MSVC`

## Linux
`stow -d ~/.config -t ~ nvim`

### dependencies
#### telescope
`sudo apt install clang`

#### obsidian
`sudo apt install ripgrep`
