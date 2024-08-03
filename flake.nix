{
  description = "A very basic flake";

  inputs = {
    nixpkgs = {
      url = "github:nixos/nixpkgs/nixos-unstable";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # agenix = {
    #   url = "github:ryantm/agenix";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };

    # nixos-hardware.url = "github:NixOS/nixos-hardware/master";

    # deploy-rs.url = "github:serokell/deploy-rs";

    nix-doom-emacs-unstraightened.url = "github:marienz/nix-doom-emacs-unstraightened";

    stylix = {
      url = "github:danth/stylix";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        #home-manager.follows = "home-manager";
      };
    };

  };

  outputs = { self, nixpkgs, home-manager, ... } @ inputs:
  let
    pkgs = nixpkgs.legacyPackages.x86_64-linux;
  in
  {

    packages.x86_64-linux.hello = pkgs.hello;

    packages.x86_64-linux.default = self.packages.x86_64-linux.hello;

    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      specialArgs = { inherit inputs; };
      modules = [
        ./configuration.nix
        # home-manager.nixosModules.home-manager
        #   {
        #     home-manager.useGlobalPkgs = true;
        #     home-manager.useUserPackages = true;
        #     home-manager.users.heehaw = import ./home.nix;
        #     home-manager.backupFileExtension = "backup";
        #     home-manager.extraSpecialArgs = { inherit inputs; };

        #     # Optionally, use home-manager.extraSpecialArgs to pass
        #     # arguments to home.nix
        #   }
        inputs.stylix.nixosModules.stylix
      ];
    };
  };
}
