{ pkgs, ... }:

{
  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages =
    [
      pkgs.home-manager
      pkgs.fish
    ];

  # Use a custom configuration.nix location.
  # $ darwin-rebuild switch -I darwin-config=$HOME/.config/nixpkgs/darwin/configuration.nix
  #environment.darwinConfig = "$HOME/Code/github.com/seanb4t/nix-config/darwin";

  environment.shells = [
    pkgs.fish
    pkgs.zsh
  ];

  # Auto upgrade nix package and the daemon service.
  nix = {
    package = pkgs.nix;
    settings = {
      "extra-experimental-features" = [ "nix-command" "flakes" ];
    };
  };

  # Create /etc/zshrc that loads the nix-darwin environment.
  programs = {
    gnupg.agent.enable = true;
    zsh.enable = true;  # default shell on catalina
    fish.enable = true;
    direnv.enable = true;
    man.enable = true;
  };

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 5;

  fonts.packages = [
    pkgs.atkinson-hyperlegible
    pkgs.jetbrains-mono
  ];

  services = {
    nix-daemon.enable = true;
    yabai = {
      enable = false;
      config = {
        layout = "bsp";
        mouse_modifier = "ctrl";
        mouse_drop_action = "stack";
        window_shadow = "float";
        window_gap = "20";
      };
      extraConfig = ''
        yabai -m signal --add event=display_added action="yabai -m rule --remove label=calendar && yabai -m rule --add app='Fantastical' label='calendar' display=east" active=yes
        yabai -m signal --add event=display_removed action="yabai -m rule --remove label=calendar && yabai -m rule --add app='Fantastical' label='calendar' native-fullscreen=on" active=yes
        yabai -m rule --add app='OBS' display=east
        yabai -m rule --add app='Spotify' display=east

        yabai -m rule --add app='Cardhop' manage=off
        yabai -m rule --add app='Pop' manage=off
        yabai -m rule --add app='System Settings' manage=off
        yabai -m rule --add app='Timery' manage=off
      '';
    };
    jankyborders = {
      enable = true;
      blur_radius = 5.0;
      hidpi = true;
      active_color = "0xAAB279A7";
      inactive_color = "0x33867A74";
    };
    tailscale = {
      enable = true;
    };
  };

  homebrew = {
    enable = true;

    casks = [
      "1password"
      "betterdisplay"
      "brave-browser"
      "cleanmymac"
      "discord"
      "fantastical"
      "hammerspoon"
      "jetbrains-toolbox"
      "karabiner-elements"
      "keycastr"
      "obsidian"
      "orbstack"
      "raycast"
      "soundsource"
      "spotify"
      "visual-studio-code"
      "wezterm"
      "zoom"
    ];

    masApps = {
      "Tailscale" = 1475387142;
      "Windows App" = 1295203466; # Remote Desktop
      #"Drafts" = 1435957248;
      #"Reeder" = 1529448980;
      #"Things" = 904280696;
      #"Timery" = 1425368544;
    };
  };

  system = {
    defaults = {
      dock = {
        autohide = true;
        orientation = "bottom";
        magnification = true;
        tilesize = 16;
        largesize = 96;
        #show-process-indicators = false;
        #show-recents = false;
        #static-only = true;
      };
      finder = {
        #AppleShowAllExtensions = true;
        FXDefaultSearchScope = "SCcf";
        #FXEnableExtensionChangeWarning = false;
        ShowPathbar = true;
      };
      loginwindow = {
        SHOWFULLNAME = true;
        GuestEnabled = false;
      };
      menuExtraClock = {
        ShowAMPM = false;
        Show24Hour = true;
      };
      NSGlobalDomain = {
        #AppleKeyboardUIMode = 3;
        #"com.apple.keyboard.fnState" = true;
        #NSAutomaticWindowAnimationsEnabled = false;
      };
    };
    keyboard = {
      enableKeyMapping = true;
      remapCapsLockToControl = true;
    };
  };
  security = {
    pam = {
      enableSudoTouchIdAuth = true;
    };
  };
  networking = {
    computerName = "denver";
    hostName = "denver";
    localHostName = "denver";
  };
}
