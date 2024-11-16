{ config, pkgs, lib, ... }:

let name = "Sean Brandt";
    user = "sean";
    email = "4678+seanb4t@users.noreply.github.com"; in
{
  # Shared shell configuration
  # fish = {
  #   enable = true;
  # };

  zsh = {
    enable = true;
    autocd = false;

    initExtraFirst = ''
      if [[ -f /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh ]]; then
        . /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh
        . /nix/var/nix/profiles/default/etc/profile.d/nix.sh
      fi

      # Define variables for directories
      export PATH=$HOME/.pnpm-packages/bin:$HOME/.pnpm-packages:$PATH
      export PATH=$HOME/.npm-packages/bin:$HOME/bin:$PATH
      export PATH=$HOME/.local/share/bin:$PATH

      # Remove history data we don't want to see
      export HISTIGNORE="pwd:ls:cd"

      # # Emacs is my editor
      # export ALTERNATE_EDITOR=""
      # export EDITOR="emacsclient -t"
      # export VISUAL="emacsclient -c -a emacs"

      # e() {
      #     emacsclient -t "$@"
      # }

      # nix shortcuts
      shell() {
          nix-shell '<nixpkgs>' -A "$1"
      }

      # Use difftastic, syntax-aware diffing
      alias diff=difft

      # Always color ls and group directories
      alias ls='ls --color=auto'
    '';
  };

  # git = {
  #   enable = true;
  #   lfs = {
  #     enable = true;
  #   };
  # };

  # neovim = {
  #   enable = true;
  # };
  
  # ssh = {
  #   enable = true;
  # };

  # tmux = {
  #   enable = true;
  # };
}
