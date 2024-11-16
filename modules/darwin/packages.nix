{ pkgs }:

with pkgs;
let shared-packages = import ../shared/packages.nix { inherit pkgs; }; in
shared-packages ++ [
  dockutil
  httpie
  lazygit
  markdown-oxide
  mas
  nerdfonts
  ollama
]
