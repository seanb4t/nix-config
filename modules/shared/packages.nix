{ pkgs }:

with pkgs; [
  # General packages for development and system management
  aspell
  aspellDicts.en
  bash-completion
  bat
  bottom
  btop
  coreutils
  delta
  fish
  gh
  git
  git-lfs
  grc
  killall
  neofetch
  openssh
  sqlite
  wget
  zip
  zsh

  # Encryption and security tools
  _1password-cli
  age
  age-plugin-yubikey
  gnupg
  libfido2

  # Cloud-related tools and SDKs

  # Media-related packages
  dejavu_fonts
  ffmpeg
  fd
  font-awesome
  hack-font
  noto-fonts
  noto-fonts-emoji
  meslo-lgs-nf

  # Node.js development tools
  nodePackages.npm # globally install npm
  nodePackages.prettier
  nodejs

  # Text and terminal utilities
  chezmoi
  eza
  fzf
  htop
  hunspell
  iftop
  jetbrains-mono
  jq
  restic
  ripgrep
  starship
  tree
  tmux
  unrar
  unzip
  zsh-powerlevel10k

  # Python packages
  # python39
  # python39Packages.virtualenv # globally install virtualenv
]
