{ config, pkgs, ... }:

{
  home.username = "heehaw";
  home.homeDirectory = "/home/heehaw";

  home.stateVersion = "24.05"; # Please read the comment before changing.
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

    home.packages = [
    pkgs.htop
  ];

  # home-manager.sharedModules = [{
  # stylix.targets.xyz.enable = false;
  # }];

  # targets.btop.enable = true;
  # stylix.targets.kde.enable = true;


}
