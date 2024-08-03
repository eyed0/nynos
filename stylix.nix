{
  pkgs,
  inputs,
  ...
}: {
  stylix.enable = true;
  stylix.image = ./wall/min_forest.jpg;
  stylix.polarity = "dark";
  stylix.targets.nixos-icons.enable = true;
  stylix.targets.gtk.enable = true;
  stylix.targets.fish.enable = true;
  stylix.base16Scheme = "${pkgs.base16-schemes}/share/themes/kanagawa.yaml";
  stylix.fonts = {
    serif = {
      package = pkgs.alegreya;
      name = "Alegreya";
    };

    sansSerif = {
      package = pkgs.atkinson-hyperlegible;
      name = "Atkinson Hyperlegible";
    };

    monospace = {
      package = pkgs.nerdfonts.override {fonts = ["SpaceMono"];};
      name = "SpaceMono Nerd Font";
    };

    emoji = {
      package = pkgs.noto-fonts-emoji;
      name = "Noto Color Emoji";
    };
  };

  stylix.cursor.package = pkgs.bibata-cursors;
  stylix.cursor.name = "Bibata-Modern-Ice";
}
