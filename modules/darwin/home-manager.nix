{ config, pkgs, lib, home-manager, ... }:

let
  user = "sean";
  sharedFiles = import ../shared/files.nix { inherit config pkgs; };
  additionalFiles = import ./files.nix { inherit user config pkgs; };
in
{
  imports = [
   ./dock
  ];

  programs.fish.enable = true;

  # It me
  users.knownUsers = [ user ];

  users.users.${user} = {
    uid = 501;
    name = "${user}";
    home = "/Users/${user}";
    isHidden = false;
    shell = pkgs.fish;
  };

  homebrew = {
    enable = true;
    brews = pkgs.callPackage ./brews.nix {};
    casks = pkgs.callPackage ./casks.nix {};
    onActivation.cleanup = "uninstall";
    onActivation = {
      autoUpdate = true;
      upgrade = true;
    };

    # These app IDs are from using the mas CLI app
    # mas = mac app store
    # https://github.com/mas-cli/mas
    #
    # $ nix shell nixpkgs#mas
    # $ mas search <app name>
    #
    # If you have previously added these apps to your Mac App Store profile (but not installed them on this system),
    # you may receive an error message "Redownload Unavailable with This Apple ID".
    # This message is safe to ignore. (https://github.com/dustinlyons/nixos-config/issues/83)
    masApps = {
      "1Blocker" = 1365531024;
      "1Password for Safari" = 1569813296;
      "Calca" = 635758264;
      "Calcbot" = 931657367;
      "Copilot" = 1447330651;
      "DaisyDisk" = 411643860;
      "DuckDuckGo Privacy for Safari" = 1482920575;
      "Gemini 2" = 1090488118;
      "Grammarly for Safari" = 1462114288;
      "hiddenbar" = 1452453066;
      "Hush Nag BLocker" = 1544743900;
      "Mapper for Safari" = 1589391989;
      "Name Mangler" = 603637384;
      "Paprika Recipe Manager 3" = 1303222628;
      "Pixelmator Pro" = 1289583905;
      "Prime Video" = 545519333;
      "reMarkable" = 1276493162;
      "Save to Matter" = 1548677272;
      "Save to Reader" = 1640236961;
      "Shapr3D" = 1091675654;
      "Spark Desktop" = 6445813049;
      "Speedtest" = 1153157709;
      "Stop the Madness" = 1376402589;
      "Tailscale" = 1475387142;
      "Windows App" = 1295203466; # Remote Desktop
    };

    extraConfig = ''
      vscode "1Password.op-vscode"
      vscode "bbenoist.Nix"
      vscode "bmalehorn.vscode-fish"
      vscode "eamodio.gitlens"
      vscode "esbenp.prettier-vscode"
      vscode "foxundermoon.shell-format"
      vscode "GitHub.copilot"
      vscode "GitHub.copilot-chat"
      vscode "GitHub.vscode-pull-request-github"
      vscode "ms-azuretools.vscode-docker"
      vscode "ms-kubernetes-tools.vscode-kubernetes-tools"
      vscode "redhat.java"
      vscode "redhat.vscode-yaml"
      vscode "tamasfe.even-better-toml"
      vscode "timonwong.shellcheck"
      vscode "vscjava.vscode-gradle"
      vscode "vscjava.vscode-spring-initializr"
    '';
  };

  # Enable home-manager
  home-manager = {
    useGlobalPkgs = true;
    users.${user} = { pkgs, config, lib, ... }:{
      home = {
        enableNixpkgsReleaseCheck = false;
        packages = pkgs.callPackage ./packages.nix {};
        file = lib.mkMerge [
          sharedFiles
          additionalFiles
        ];
        stateVersion = "24.05";
      };
      programs = {
        direnv = {
          enable = true;
          nix-direnv.enable = true;
        };
      } // import ../shared/home-manager.nix { inherit config pkgs lib; };

      # Marked broken Oct 20, 2022 check later to remove this
      # https://github.com/nix-community/home-manager/issues/3344
      manual.manpages.enable = false;
    };
  };

  # Fully declarative dock using the latest from Nix Store
  local.dock.enable = false;
  local.dock.entries = [
    { path = "/Applications/Slack.app/"; }
    { path = "/System/Applications/Messages.app/"; }
    {
      path = "${config.users.users.${user}.home}/.local/share/";
      section = "others";
      options = "--sort name --view grid --display folder";
    }
    {
      path = "${config.users.users.${user}.home}/.local/share/downloads";
      section = "others";
      options = "--sort name --view grid --display stack";
    }
  ];

}
