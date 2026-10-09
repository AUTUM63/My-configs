{
	description = "My system configurations";
	inputs = {
		nixpkgs.url = "github:nixos/nixpkgs/nixos-26.05";
		nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
	  
		home-manager = {
				url = "github:nix-community/home-manager/release-26.05";
				inputs.nixpkgs.follows = "nixpkgs";
		};
		
		firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
    };
		
		
	};
	outputs = { nixpkgs, home-manager, self, firefox-addons, ... } @inputs:
		let
			system = "x86_64-linux";
			outputs = self;
		in {
		  nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [ 
          ./configuration.nix
        home-manager.nixosModules.home-manager
                {
                    home-manager.useUserPackages = true;
                    home-manager.useGlobalPkgs = true;
                    home-manager.users.pepe = import ./home-manager/home.nix;
										home-manager.backupFileExtension = "backup";

                }
        ];
        specialArgs = {
          inherit inputs outputs;
        };
		  };	
		
		};
}
